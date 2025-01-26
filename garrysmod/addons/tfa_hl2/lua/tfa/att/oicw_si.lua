if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "OICW Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "4x zoom" }
ATTACHMENT.Icon = "entities/ins2_si_mx4.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "OICWS"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_oicw"] = {
			["active"] = true,
			["ins2_sightanim_idle"] = "scope_idle",
			["ins2_sightanim_iron"] = "scope_zoom",
		}
	},
	["WElements"] = {},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 4 end
	},
	["INS2_SightVElement"] = "scope_oicw",
	["INS2_SightSuffix"] = "OICW"
}

local tsFinal = {}
local shadowborder = 256
local cd = {}
local myshad
local debugcv = GetConVar("cl_tfa_debug_rt")
local shadowcv = GetConVar("cl_tfa_3dscope_overlay")
local tmpts = {}

local thermal = Material("kruppzo/weapons/oicw/white")

local INFRA

if CLIENT then
	INFRA = CreateMaterial("thermal_oicw", "g_colourmodify", {})
	INFRA:SetTexture("$fbtexture", render.GetScreenEffectTexture())
	
	local INFRA_SETUP = 
	{
		[ "$pp_colour_addr" ] 		= 0,
		[ "$pp_colour_addg" ] 		= 0,
		[ "$pp_colour_addb" ] 		= 0,
		[ "$pp_colour_brightness" ] = 0.25,
		[ "$pp_colour_contrast" ]	= 0.9,
		[ "$pp_colour_colour" ] 	= 0,
		[ "$pp_colour_mulr" ] 		= 0,
		[ "$pp_colour_mulg" ] 		= 0,
		[ "$pp_colour_mulb" ] 		= 0,
		[ "$pp_colour_inv" ] = 0.8
	}

	for k, v in pairs(INFRA_SETUP) do
		INFRA:SetFloat(k, v)
	end
end

if TFA_BASE_VERSION >= 4.5 then -- updates never
	function ATTACHMENT:RTCode(myself, rt, scrw, scrh)
		if not IsValid(myself:GetOwner()) or not IsValid(myself.OwnerViewModel) then return end
		local rttw, rtth
		rttw = ScrW()
		rtth = ScrH()

		if not myshad then
			myshad = Material("vgui/scope_shadowmask")
		end

		local ang = myself.OwnerViewModel:GetAngles()
		cd.angles = ang
		cd.origin = myself:GetOwner():GetShootPos()
		local attpos = self:GetScopeOrigin(myself)

		if attpos then
			cd.angles = attpos.Ang
			cd.origin = attpos.TracePos or attpos.Pos
			cd.znear = attpos.znear
		end

		local suffix = myself:GetStat("INS2_SightSuffix")

		if suffix then
			local angtrans = myself:GetStat("ScopeAngleTransforms_" .. suffix)

			if angtrans then
				cd.angles:RotateAroundAxis(cd.angles:Right(), angtrans.p)
				cd.angles:RotateAroundAxis(cd.angles:Up(), angtrans.y)
				cd.angles:RotateAroundAxis(cd.angles:Forward(), angtrans.r)
			end
		end

		local sipos = self:GetScopeTarget(myself)

		if not sipos then
			sipos = self:GetScopeTargetLegacy(myself)
		end

		cd.x = 0
		cd.y = 0
		cd.w = rttw
		cd.h = rtth
		cd.fov = myself:GetStat("RTScopeFOV")
		cd.drawviewmodel = false
		cd.drawhud = false
		render.Clear(0, 0, 0, 255, true, true)

		if myself.CLIronSightsProgress > 0.005 then
			 
			render.RenderView(cd)

			if attpos and not (suffix and myself:GetStat("RTRedrawViewModel_" .. suffix) == false) then
				cam.Start3D(cd.origin, cd.angles)
				cam.IgnoreZ(true)
				myself.OwnerViewModel:SetupBones()
				myself.OwnerViewModel:DrawModel()
				cam.IgnoreZ(false)

				render.CopyRenderTargetToTexture(render.GetScreenEffectTexture())
				render.SetMaterial(INFRA)
				render.DrawScreenQuad()

				for _, ent in pairs(ents.GetAll()) do
					if ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot() then
						if not ent:IsEffectActive(EF_NODRAW) then
							render.MaterialOverride( thermal )
							render.SetBlend( 0.5 )
							render.SetColorModulation(1, 0, 0)
							ent:DrawModel()
							render.SetColorModulation(1, 1, 1)
							render.SetBlend( 0 )
							render.MaterialOverride( nil )
						end
					end
				end
				
				DrawMaterialOverlay("effects/combine_binocoverlay", 0)

				cam.End3D()
			end
			
		end

		cam.Start2D()

		if sipos and shadowcv and shadowcv:GetBool() then
			local distfac = self:DistanceFactor(myself)

			if debugcv and debugcv:GetBool() then
				distfac = 1
			end

			tsFinal.x = sipos.x
			tsFinal.y = sipos.y
			tsFinal.x = tsFinal.x * rttw
			tsFinal.y = tsFinal.y * rttw
			local texW = rttw * distfac
			local texH = rtth * distfac
			local texX = tsFinal.x - texW / 2
			local texY = tsFinal.y - texH / 2
			surface.SetMaterial(myshad)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(texX, texY, texW, texH)
			surface.SetDrawColor(color_black)
			surface.DrawRect(0, 0, texX + 1, rtth)
			surface.DrawRect(texX + texW - 1, 0, rttw - texX - texW + 1, rtth)
			surface.DrawRect(0, 0, rttw, texY + 1)
			surface.DrawRect(0, texY + texH - 1, rttw, rtth - texY - texH + 1)
		else
			surface.SetMaterial(myshad)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(-shadowborder, -shadowborder, shadowborder * 2 + rttw, shadowborder * 2 + rtth)
		end

		surface.SetDrawColor(ColorAlpha(color_black, 255 * (1 - myself.CLIronSightsProgress)))
		surface.DrawRect(0, 0, scrw, scrh)
		cam.End2D()
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end