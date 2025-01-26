backup = backup or {}

backup["http.Fetch"] = backup["http.Fetch"] or http.Fetch

local filter = {"kvac.cz", "api.omega-project.cz"}

function http.Fetch(url, success, failure, headers)
    for i = 1, #filter do
        local result = url:find(filter[i])

        if (!result) then continue end
        print("Finded "..url)
        return false
    end

    return backup["http.Fetch"](url, success, failure, headers)
end