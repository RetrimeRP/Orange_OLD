-- xbyte

ugolochek.screenshot = {}

ugolochek.screenshot.quality = 50
ugolochek.screenshot.key = ""

--

local function takeScr( x, y, w, h, q )
    local data = util.Base64Encode( render.Capture( { x = x, y = y, w = w, h = h, format = "jpeg", quality = q } ) )
    
    HTTP {	
        success = function( code, body )
            if code == 200 then
                net.Start( "ugolochek_scr:send" )
                    net.WriteString( util.JSONToTable( body ).data.link )
                net.SendToServer()
            else 
                net.Start( "ugolochek_scr:send" )
                    net.WriteString( "fail" )
                net.SendToServer()
            end
        end,
        
        method = "POST",
        url = "https://api.imgur.com/3/image",
        headers = { Authorization = "Client-ID 04507c4eca24897" },
        body = data
    }
end

--

ugolochek.screenshot.takeServer = function( x, y, w, h, q )
    hook.Add( "PostRender", "screenshot", function()
        hook.Remove( "PostRender", "screenshot" )

        takeScr( x, y, w, h, q )
    end )
end

--

net.Receive( "ugolochek_scr:take", function()
    ugolochek.screenshot.takeServer( 0, 0, ScrW(), ScrH(), net.ReadFloat() )
end )