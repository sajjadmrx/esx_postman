DbRepo = {}

---@param identifier number
---@return number
DbRepo.GetDutyJob = function(identifier)
    local items = MySQL.query.await(
        "SELECT " .. Config.sqlStatusDuty .. " FROM users WHERE identifier=?", { identifier })
    return items[1].is_duty_job or 0
end
