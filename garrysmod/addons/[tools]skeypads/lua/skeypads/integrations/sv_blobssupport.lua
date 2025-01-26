sKeypads.Utilities = sKeypads.Utilities or {}

--[[
    Blobs party support
]]--
local function whatBlobParty(ply)
    for a,b in pairs(BlobsParties) do
        for c,d in pairs(b.members) do
            if d == ply then
                return b.name
            end
        end
    end

    return nil
end

function sKeypads.Utilities.isInBlobsParty(ply1,ply2)
    if not sKeypads.Config.enable_blobs_party_support then return false end
    return whatBlobParty(ply1) == whatBlobParty(ply2)
end

