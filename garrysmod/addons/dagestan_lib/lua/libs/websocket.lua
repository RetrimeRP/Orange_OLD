--[[ -- OLD
require "gwsockets"

local SECRET = gametokens.ws

UWS = UWS or {
    Events = {}
}

--

local function autoReconnect()
	print "`UWS: Auto-Reconnecting in 5 seconds..`"

	timer.Create( "UWS:auto_reconnect", 5, 1, function()
		print "`UWS: Auto-Recconecting..`"
	
		UWS.WebSocket:open()
	end )
end

--

if UWS.WebSocket != nil and UWS.WebSocket:isConnected() then
	UWS.WebSocket.AutoReconnect = false
	UWS.WebSocket:close()
end

UWS.Connect = function()
    timer.Remove "UWS:auto_reconnect"

    UWS.WebSocket = GWSockets.createWebSocket "ws://62.122.214.213:8228/"
    UWS.WebSocket.AutoReconnect = true
    UWS.WebSocket:setHeader( "authorization", SECRET )
        
    UWS.WebSocket.onConnected = function( self )
        print "`UWS[FROM-S]: Succesfully connected to UWS`"
    end
        
    UWS.WebSocket.onMessage = function( self, msg )
        local json = util.JSONToTable( msg )
        
        if json == nil then
            print "`UWS[FROM-WEB]: Failed to parse json!`"

            return
        end
            
        local event = UWS.Events[ json.event ]
            
        if event ~= nil then
            event( json.data )
        else
            print( "`Tried to call an unknown event: " .. json.event .. "`" )
                
            self:close()
        end
    end

    --
        
    UWS.WebSocket.onError = function( self, err )
        print( "`UWS: Error occured: " .. err .. "`" )

        if not self:isConnected() and self.AutoReconnect then
            autoReconnect()
        end
    end
        
    UWS.WebSocket.onDisconnected = function( self )
        print "`UWS: Disconnected`"
            
        if self.AutoReconnect then
            autoReconnect()
        end
    end
        
    print "`UWS: Connecting..`"
    UWS.WebSocket:open()
end

--

UWS.Send = function( type, data )
	if UWS.WebSocket == nil or not UWS.WebSocket:isConnected() then
		print( "`UWS: Socket is not connected! (E-" .. type .. ")`" )

		return false
	end

	local json = util.TableToJSON( {
		type = type,
		data = data
	} )
	
	UWS.WebSocket:write( json )

	return true
end

UWS.AddEvent = function( name, func )
    UWS.Events[ name ] = func
end

-- timer.Create( "UWS:connect", 5, 1, UWS.Connect )
]]

-- NEW

local tag = "websocket"

require "gwsockets"

--

websocket = wesocket or {}
websocket.ws = websocket.ws or nil
websocket.events = websocket.events or {}

local ws = websocket.ws
local initialized = false

--

function websocket.Connect()
	if initialized then ws:close() end
	
	ws = GWSockets.createWebSocket( gametokens.socket.url, false ) websocket.ws = ws
	ws:SetHeaders( "password", gametokens.socket.password )
	ws:open()
	
	--
	
	ws.onConnected = function( self )
		initialized = true
		
		hook.Run( tag .. ":connected" )
	end
	
	ws.onDisconnected = function( self )
		initialized = false
		
		hook.Run( tag .. ":disconnected" )
	end
	
	--
	
	ws.onError = function( self, err )
		print( "websocket-error: " .. err )
		
		hook.Run( tag .. ":error", err )
	end
	
	ws.onMessage = function( self, msg )
		hook.Run( tag .. ":message", msg )
		
		--
		
		-- if not isstring( msg ) then return end -- ??
		
		local data = util.JSONToTable( msg )
		local func = websocket.events[ data.key ]
		
		if not func then return end
		func( data.data )
	end
end

function websocket.Disconnect()
	if not initialized then return error "trying to close websocket, when it's already closed!" end
	
	ws:close()
end

--

function websocket.Send( key, data )
	if not initialized then return error "trying to send an unknown event!" end
	
	local tosend = util.TableToJSON {
		key = key,
		data = data
	}
	
	ws:send( tosend )
end

function websocket.AddEvent( key, func )
	websocket.events[ key ] = func
end

--

function websocket.Initialized()
	return initialized	
end

--

hook.Add( "Initialize", tag, function()
	hook.Remove( "Initialize", tag )
	
	-- websocket.Connect()
end )