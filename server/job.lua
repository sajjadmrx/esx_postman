SetCustomersKey = "esx_" .. Config.jobKey .. ":Customers_{identifier}"

--   Set Customers
ESX.RegisterServerCallback(ServerCallBackEvents.SetCustomers, function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local key = string
        .gsub(SetCustomersKey, "{identifier}", xPlayer.identifier)

    local onDuty = Cache[xPlayer.identifier] and true or false

    if Validate.Job(xPlayer) and onDuty then
        local currentCustomers = TableDeserialize(GetResourceKvpString(key))
        if currentCustomers == nil or currentCustomers[1] == nil then
            local jobs = FetchRandomLocations()
            SetResourceKvp(key, TableSerialize(jobs))
            cb({
                isOld = false,
                list = jobs
            })
        else
            cb({
                isOld = true,
                list = currentCustomers
            })
        end
    end
end)

AddEventHandler("esx_" .. JobKey .. ":DeleteCustomers", function(xPlayer)
    DeleteResourceKvpNoSync(string.gsub(SetCustomersKey, "{identifier}", xPlayer.identifier))
end)
