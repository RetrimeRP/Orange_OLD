sKeypads.TeamSupport = {}

function sKeypads.TeamSupport.CanOpenDoor(door,ply)
    if not sKeypads.Config.allow_teams_keypads then return false end

    local plyTeam = ply:Team()
    local meta = door:getMeta()
    for k,v in pairs(meta.teams) do
        if k == plyTeam then return true end
    end
    return false
end

function sKeypads.TeamSupport.AddTeamToDoor(door,team)
    if not sKeypads.Config.allow_teams_keypads then return end

    door:getMeta():addTeam(team)
end

function sKeypads.TeamSupport.RemoveTeamFromDoor(door, team)
    if not sKeypads.Config.allow_teams_keypads then return end

    door:getMeta():removeTeam(team)
end