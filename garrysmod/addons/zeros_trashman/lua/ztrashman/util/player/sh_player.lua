/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

ztm = ztm or {}
ztm.Player = ztm.Player or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

function ztm.Player.IsTrashman(ply)
	if ztm.config.Jobs == nil then return true end
	if table.Count(ztm.config.Jobs) <= 0 then return true end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

	if ztm.config.Jobs[zclib.Player.GetJob(ply)] then
		return true
	else
		return false
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

/*
	Returns the players trash sell multiplicator according to his rank
*/
function ztm.Player.GetTrashSellMultiplicator(ply)
	if not IsValid(ply) then return 1 end
	local rank = zclib.Player.GetRank(ply)
	if not rank then return 1 end

	if ztm.config.MoneyxRank[rank] then
		return ztm.config.MoneyxRank[rank]
	else
		if ztm.config.MoneyxRank["default"] then
			return ztm.config.MoneyxRank["default"]
		else
			return 1
		end
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80
