require "chttp"

webhooks = webhooks or {}
webhooks.active = webhooks.active or {}

webhooks.register = function( name, url )
	webhooks.active[ name ] = { url = url } -- PrintTable = death
end

webhooks.send = function( name, data )
	local url = webhooks.active[ name ]
	if not url then print "no webhook" return end
	
	CHTTP {
		url = url.url,
		method = "POST",
		headers = {
			["Content-Type"] = "application/json",
		},
		type = "application/json",
		body = util.TableToJSON( data )
	}
end

--[[
webhooks.register( "test", "url-hook" )
webhooks.send( "test", {
	content = "test",
	embeds = {
		{
			title = "wef"
		}
	}
} )
]]