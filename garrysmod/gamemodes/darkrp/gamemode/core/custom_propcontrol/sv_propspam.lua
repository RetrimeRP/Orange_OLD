local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
hook.Add("PlayerSpawnProp", "retrime.PropSpam", function(ply)
	if ply.LastPropSpawn and ply.LastPropSpawn > CurTime() then
		ply.LastPropSpawn = CurTime() + 0.5

		notify(ply, 0, 4, "Пожалуйста, подождите, прежде чем создать новый проп")
		return false
	end

	ply.LastPropSpawn = CurTime() + 0.3
end)