sKeypads.parties = {}

hook.Add("sParties_joinedParty", "Superior.Keypads",function(person, party)
    sKeypads.parties[party] = sKeypads.parties[party] or {}
    sKeypads.parties[party][person:SteamID()] = true
end)

hook.Add("sParties_abandonedParty", "Superior.Keypads",function(person, party)
    sKeypads.parties[party] = nil
end)

hook.Add("sParties_leftParty", "Superior.Keypads",function(person, party)
    sKeypads.parties[party] = sKeypads.parties[party] or {}
    sKeypads.parties[party][person:SteamID()] = nil
end)

local function findPartyByPlayer(ply)
    local sid = ply:SteamID()

    for k,v in pairs(sKeypads.parties) do 
        if v[sid] then return k end
    end
    return nil
end

function sKeypads.inSParty(owner, ply)
    if not sKeypads.Config.sparty_support then return false end

    local partyOfOwner = findPartyByPlayer(owner)
    if partyOfOwner == nil then return false end

    local partyOfPly = findPartyByPlayer(ply)
    if partyOfPly == nil then return false end

    return partyOfOwner == partyOfPly
end 