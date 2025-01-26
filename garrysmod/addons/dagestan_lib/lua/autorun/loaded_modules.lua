ui = ui or {}
pt = {}
local FileCl = SERVER and AddCSLuaFile or include

if SERVER then
--	resource.AddWorkshop('2924839375') -- Font
--	resource.AddWorkshop('2878418292')
resource.AddFile( "materials/clos.png" )
resource.AddFile( "materials/setting.png" )
resource.AddFile( "materials/" )

end

FileCl('s_ui/colors.lua')
FileCl('s_ui/util.lua')
FileCl('s_ui/theme.lua')

local files_vgui, _ = file.Find('s_ui/vgui/*.lua', 'LUA')

for fileID = 1, #files_vgui do
	FileCl('s_ui/vgui/' .. files_vgui[fileID])
end

local files_mod, _ = file.Find('modules/*.lua', 'LUA')

for fileID = 1, #files_mod do
	FileCl('modules/' .. files_mod[fileID])
end


include_sv = (SERVER) and include or function() end
include_cl = (SERVER) and AddCSLuaFile or include

include_sh = function(f)
    include_sv(f)
    include_cl(f)
end

fullinclude = function(f)
    if string.find(f, '_sv.lua') then
        return include_sv(f)
    elseif string.find(f, '_cl.lua') then
        return include_cl(f)
    else
        return include_sh(f)
    end
end

include_dir = function(dir, recursive)
    local fol = GM.FolderName .. '/libs/' .. dir .. '/'
    local files, folders = file.Find(fol .. '*', 'LUA')

    for _, f in ipairs(files) do
        fullinclude(fol .. f)
    end

    if (recursive ~= false) then
        for _, f in ipairs(folders) do
            include_dir(dir .. '/' .. f)
        end
    end
end


local libs_isload
if !libs_isload then 
MsgC( Color(255,0,255), "~RETRIME LOADED!~\n" )
include_sh 'libs/pon.lua'
include_sh 'libs/netstream.lua'
include_sh 'libs/nw.lua'
include_sv 'libs/mysqlite.lua'
include_sh 'libs/shits.lua'
include_cl 'libs/tdlib.lua'
libs_isload = true
end
