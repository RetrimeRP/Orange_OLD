/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if CLIENT then return end
ztm = ztm or {}
ztm.force = ztm.force or {}

resource.AddWorkshop( "2532060111" ) // Zeros Lua Libary Contentpack
//https://steamcommunity.com/sharedfiles/filedetails/?id=2532060111

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

if ztm.config.FastDl then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

	function ztm.force.AddDir(path)

		local files, folders = file.Find("addons/zeros_trashman/" .. path .. "/*", "GAME")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

		for k, v in pairs(files) do
			resource.AddFile("addons/zeros_trashman/" .. path .. "/" .. v)
		end

		for k, v in pairs(folders) do

			ztm.force.AddDir("addons/zeros_trashman/" .. path .. "/" .. v)
		end
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

	ztm.force.AddDir("particles")
	ztm.force.AddDir("sound/ztm/")
	ztm.force.AddDir("models/zerochain/props_trashman/")
	ztm.force.AddDir("materials/zerochain/props_trashman/")
	ztm.force.AddDir("materials/entities/")
	ztm.force.AddDir("materials/vgui/entities/")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

else
	resource.AddWorkshop( "1795813904" ) // Zeros Trashman Contentpack
	//https://steamcommunity.com/sharedfiles/filedetails/?id=1795813904
end
