---comment
---@param src any
---@return boolean
function GetPlayerDuty(src)
    local key = "esx_" .. Config.jobKey .. ":on_duty_{identifier}"
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer and xPlayer.job and xPlayer.job.name == Config.jobKey then
        key = string.gsub(key, "{identifier}", xPlayer.identifier)
        local value = GetResourceKvpString(key)
        if value == nil or value ~= "true" then
            return false
        end

        return true
    else
        return false
    end
end
