local whitelistoper = {

}

local whitelistevent = {
    ["aw2_dropship"] = true,
    ["aw2_dropship2"] = true,
    ["aw2_hunterchopper"] = true,
    ["aw2_hunterchopper2"] = true,
    ["aw2_manhack"] = true,
    ["darkrp_radio"] = true,
    ["darkrp_food_01"] = true,
    ["darkrp_food_02"] = true,
    ["darkrp_food_03"] = true,
    ["darkrp_food_04"] = true,
    ["darkrp_food_05"] = true,
    ["darkrp_food_06"] = true,
    ["darkrp_ration_01"] = true,
    ["darkrp_ration_02"] = true,
    ["darkrp_ration_03"] = true,
    ["darkrp_ration_04"] = true,
    ["darkrp_ration_05"] = true,
    ["darkrp_ration_06"] = true,
    ["darkrp_sodavending"] = true,
}

local whitelistmodadm = {
    ["aw2_manhack"] = true,
}

local whitelistcur = {
    ["aw2_dropship"] = true,
    ["aw2_dropship2"] = true,
    ["aw2_hunterchopper"] = true,
    ["aw2_hunterchopper2"] = true,
    ["aw2_manhack"] = true,
    ["darkrp_radio"] = true,
    ["darkrp_food_01"] = true,
    ["darkrp_food_02"] = true,
    ["darkrp_food_03"] = true,
    ["darkrp_food_04"] = true,
    ["darkrp_food_05"] = true,
    ["darkrp_food_06"] = true,
    ["darkrp_ration_01"] = true,
    ["darkrp_ration_02"] = true,
    ["darkrp_ration_03"] = true,
    ["darkrp_ration_04"] = true,
    ["darkrp_ration_05"] = true,
    ["darkrp_ration_06"] = true,
    ["darkrp_sodavending"] = true,
}

local whitelistmanager = {
    ["aw2_dropship"] = true,
    ["aw2_dropship2"] = true,
    ["aw2_hunterchopper"] = true,
    ["aw2_hunterchopper2"] = true,
    ["aw2_manhack"] = true,
    ["darkrp_radio"] = true,
    ["darkrp_food_01"] = true,
    ["darkrp_food_02"] = true,
    ["darkrp_food_03"] = true,
    ["darkrp_food_04"] = true,
    ["darkrp_food_05"] = true,
    ["darkrp_food_06"] = true,
    ["darkrp_ration_01"] = true,
    ["darkrp_ration_02"] = true,
    ["darkrp_ration_03"] = true,
    ["darkrp_ration_04"] = true,
    ["darkrp_ration_05"] = true,
    ["darkrp_ration_06"] = true,
    ["darkrp_sodavending"] = true,
    ["sent_ball"] = true,
    ["combine_mine"] = true,
    ["grenade_helicopter"] = true,
}


hook.Add("PlayerSpawnSENT", "retrime.Eventers", function(ply, ent)
    if ply:IsSuperAdmin() then return end

    if ply:Team() ~= TEAM_FSG then
        DarkRP.notify(ply, 0, 3, "Спавнить энтити можно только за работу FSG!")
        return false
    end
        
    if ply:IsModAdm() and not whitelistmodadm[ent] then
       DarkRP.notify(ply, 0, 3, "Спавнить данное энтити нельзя!")
       return false
    end
        
    if ply:IsEvent() and not whitelistevent[ent] then
       DarkRP.notify(ply, 0, 3, "Спавнить данное энтити нельзя!")
       return false
    end
        
    if ply:IsOper() and not whitelistoper[ent] then
       DarkRP.notify(ply, 0, 3, "Спавнить данное энтити нельзя!")
       return false
    end
       
    if ply:IsCur() and not whitelistcur[ent] then
       DarkRP.notify(ply, 0, 3, "Спавнить данное энтити нельзя!")
       return false
    end
        
    if ply:IsManager() and not whitelistmanager[ent] then
       DarkRP.notify(ply, 0, 3, "Спавнить данное энтити нельзя!")
       return false
    end

end)