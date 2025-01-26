AddCSLuaFile()

if SERVER then return end

local snow_enabled = CreateClientConVar("snowflakes_enabled", "1", true, false)
local emitter = ParticleEmitter(Vector(), false)

// change grass to snow
local spawned = false
--[[]
local mat_whitelist = {
	["grass"] = true,
	["dirt"] = true,
	["paper"] = true,
	["antlionsand"] = true,
}

hook.Add("InitPostEntity", "snow_initialize", function()
	for k, v in ipairs(game.GetWorld():GetBrushSurfaces()) do
		local mat = string.lower(v:GetMaterial():GetString("$surfaceprop") or "")
		if mat_whitelist[mat] then
			v:GetMaterial():SetTexture("$basetexture", "nature/snowfloor001a")
			v:GetMaterial():SetTexture("$basetexture2", "nature/snowfloor001a")
			v:GetMaterial():SetVector("$color2", Vector(0.6, 0.6, 0.6))	// snow is kinda bright, tone it down a bit.
		end
	end
	Material("infmap/flatgrass"):SetTexture("$basetexture", "nature/snowfloor001a")
	Material("infmap/flatgrass"):SetVector("$color2", Vector(0.75, 0.75, 0.75))
	spawned = true
end)
--]]
local mat_whitelist = {
	--["concrete/concretefloor028c_c17"] = true,
	["stone/stonefloor006a"] = true,
	["stone/stonefloor006a011a"] = true,
	["concrete/concretefloor001a"] = true,
	["concrete/concretefloor038a"] = true,
	["concrete/concretefloor038b"] = true,
	["concrete/concretefloor038с"] = true,
	["concrete/concretefloor016b"] = true,
	["concrete/concretefloor019a"] = true,
	["concrete/concretefloor011a"] = true,
	["concrete/concretefloor013с"] = true,
	--["gm_construct/flatgrass"] = true,
	--["nature/blendgrassgravel003a"] = true,
	--["nature/gm_construct_grass"] = true,
	["wood/milroof005"] = true,
	["cs_italy/tileroof01"] = true,
	["de_chateau/ceiling02"] = true,
	["tile/tileroof002a"] = true,
	["metal/metalroof002a"] = true,
	["metal/metalroof003a"] = true,
	["de_nuke/nukroofa"] = true,
	["metal/metalroof004a"] = true,
	["metal/metalroof005a"] = true,
	["de_tides/tides_roof_1"] = true,
	["cs_italy/tileroof01"] = true,
	["tile/tileroof004a_c17"] = true,
	["wood/woodwall004c"] = true,
	--["nature/blendrockdirt008d"] = true,
	--["cs_havana/ground01grass"] = true,
}

hook.Add("InitPostEntity", "snow_initialize", function()
	for k, v in ipairs(game.GetWorld():GetBrushSurfaces()) do
		local mat = v:GetMaterial():GetString("$basetexture")
		local mat2 = v:GetMaterial():GetString("$basetexture2")
		if mat_whitelist[mat] or mat_whitelist[mat2] then
			v:GetMaterial():SetTexture("$basetexture", "nature/snowfloor001a")
			v:GetMaterial():SetTexture("$basetexture2", "nature/snowfloor001a")
			v:GetMaterial():SetVector("$color2", Vector(0.6, 0.6, 0.6))
		end
	end
	Material("nature/blendrockdirt008d"):SetTexture("$basetexture", "nature/snowfloor001a")
	Material("nature/blendgrassgravel003a"):SetTexture("$basetexture", "nature/snowfloor001a")
	Material("nature/gm_construct_grass"):SetTexture("$basetexture", "nature/snowfloor001a")
	Material("gm_construct/flatgrass"):SetTexture("$basetexture", "nature/snowfloor001a")
	Material("concrete/concretefloor028c_c17"):SetTexture("$basetexture", "nature/snowfloor001a")
	Material("cs_havana/ground01grass"):SetTexture("$basetexture", "nature/snowfloor001a")

	Material("nature/blendgrassgravel003a"):SetTexture("$basetexture2", "nature/snowfloor001a")
	Material("nature/gm_construct_grass"):SetTexture("$basetexture2", "nature/snowfloor001a")
	Material("gm_construct/flatgrass"):SetTexture("$basetexture2", "nature/snowfloor001a")
	Material("concrete/concretefloor028c_c17"):SetTexture("$basetexture2", "nature/snowfloor001a")
	spawned = true
end)

hook.Add("Think", "snow_spawn", function()
	if !snow_enabled or !snow_enabled:GetBool() then return end
	if !util.IsSkyboxVisibleFromPoint(EyePos()) then return end
	if !spawned then return end

	for i = 1, 10 do
		local startpos = EyePos() + Vector(math.Rand(-3000, 3000), math.Rand(-3000, 3000), math.Rand(1000, 2000))
		local particle = emitter:Add("particle/particle_glow_04", startpos)
		if particle then
			local tr = util.QuickTrace(startpos, Vector(0, 0, -2000)).HitPos
			local dietime = (startpos[3] - tr[3]) * 0.0035	// weird conversion
			particle:SetDieTime(math.min(dietime, 10)) 
		
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255) 
			particle:SetAirResistance(120)
		
			local flake_size = math.Rand(5, 10)
			particle:SetStartSize(flake_size) 
			particle:SetEndSize(flake_size) 
		
			particle:SetGravity(Vector(0, 0, -600)) 
			particle:SetVelocity(Vector(0, 0, -600))
			particle:SetNextThink(CurTime())
		end
	end
end)

local function calc_fog(mult)
	render.FogStart(0)
	render.FogMaxDensity(1)	// magic numbers that look good
	render.FogColor(240, 240, 240)
	render.FogEnd(20000 * (mult or 1))
	render.FogMode(MATERIAL_FOG_LINEAR)
	return true
end
hook.Add("SetupWorldFog", "!snowfog", calc_fog)
hook.Add("SetupSkyboxFog", "!snowfog", calc_fog)

--[[
lua_run_self print(util.QuickTrace( me:GetPos(), Vector(180, 0, 0),me).HitTexture)
--]]