local meta = FindMetaTable("Player")

function meta:addMoney(amount)

	if not amount then return false end

	local total = self:getDarkRPVar("money") + math.floor(amount)
	total = hook.Call("playerWalletChanged", GAMEMODE, self, amount, self:getDarkRPVar("money")) or total

	self:setDarkRPVar("money", total)

	if self.DarkRPUnInitialized then return end

	DarkRP.storeMoney(self, total)

end

function DarkRP.payPlayer(ply1, ply2, amount)

	ply1:addMoney(-amount)
	ply2:addMoney(amount)

end

function meta:payDay()

	if not self:isArrested() then
		DarkRP.retrieveSalary(self, function(amount)
			amount = math.floor(amount or GAMEMODE.Config.normalsalary)

			local suppress, message, hookAmount = hook.Call("playerGetSalary", GAMEMODE, self, amount)
			amount = hookAmount or amount

			if amount == 0 or not amount then
				if not suppress then
					DarkRP.notify(self, 4, 4, message or DarkRP.getPhrase("payday_unemployed"))
				end
			else
				self:addMoney(amount)

				if not suppress then
					DarkRP.notify(self, 4, 4, message or DarkRP.getPhrase("payday_message", DarkRP.formatMoney(amount)))
				end
			end
		end)
	else
		DarkRP.notify(self, 4, 4, DarkRP.getPhrase("payday_missed"))
	end

end

function DarkRP.createMoneyBag(pos, amount)

	local moneybag = ents.Create(GAMEMODE.Config.MoneyClass)
	moneybag:SetPos(pos)
	moneybag:Setamount(math.Min(amount, 2147483647))
	moneybag:Spawn()
	moneybag:Activate()

	if GAMEMODE.Config.moneyRemoveTime and GAMEMODE.Config.moneyRemoveTime ~= 0 then
		timer.Create("RemoveEnt" .. moneybag:EntIndex(), GAMEMODE.Config.moneyRemoveTime, 1, fn.Partial(SafeRemoveEntity, moneybag))
	end

	return moneybag

end

local function GiveMoney(ply, args)

	if args == "" then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
		return ""
	end

	if not tonumber(args) then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
		return ""
	end

	local trace = ply:GetEyeTrace()
	local ent = trace.Entity

	if not IsValid(ent) or not ent:IsPlayer() or ent:GetPos():DistToSqr(ply:GetPos()) >= 22500 then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("must_be_looking_at", " игрока!"))
		return ""
	end

	local amount = math.floor(tonumber(args))

	if amount < 1 then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ">=1"))
		return ""
	end

	if not ply:canAfford(amount) then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("cant_afford_money", ""))
		return ""
	end

	ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_GIVE)

	timer.Simple(1.2, function()
		if not IsValid(ply) then
			DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("unable", "/give", ""))
			return ""
		end

		if not ply:canAfford(amount) then
			DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("cant_afford_money", ""))
			return ""
		end

		local trace2 = ply:GetEyeTrace()
		local ent2 = trace2.Entity

		if not IsValid(ent2) or not ent2:IsPlayer() or ent2:GetPos():DistToSqr(ply:GetPos()) >= 22500 then return end

		DarkRP.payPlayer(ply, ent2, amount)

		hook.Call("playerGaveMoney", nil, ply, ent2, amount)

		DarkRP.notify(ent2, 0, 4, DarkRP.getPhrase("has_given", ply:Nick(), DarkRP.formatMoney(amount)))
		DarkRP.notify(ply, 0, 4, DarkRP.getPhrase("you_gave", ent2:Nick(), DarkRP.formatMoney(amount)))

		DarkRP.log(ply:Nick() .. " (" .. ply:SteamID() .. ") has given " .. DarkRP.formatMoney(amount) .. " to " .. ent2:Nick() .. " (" .. ent2:SteamID() .. ")")
	end)

	return ""

end

local function DropMoney(ply, args)

	if args == "" then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
		return ""
	end

	if not tonumber(args) then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
		return ""
	end

	local amount = math.floor(tonumber(args))

	if amount < 1 then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ">0"))
		return ""
	end

	if amount >= 2147483647 then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), "<2,147,483,647"))
		return ""
	end

	if not ply:canAfford(amount) then
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("cant_afford_money", ""))
		return ""
	end

	ply:addMoney(-amount)
	ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)

	timer.Simple(1, function()
		if not IsValid(ply) then return end

		local trace = {}
		trace.start = ply:EyePos()
		trace.endpos = trace.start + ply:GetAimVector() * 85
		trace.filter = ply

		local tr = util.TraceLine(trace)
		local moneybag = DarkRP.createMoneyBag(tr.HitPos, amount)

		DarkRP.placeEntity(moneybag, tr, ply)

		hook.Call("playerDroppedMoney", nil, ply, amount, moneybag)

		DarkRP.log(ply:Nick() .. " (" .. ply:SteamID() .. ") has dropped " .. DarkRP.formatMoney(amount))
	end)

	return ""

end

DarkRP.defineChatCommand("givemoney", GiveMoney, 0.2)
DarkRP.defineChatCommand("dropmoney", DropMoney, 0.3)


DarkRP.hookStub{

	name = "playerGaveMoney",
	description = "Called when a player gives another player money.",
	parameters = {
		{
			name = "player",
			description = "The player that gives the money.",
			type = "Player"
		},
		{
			name = "otherPlayer",
			description = "The player that receives the money.",
			type = "Player"
		},
		{
			name = "amount",
			description = "The amount of money.",
			type = "number"
		}
	},
	returns = {},
	realm = "Server"

}

DarkRP.hookStub{

	name = "playerDroppedMoney",
	description = "Called when a player drops some money.",
	parameters = {
		{
			name = "player",
			description = "The player who dropped the money.",
			type = "Player"
		},
		{
			name = "amount",
			description = "The amount of money dropped.",
			type = "number"
		},
		{
			name = "entity",
			description = "The entity of the money that was dropped.",
			type = "Entity"
		}
	},
	returns = {},
	realm = "Server"

}