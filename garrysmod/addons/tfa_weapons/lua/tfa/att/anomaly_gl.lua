
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Подствольный гранатомёт ГП-25 «Костёр»"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {  [[Однозарядный, заряжаемый с дула подствольный гранатомёт для автоматических
винтовок стран-участниц Варшавского договора. Ударно-спусковой механизм самовзводный,
с ручным предохранителем и автоматической блокировкой выстрела при неправильной установке.

]] }
ATTACHMENT.Icon = "entities/anomaly/addons/addon_gp.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Подствольный гранатомёт ГП-25 «Костёр»"

ATTACHMENT.Ent = "tfa_exp_contact"
ATTACHMENT.Damage = 250
ATTACHMENT.DefaultModel = "models/flaymi/anomaly/weapons/ammo/wpn_vog.mdl"
ATTACHMENT.Velocity = 76.5 * 39.370 * 4 / 3 --76.5 M/s * Meters to Inches * Inches to Hammer Units
ATTACHMENT.Ammo = "ammo_vog-25"
ATTACHMENT.Automatic = false
ATTACHMENT.ClipSize = 1
ATTACHMENT.DefaultClip = 3
ATTACHMENT.Delay = 0.3
ATTACHMENT.Sound = Sound("weapons/ar2/ar2_altfire.wav")

ATTACHMENT.RecoilV = -5
ATTACHMENT.RecoilH = -2.5

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["gl"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["gl"] = {
			["active"] = true
		}
	},
	["Animations"] = {
		["holster"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ
			if wep:GLDeployed() then
				val["value"] = "anm_hide_w_gl"
			else
				val["value"] = "anm_hide_w_gl"
			end
			return val, true, true
		end,
		["draw"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ
			if wep:GLDeployed() then
				val["value"] = "anm_show_w_gl"
			else
				val["value"] = "anm_show_w_gl"
			end
			return val, true, true
		end,
		["draw_first"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ
			if wep:GLDeployed() then
				val["value"] = "anm_show_w_gl_first"
			else
				val["value"] = "anm_show_w_gl_first"
			end
			return val, true, true
		end,
		["draw_empty"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_show_w_gl"
			else
				val["value"] = "anm_show_w_gl"
			end
			return val, true, true
		end,
		["shoot1"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_shots_g"
			else
				val["value"] = "anm_shots_w_gl"
			end
			return val, true, true
		end,
		["shoot1_last"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_shots_g"
			else
				val["value"] = "anm_shots_w_gl"
			end
			return val, true, true
		end,
		["shoot1_empty"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_shots_g"
			else
				val["value"] = "anm_shots_w_gl"
			end
			return val, true, true
		end,
		["reload"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_reload_g"
			else
				val["value"] = "anm_reload_w_gl"
			end
			return val, true, true
		end,
		["reload_empty"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_reload_g"
			else
				val["value"] = "anm_reload_empty_w_gl"

				if wep:CheckVMSequence("anm_reload_empty_w_gl") then
					val["value"] = "anm_reload_empty_w_gl"
				end
			end
			val["enabled"] = true
			return val, true, true
		end,
		["idle"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_idle_w_gl"
			else
				val["value"] = "anm_idle_w_gl"
			end
			return val, true, true
		end,
		["idle_empty"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_idle_w_gl"
			else
				val["value"] = "anm_idle_w_gl"
			end
			return val, true, true
		end,
		["rof"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "gl_fireselect"
				val["enabled"] = false
			else
				val["value"] = "gl_fireselect"
			end
			return val, true, true
		end,
		["rof_is"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "gl_iron_fireselect"
				val["enabled"] = false
			else
				val["value"] = "gl_iron_fireselect"
			end
			return val, true, true
		end
	},
	["Primary"] = {
		["GLSound"] = function(wep,stat)
			return stat or wep:GetStat("Secondary.Sound") or wep:GetStat("Primary.Sound")
		end,
		["KickUp"] = function(wep,stat) return stat * 0.8 end,
		["KickDown"] = function(wep,stat) return stat * 0.8 end,
		["Spread"] = function(wep,stat) return stat * 1.1 end,
		["IronAccuracy"] = function(wep,stat) return stat * 1.05 end
	},
	["Secondary"] = {
		["ClipSize"] = ATTACHMENT.ClipSize,
		["Ammo"] = ATTACHMENT.Ammo
	},
	["SprintAnimation"] = {
		["loop"] = function(wep,val)
			val = table.Copy(val) or {}
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_idle_sprint_w_gl"
			else
				val["value"] = "anm_idle_sprint_w_gl"
			end
			if val.value_empty then
				if wep:GLDeployed() then
					val["value_empty"] = "anm_idle_sprint_w_gl"
				else
					val["value_empty"] = "anm_idle_sprint_w_gl"
				end
			end
			return val, true, true
		end
	},
	["IronAnimation"] = {
		["shoot"] = function(wep,val)
			val = table.Copy(val) or {}
			if wep:GLDeployed() then
				val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val["value"] = "anm_shots_g"
				val["value_empty"] = "anm_shots_g"
			else
				if not wep.IronAnimation.shoot then return nil, false, true end
				val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
				if val.value then
					val["value"] = "anm_shots_w_gl"
				end
				if val.value_last then
					val["value_last"] =  "anm_shots_w_gl"
				end
				if val.value_empty then
					val["value_empty"] =  "anm_shots_w_gl"
				end
			end
			return val, true, true
		end
	},
	["IronSightsPos"] = function(wep,val)
		if wep:GLDeployed() then
			return wep.IronSightsPos_GL, true, true
		else
			return val, false, true
		end
	end,
	["IronSightsAng"] = function(wep,val)
		if wep:GLDeployed() then
			return wep.IronSightsAng_GL, true, true
		else
			return val, false, true
		end
	end,
}

local function SetVel( ent, vel )
	ent:SetVelocity( vel )
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity( vel )
	end
end

function ATTACHMENT:Attach( wep )
	wep.SetNW2Bool = wep.SetNW2Bool or wep.SetNWBool
	wep.GetNW2Bool = wep.GetNW2Bool or wep.GetNWBool

	if SERVER and not wep.HasBeenGivenGLAmmo and (IsValid(wep:GetOwner()) and wep:GetOwner().GiveAmmo) then
		wep:SetClip2( math.Clamp( self.DefaultClip,0,1 ) )
		wep:GetOwner():GiveAmmo( math.max( self.DefaultClip - 1, 0 ), self.Ammo )
		wep.HasBeenGivenGLAmmo = 1
	end

	wep:SetNW2Bool("GLDeployed",false)

	function wep:GLDeployed()
		return wep:GetNW2Bool("GLDeployed")
	end

	wep.PrimaryAttackOld_GL = wep.PrimaryAttackOld_GL or wep.PrimaryAttack
	wep.PrimaryAttack = function( myself, ... )
		if IsValid(myself:GetOwner()) and not myself:GetOwner():IsPlayer() then
			return wep.PrimaryAttackOld_GL( myself, ... )
		end

		if myself.Owner:KeyPressed( IN_ATTACK ) and myself.Owner:KeyDown( IN_USE ) and TFA.Enum.ReadyStatus[ myself:GetStatus() ] and not myself:GetSprinting() then
			myself:SetNW2Bool("GLDeployed", not myself:GetNW2Bool("GLDeployed") )
			if CurTime() > myself:GetNextPrimaryFire() then
				if myself:GetNW2Bool("GLDeployed") then
					local _,tanim = myself:SendViewModelSeq( "glsetup_in" )
					myself:SetNextPrimaryFire( CurTime() + wep:GetActivityLength( tanim ) )
				else
					local _,tanim = myself:SendViewModelSeq( "glsetup_out" )
					myself:SetNextPrimaryFire( CurTime() + wep:GetActivityLength( tanim ) )
				end
			end
		elseif myself.Owner:KeyDown( IN_USE ) then
			return
		elseif myself:GLDeployed() then
			if ( myself.Owner:KeyPressed( IN_ATTACK ) or self.Automatic ) then
				return myself:SecondaryAttack( true )
			end
		else
			return wep.PrimaryAttackOld_GL( myself, ... )
		end
	end

	wep.Reload_GLOld = wep.Reload_GLOld or wep.Reload
	wep.Reload = function( myself, ... )
		if myself:GLDeployed() then
			return wep.Reload2( myself, ... )
		else
			return wep.Reload_GLOld( myself, ... )
		end
	end

	wep.CompleteReload_GLOld = wep.CompleteReload_GLOld or wep.CompleteReload

	wep.CompleteReload = function( myself, ... )
		if myself:GLDeployed() then
			local maxclip = self.ClipSize
			local curclip = myself:Clip2()
			local amounttoreplace = math.min(maxclip - curclip, myself:Ammo2())
			myself:TakeSecondaryAmmo(amounttoreplace * -1)
			myself:TakeSecondaryAmmo(amounttoreplace, true)
		else
			return wep.CompleteReload_GLOld( myself, ... )
		end
	end

	wep.SecondaryAttack_GLOld = wep.SecondaryAttack_GLOld or wep.SecondaryAttack

	wep.SecondaryAttack = function( myself, gogogo, ... )
		if myself:GLDeployed() then
			if not gogogo then return end
			if CurTime() >  myself:GetNextPrimaryFire() and TFA.Enum.ReadyStatus[ myself:GetStatus() ] and not myself:GetSprinting() then
				myself.LuaShellEject_Old = myself.LuaShellEject
				myself.LuaShellEject = false
				local c1 = myself:Clip1()
				myself:SetClip1( myself:Clip2() )
				myself:ChooseShootAnim( )
				myself:SetClip1( c1 )
				if myself:Clip2() > 0 then
					if SERVER then
						local ent = ents.Create( self.Ent )
						ent:SetOwner( myself.Owner )
						ent:SetPos( myself.Owner:GetShootPos() )
						ent:SetAngles( myself.Owner:EyeAngles() )
						ent:SetModel( myself:GetStat("Primary.ProjectileModel") or self.DefaultModel )
						ent:Spawn()
						ent:Activate()
						ent.Damage = self.Damage
						SetVel( ent, myself.Owner:GetAimVector() * self.Velocity )
					end
					myself:SetNextPrimaryFire( CurTime()  + self.Delay )
					myself:SetClip2( math.max( myself:Clip2() - 1, 0 ) )
					if IsFirstTimePredicted() then
						myself:EmitSound( myself:GetStat("Primary.GLSound") )
					end
					myself.Owner:ViewPunch( Angle( self.RecoilV, self.RecoilH, self.RecoilH / 2 ) )
				end
				myself.LuaShellEject = myself.LuaShellEject_Old
			end
		else
			return wep.SecondaryAttack_GLOld( myself, gogogo, ... )
		end
	end

	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

function ATTACHMENT:Detach( wep )

	wep:SetNW2Bool("GLDeployed",false)
	wep.PrimaryAttack = wep.PrimaryAttackOld_GL or wep.PrimaryAttack
	wep.Reload = wep.Reload_GLOld or wep.Reload
	wep.CompleteReload = wep.CompleteReload_GLOld or wep.CompleteReload
	wep.SecondaryAttack = wep.SecondaryAttack_GLOld or wep.SecondaryAttack

	wep.PrimaryAttackOld_GL = nil
	wep.Reload_GLOld = nil
	wep.CompleteReload_GLOld = nil
	wep.SecondaryAttack_GLOld = nil

	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
