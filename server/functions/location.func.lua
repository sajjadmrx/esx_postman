function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

---comment
---@param count number
---@return table
FetchRandomLocations = function(count)
    count = count or 3
    if count > #Config.JobLocations then count = #Config.JobLocations end
    local indexes = {}
    while #indexes < count do
        local index = math.random(1, #Config.JobLocations)
        if not table.contains(indexes, index) then
            table.insert(indexes, index)
        end
    end
    local locations = {}
    for i = 1, #indexes do
        table.insert(locations, Config.JobLocations[indexes[i]])
    end
    return locations
end
