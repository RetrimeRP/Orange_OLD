local Socket = AKSY.socket
local queue = {}

ugolochek.log = {}

ugolochek.log.discordlog = function( id, color, title, text )
	table.insert( queue, {
		msg = "_embed",
		id = id or "813382642019467304",
		color = color or "#8dddff",

		title = title or "UNKNOWN",
		text = text or "FAILED"
	} )
end

ugolochek.log.discordtext = function( id, text )
	table.insert( queue, {
		msg = "",
		id = id or "813382642019467304",
		text = text or "FAILED"
	} )
end


timer.Create( "ugolochek_ulxlogs:send", 2.5, 0, function()
	if not table.IsEmpty( queue ) then
		local dat = queue[1]
		Socket:Send( "serverMessage" .. dat.msg, util.TableToJSON( dat ) )
			
		table.remove( queue, 1 )
	end
end )
