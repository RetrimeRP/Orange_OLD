hook.Add("DarkRPFinishedLoading", "retrime.TFA", function()

	hook.Remove("NotifyShouldTransmit", "TFA_AttachmentsRequest")

	hook.Remove("NetworkEntityCreated", "TFA_AttachmentsRequest")

	hook.Remove("OnEntityCreated", "TFA_AttachmentsRequest")

end)