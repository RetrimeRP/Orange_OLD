local IP = "46.174.53.241:27015"
local HOST = "46.174.53.241"
local LOCALHOST = "localhost"

require( "bromsock" )

--

local function sPrint( ... )
	if AKSY.socket.debug then
		(_print or print)( "[SOCKET] " .. table.concat( { ... }, ", " ) )
	end
end

local function readNumber( packet, n )
	local res = 0
	for i = 1, n do
		res = bit.lshift(res, 8) + packet:ReadByte()
	end
	return res
end

local function writeNumber( packet, data, n )
	for i = 1, n do
		packet:WriteByte(bit.ror(data, (n-i)*8))
	end
end

local function writeDataSize( packet, data_size )
    local data_size_basic
	local data_size_extended

	local mask = 0x80
	local max_size = 2^64

	if data_size < 126 then
		data_size_basic = data_size 
	elseif data_size >= 126 then
		data_size_basic = 126 
		data_size_extended = data_size
	end

	packet:WriteByte( mask + data_size_basic ) 
	if data_size_extended then 
		writeNumber( packet, data_size_extended, 2 )
	end
end

local function writeMask( packet, mask )
    for i = 1, 4 do 
        packet:WriteByte( mask[i] )
    end
end

local function writeDataEncoded( packet, data, mask )
	--[[
	for i = 1, #data do
		local byte = string.byte(data[i])
        packet:WriteByte( bit.bxor( byte, mask[((i-1)%4)+1] ) )
	end]]

	for i = 1, #data do
        packet:WriteByte( string.byte(data[i]) )
	end
end

local mask = {0, 0, 0, 0}
local function createMask()
	--[[
	local mask = {}
	for i = 1, 4 do 
		mask[i] = math.random( 255 )
	end
	return mask
	]]

	return mask
end

local function writePackage( packet, data )
	packet:WriteByte(0x80 + 0x1)
	writeDataSize( packet, #data )

	local mask = createMask() 
	writeMask( packet, mask )
	writeDataEncoded( packet, data, mask )    

	return packet
end





local stateConnect -- Подключаемся к хосту
local stateSocket -- Создаем сокет
local stateHeader -- Ждем сообщения
local stateLength -- Считываем длинну сообщения
local stateData -- Читаем сообщение 



-- Читаем сообщение 
local message = ""
local function stateDataCallback( socket, packet )

	local messageChunk = packet:ReadStringAll()
	message = string.format( "%s%s", message, messageChunk )
	stateHeader( socket )

	if string.sub( message, message:len() - 1 ) == "\r\n" then
		local _message = message
		message = ""

		_message = string.sub( _message, 1, _message:len() - 2 )
		sPrint( "Received message: '" .. _message .. "'" )

		local sep = string.find( _message, "|", 1, true )
		local name = string.sub( _message, 1, sep-1 ) 
		local data = string.sub( _message, sep+1 ) 
		local token

		sep = string.find( name, ":", 1, true )
		if sep then 
			token = string.sub( name, sep+1 )
			name = string.sub( name, 1, sep-1 )
		end 

		if AKSY.socket.callbacks[name] then
			if token then 
				local result = AKSY.socket.callbacks[name]( data )
				AKSY.socket:Send( name .. ":" .. token, istable( result ) and util.TableToJSON( result ) or result )
			else 
				AKSY.socket.callbacks[name]( data )
			end
		else 
			sPrint( "Received message without registered callback: '" .. name .. "'" )
		end
	end
end
function stateData( socket, length )
	socket:SetCallbackReceive( stateDataCallback )
	socket:Receive( length )
end


-- Считываем длинну сообщения
local function stateLengthCallback( socket, packet )
	stateData( socket, readNumber( packet, packet:InSize() ) )
end 
function stateLength( socket, length )
	socket:SetCallbackReceive( stateLengthCallback )
	socket:Receive( length )
end 


-- Пинг
function statePing( socket )
	AKSY.socket.ping = RealTime()
	stateHeader( socket )
end


-- Ждем сообщения
local function stateHeaderCallback( socket, packet )
	local byte_1, byte_2 = packet:ReadByte(), packet:ReadByte()
	local data_length = byte_2 > 127 and byte_2 - 128 or byte_2

	if byte_1 > 127 then 
		local opcode = byte_1 - 128
		if opcode <= 15 then
			if opcode == 0x8 then
				socket:Close()
				return
			elseif opcode == 0x9 then
				statePing( socket )
				return
			end	
		end
	end

	if data_length >= 126 then 
		stateLength( socket, data_length == 126 and 2 or 8 )
	else 
		stateData( socket, data_length )
	end
end

function stateHeader( socket )
	socket:SetCallbackReceive( stateHeaderCallback )
	socket:Receive( 2 )
end


-- Создаем сокет
local function verifySocket( data )
	local lines = string.Explode( "\r\n", data )
	local first_line = table.remove( lines, 1 )
	local headers = {}

	for i, line in pairs( lines ) do 
		local sep = string.find( line, ":", 1, true )
		if sep and sep > 0 then 
			local key = string.lower( string.Trim( string.sub( line, 1, sep-1 ) ) )
			local value = string.lower( string.Trim( string.sub( line, sep+1 ) ) )
			headers[key] = value
		end
	end

	-- HTTP версия
	if first_line ~= "HTTP/1.1 101 Switching Protocols" then
		return false
	end

	-- Проверяем header`ы
	if not headers.connection or not string.find( headers.connection, "upgrade", 1, true ) then 
		return false
	end
	if not headers.upgrade or not string.find( headers.upgrade, "websocket", 1, true ) then 
		return false 
	end

	return true
end

local function stateSocketCallback( socket, packet )
	local data = packet:ReadStringAll():Trim()
	if verifySocket( data ) then
		sPrint( "Socket created" )
		AKSY.socket.valid = true
		AKSY.socket.ping = RealTime()
		stateHeader( socket )
	else 
		sPrint( "Failed to create socket, try again after 5 sec" )
		timer.Create( "aksy:socket", 5, 1, stateConnect )
	end
end


local charset = {}  
for c = 48, 57  do table.insert(charset, string.char(c)) end
for c = 65, 90  do table.insert(charset, string.char(c)) end
for c = 97, 122 do table.insert(charset, string.char(c)) end

local function createKey()
	local chars = {}
	for i = 1, 16 do 
		chars[i] = charset[math.random(1, #charset)]
	end	
	return util.Base64Encode( table.concat( chars ) )
end

function stateSocket( socket )
	socket:SetCallbackReceive( stateSocketCallback ) 
	
	local host = game.GetIPAddress() == IP and HOST or LOCALHOST
	--local host = HOST

	local packet = BromPacket()
    packet:WriteLine "GET / HTTP/1.1"
    packet:WriteLine( "Host: " .. host )
    packet:WriteLine( "Sec-WebSocket-Key: " .. createKey() )
    packet:WriteLine "Sec-WebSocket-Version: 13"
	packet:WriteLine "Connection: Upgrade"
	packet:WriteLine "Upgrade: websocket"
	packet:WriteLine ""

    socket:Send( packet, true )
	socket:ReceiveUntil "\r\n\r\n"
end


-- Подключаемся к хосту
local function stateDisconnectCallback( socket )
	sPrint "Lost connection"
	AKSY.socket.valid = false
	stateConnect()
end

local function stateConnectCallback( socket, success )
	if success then
		sPrint( "Connected" )

		socket:SetTimeout( 600 * 1000 )
		socket:SetCallbackDisconnect( stateDisconnectCallback )

		stateSocket( socket )
	else 
		sPrint( "Failed to connect, try again after 5 sec" )
		timer.Create( "aksy:socket", 5, 1, stateConnect )
	end
end	

local nofunc = function()end
function stateConnect()
	if AKSY.socket.bromsock then 
		local oldSocket = AKSY.socket.bromsock
		oldSocket:SetCallbackReceive( nofunc )
		oldSocket:SetCallbackConnect( nofunc )
		oldSocket:SetCallbackDisconnect( nofunc )
		oldSocket:Close()
	end

	local socket = BromSock()
	AKSY.socket.bromsock = socket
	socket:SetCallbackConnect( stateConnectCallback )

	local host, port 
	if game.GetIPAddress() == IP then 
		host = HOST
		port = 8081
	else
		host = LOCALHOST
		port = 8081
	end

	sPrint( "Connecting to " .. host .. ":" .. port )
	socket:Connect( host, port )
end

-- Функции сокета
AKSY.socket = AKSY.socket or { callbacks = {} }
AKSY.socket.valid = false

function AKSY.socket:AddCallback( name, callback )
	self.callbacks[name] = callback
end

function AKSY.socket:Send( name, data )
	if not data then return end
	
	if self.valid then 
		local messageData = name .. "|" .. data
		local packetData = messageData .. "\r\n"
		local chunkSize = 256
		local chunks = math.ceil( packetData:len() / chunkSize )
		local packet = BromPacket()

		for i = 1, chunks do 
			local chunk = string.sub( packetData, (i-1) * chunkSize + 1, i * chunkSize )
			writePackage( packet, chunk )
			self.bromsock:Send( packet, true )
			packet:Clear()
		end

		sPrint( string.format( "Sended message [%s]: '%s'", chunks, messageData ) )
	end
end

hook.Add( "Think", "aksy:socket", function()
	if AKSY.socket.valid and RealTime() - AKSY.socket.ping >= 3 then 
		sPrint( "Lost connection" )
		AKSY.socket.valid = false
		stateConnect()
	end 
end )


-- Консольные комманды
concommand.Add( "socket_reconnect", function( ply )
	if not IsValid( ply ) then 
		stateConnect() 
	end
end )

concommand.Add( "socket_debug", function( ply, _, args )
	if not IsValid( ply ) then
		AKSY.socket.debug = tonumber(args[1]) == 1 
		print( "Debug " .. (AKSY.socket.debug and "enabled" or "disabled") )
	end
end )

-- Запуск
timer.Create( "aksy:socket", 1, 1, stateConnect )