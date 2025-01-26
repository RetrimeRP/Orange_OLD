hook.Add("IGS.Loaded", "retrime.Sale", function()
	local sale = GetGlobalInt("retrime.Sale", 0)

	if sale and sale ~= 0 then
		for k, v in ipairs(IGS.GetItems()) do
			local old = v:Price()
			local new = old * (1 - (sale / 100))

			v:SetPrice(new)
			v:SetDiscountedFrom(old)
		end
	end
end)