local R_LUA
local function SetupLuaRun()
	R_LUA = ents.Create("lua_run")
	R_LUA:SetName("R_LUA")
	R_LUA:Spawn()
end
hook.Add("InitPostEntity", "SetupLuaRun", SetupLuaRun)

function DestroyR_LUA()
	if IsValid(R_LUA) and R_LUA:IsValid() then R_LUA:Remove() end
end