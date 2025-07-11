if CLIENT then return end

local hashes = {
	["lua/autorun/tfa_base_autorun.lua"] = "841313682",
	["lua/effects/tfa_bullet_impact/init.lua"] = "3510366566",
	["lua/effects/tfa_dust_impact/init.lua"] = "234996876",
	["lua/effects/tfa_metal_impact/init.lua"] = "2005930175",
	["lua/effects/tfa_muzzleflash_cryo/init.lua"] = "1213518449",
	["lua/effects/tfa_muzzleflash_energy/init.lua"] = "3502168946",
	["lua/effects/tfa_muzzleflash_gauss/init.lua"] = "1828975333",
	["lua/effects/tfa_muzzleflash_generic/init.lua"] = "2169220461",
	["lua/effects/tfa_muzzleflash_incendiary/init.lua"] = "3263699347",
	["lua/effects/tfa_muzzleflash_pistol/init.lua"] = "3900268794",
	["lua/effects/tfa_muzzleflash_revolver/init.lua"] = "543348562",
	["lua/effects/tfa_muzzleflash_rifle/init.lua"] = "3842561477",
	["lua/effects/tfa_muzzleflash_shotgun/init.lua"] = "545846016",
	["lua/effects/tfa_muzzleflash_silenced/init.lua"] = "649498901",
	["lua/effects/tfa_muzzleflash_smg/init.lua"] = "2787287254",
	["lua/effects/tfa_muzzleflash_sniper/init.lua"] = "2685173198",
	["lua/effects/tfa_muzzleflash_sniper_energy/init.lua"] = "2898375250",
	["lua/effects/tfa_muzzlesmoke/init.lua"] = "2260786822",
	["lua/effects/tfa_muzzle_smoketrail/init.lua"] = "3628255997",
	["lua/effects/tfa_penetrate/init.lua"] = "1863869866",
	["lua/effects/tfa_ricochet/init.lua"] = "1853757587",
	["lua/effects/tfa_shell/init.lua"] = "436287554",
	["lua/effects/tfa_shelleject_smoke/init.lua"] = "3756077802",
	["lua/effects/tfa_shell_legacy/init.lua"] = "4176948580",
	["lua/effects/tfa_tracer_cryo/init.lua"] = "3395010229",
	["lua/effects/tfa_tracer_gauss/init.lua"] = "2523400129",
	["lua/effects/tfa_tracer_incendiary/init.lua"] = "2025755327",
	["lua/effects/tfa_tracer_plasma/init.lua"] = "2374745557",
	["lua/entities/tfa_ammo_base.lua"] = "1429071562",
	["lua/entities/tfa_exp_contact.lua"] = "3106367674",
	["lua/entities/tfa_exp_rocket.lua"] = "1831438880",
	["lua/entities/tfa_exp_timed.lua"] = "3206055349",
	["lua/entities/tfa_exp_base/cl_init.lua"] = "3742194501",
	["lua/entities/tfa_exp_base/init.lua"] = "1691980677",
	["lua/entities/tfa_exp_base/shared.lua"] = "3255702592",
	["lua/entities/tfa_thrown_blade/cl_init.lua"] = "3298159740",
	["lua/entities/tfa_thrown_blade/init.lua"] = "2250343936",
	["lua/entities/tfa_thrown_blade/shared.lua"] = "2188019486",
	["lua/entities/tfbow_arrow/cl_init.lua"] = "3408224868",
	["lua/entities/tfbow_arrow/init.lua"] = "319688464",
	["lua/entities/tfbow_arrow/shared.lua"] = "2705657102",
	["lua/entities/tfbow_arrow_stuck/cl_init.lua"] = "1446413991",
	["lua/entities/tfbow_arrow_stuck/init.lua"] = "319688464",
	["lua/entities/tfbow_arrow_stuck/shared.lua"] = "2178697941",
	["lua/entities/tfbow_arrow_stuck_clientside/cl_init.lua"] = "2675183100",
	["lua/entities/tfbow_arrow_stuck_clientside/init.lua"] = "1903984671",
	["lua/entities/tfbow_arrow_stuck_clientside/shared.lua"] = "1235822512",
	["lua/tfa/3dscoped_base.lua"] = "3117877404",
	["lua/tfa/muzzleflash_base.lua"] = "95122785",
	["lua/tfa/att/am_gib.lua"] = "1932361120",
	["lua/tfa/att/am_magnum.lua"] = "3857045964",
	["lua/tfa/att/am_match.lua"] = "3022843101",
	["lua/tfa/att/at_grip.lua"] = "3993059480",
	["lua/tfa/att/base.lua"] = "432788259",
	["lua/tfa/att/br_supp.lua"] = "931015396",
	["lua/tfa/att/sg_frag.lua"] = "849491398",
	["lua/tfa/att/sg_slug.lua"] = "3299915443",
	["lua/tfa/att/si_acog.lua"] = "4015239575",
	["lua/tfa/att/si_aimpoint.lua"] = "155378385",
	["lua/tfa/att/si_eotech.lua"] = "3755544287",
	["lua/tfa/att/si_rt_base.lua"] = "1258703613",
	["lua/tfa/ballistics/bullet.lua"] = "712471404",
	["lua/tfa/documentation/tfa_attachment_template.lua"] = "3703994931",
	["lua/tfa/documentation/tfa_hooks_custom.lua"] = "1976353308",
	["lua/tfa/documentation/tfa_legacy_template.lua"] = "2147233479",
	["lua/tfa/documentation/tfa_melee_template.lua"] = "2923608178",
	["lua/tfa/enums/animation.lua"] = "2613822676",
	["lua/tfa/enums/idle.lua"] = "1249896962",
	["lua/tfa/enums/locomotion.lua"] = "1825904101",
	["lua/tfa/enums/sights.lua"] = "1989624378",
	["lua/tfa/enums/statusnew.lua"] = "3148322910",
	["lua/tfa/framework/tfa_loader.lua"] = "802331033",
	["lua/tfa/modules/cl_tfa_attachment_icon.lua"] = "655617192",
	["lua/tfa/modules/cl_tfa_attachment_panel.lua"] = "2734711303",
	["lua/tfa/modules/cl_tfa_attachment_tip.lua"] = "3337119079",
	["lua/tfa/modules/cl_tfa_changelog.lua"] = "1764734795",
	["lua/tfa/modules/cl_tfa_commands.lua"] = "4242470272",
	["lua/tfa/modules/cl_tfa_devtools.lua"] = "671495436",
	["lua/tfa/modules/cl_tfa_fonts.lua"] = "3349594374",
	["lua/tfa/modules/cl_tfa_hitmarker.lua"] = "226723439",
	["lua/tfa/modules/cl_tfa_inspection.lua"] = "421843087",
	["lua/tfa/modules/cl_tfa_materials.lua"] = "1713843062",
	["lua/tfa/modules/cl_tfa_models.lua"] = "2207733705",
	["lua/tfa/modules/cl_tfa_particles_lua.lua"] = "141990285",
	["lua/tfa/modules/cl_tfa_projtex.lua"] = "2258328482",
	["lua/tfa/modules/cl_tfa_rendertarget.lua"] = "4106500589",
	["lua/tfa/modules/cl_tfa_rtbgblur.lua"] = "259497768",
	["lua/tfa/modules/cl_tfa_settingsmenu.lua"] = "3914032488",
	["lua/tfa/modules/cl_tfa_stencilsights.lua"] = "1485824343",
	["lua/tfa/modules/cl_tfa_vgui.lua"] = "2345454059",
	["lua/tfa/modules/cl_tfa_vm_blur.lua"] = "660607265",
	["lua/tfa/modules/sv_tfa_settingsmenu.lua"] = "2052490557",
	["lua/tfa/modules/tfa_ammo.lua"] = "3702886911",
	["lua/tfa/modules/tfa_attachments.lua"] = "2319270270",
	["lua/tfa/modules/tfa_ballistics.lua"] = "4270768814",
	["lua/tfa/modules/tfa_bodygroups.lua"] = "3251341578",
	["lua/tfa/modules/tfa_commands.lua"] = "3722062545",
	["lua/tfa/modules/tfa_darkrp.lua"] = "2545598324",
	["lua/tfa/modules/tfa_data.lua"] = "2339400974",
	["lua/tfa/modules/tfa_effects.lua"] = "3684881139",
	["lua/tfa/modules/tfa_envcheck.lua"] = "1170634659",
	["lua/tfa/modules/tfa_functions.lua"] = "3273853577",
	["lua/tfa/modules/tfa_hooks.lua"] = "4148332890",
	["lua/tfa/modules/tfa_keybinds.lua"] = "3346214172",
	["lua/tfa/modules/tfa_keyvalues.lua"] = "4002998338",
	["lua/tfa/modules/tfa_matproxies.lua"] = "3202725304",
	["lua/tfa/modules/tfa_melee_autorun.lua"] = "2372445491",
	["lua/tfa/modules/tfa_meta.lua"] = "3583179333",
	["lua/tfa/modules/tfa_netcode.lua"] = "2052957164",
	["lua/tfa/modules/tfa_npc_weaponmenu.lua"] = "3610270497",
	["lua/tfa/modules/tfa_nzombies.lua"] = "4108516370",
	["lua/tfa/modules/tfa_particles.lua"] = "2623380377",
	["lua/tfa/modules/tfa_small_entities.lua"] = "3695865073",
	["lua/tfa/modules/tfa_snd_timescale.lua"] = "219633519",
	["lua/tfa/modules/tfa_soundscripts.lua"] = "552092803",
	["lua/tfa/modules/tfa_tttpatch.lua"] = "1366220992",
	["lua/weapons/tfa_bash_base.lua"] = "4126775458",
	["lua/weapons/tfa_bow_base.lua"] = "928658967",
	["lua/weapons/tfa_knife_base.lua"] = "3633556160",
	["lua/weapons/tfa_nade_base.lua"] = "382501702",
	["lua/weapons/tfa_sword_advanced_base.lua"] = "3428464047",
	["lua/weapons/tfa_base_template/shared.lua"] = "3301527624",
	["lua/weapons/tfa_gun_base/cl_init.lua"] = "3008148165",
	["lua/weapons/tfa_gun_base/init.lua"] = "1121081776",
	["lua/weapons/tfa_gun_base/shared.lua"] = "107732895",
	["lua/weapons/tfa_gun_base/client/bobcode.lua"] = "411942292",
	["lua/weapons/tfa_gun_base/client/effects.lua"] = "3467999270",
	["lua/weapons/tfa_gun_base/client/flashlight.lua"] = "2558318029",
	["lua/weapons/tfa_gun_base/client/fov.lua"] = "3338376529",
	["lua/weapons/tfa_gun_base/client/hud.lua"] = "3932260266",
	["lua/weapons/tfa_gun_base/client/laser.lua"] = "2567877953",
	["lua/weapons/tfa_gun_base/client/mods.lua"] = "2158977613",
	["lua/weapons/tfa_gun_base/client/viewbob.lua"] = "1386216205",
	["lua/weapons/tfa_gun_base/client/viewmodel.lua"] = "1717749516",
	["lua/weapons/tfa_gun_base/common/ai_translations.lua"] = "992165847",
	["lua/weapons/tfa_gun_base/common/akimbo.lua"] = "1738081370",
	["lua/weapons/tfa_gun_base/common/anims.lua"] = "2765138142",
	["lua/weapons/tfa_gun_base/common/attachments.lua"] = "3846721605",
	["lua/weapons/tfa_gun_base/common/autodetection.lua"] = "2357254153",
	["lua/weapons/tfa_gun_base/common/bullet.lua"] = "1400847016",
	["lua/weapons/tfa_gun_base/common/calc.lua"] = "4045284043",
	["lua/weapons/tfa_gun_base/common/effects.lua"] = "1562605377",
	["lua/weapons/tfa_gun_base/common/events.lua"] = "1337217943",
	["lua/weapons/tfa_gun_base/common/nzombies.lua"] = "1160000749",
	["lua/weapons/tfa_gun_base/common/skins.lua"] = "4221343498",
	["lua/weapons/tfa_gun_base/common/stat.lua"] = "3937137145",
	["lua/weapons/tfa_gun_base/common/ttt.lua"] = "1612292090",
	["lua/weapons/tfa_gun_base/common/utils.lua"] = "1989361879",
	["lua/weapons/tfa_gun_base/common/viewmodel.lua"] = "1241184752",
	["lua/weapons/tfa_melee_base/cl_init.lua"] = "3132318958",
	["lua/weapons/tfa_melee_base/init.lua"] = "1564262478",
	["lua/weapons/tfa_melee_base/shared.lua"] = "936336113",

}

local function check_and_compare_files()
	for file_name, crc_stored in pairs(hashes) do
		if string.sub(file_name, 1, 4) == "lua/" then
			file_name = string.sub(file_name, 5)
		end

		local file_contents = file.Read(file_name, "LUA")

		if not file_contents or file_contents == "" then
			print("[TFA Base] (CRC) An error occured while reading file '" .. file_name .. "'")

			goto CONTINUE
		end

		local crc_local = util.CRC(file_contents)

		if not crc_local then
			print("[TFA Base] (CRC) Unable to calculate checksum for file '" .. file_name .. "'")
		elseif crc_local ~= crc_stored then
			print("[TFA Base] (CRC) Checksum diff for '" .. file_name .. "': expected " .. tostring(crc_stored) .. ", got " .. tostring(crc_local))
		end

		::CONTINUE::
	end
end

hook.Add("InitPostEntity", "TFABase_CRCIntegrityCheck", check_and_compare_files)