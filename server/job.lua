SetCustomersKey = "esx_" .. Config.jobKey .. ":Customers_{identifier}"

--   Set Customers
ESX.RegisterServerCallback(ServerCallBackEvents.SetCustomers, function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local key = string
        .gsub(SetCustomersKey, "{identifier}", xPlayer.identifier)

    local onDuty = GetPlayerDuty(src)
    if Validate.Job(xPlayer) and onDuty then
        local currentCustomers = TableDeserialize(GetResourceKvpString(key))
        if currentCustomers == nil or currentCustomers[1] == nil then
            local jobs = FetchRandomLocations(Config.CustomerLength)
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

ESX.RegisterServerCallback(ServerCallBackEvents.GetCustomers, function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local key = string
        .gsub(SetCustomersKey, "{identifier}", xPlayer.identifier)

    local onDuty = GetPlayerDuty(src)
    if Validate.Job(xPlayer) and onDuty then
        local currentCustomers = TableDeserialize(GetResourceKvpString(key))
        if currentCustomers == nil or currentCustomers[1] == nil then
            cb(nil)
        else
            cb(currentCustomers)
        end
    end
end)

ESX.RegisterServerCallback(ServerCallBackEvents.UpadateCustomers, function(source, cb, customer)
    -- print(type(customer), cb[1])
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local key = string
        .gsub(SetCustomersKey, "{identifier}", xPlayer.identifier)

    local currentCustomers = TableDeserialize(GetResourceKvpString(key))

    local onDuty = GetPlayerDuty(src)
    if not onDuty then
        cb(false)
    end

    if currentCustomers == nil or currentCustomers[1] == nil then
        return cb(false)
    end

    local customersData = Customers:new(nil, currentCustomers)
    if not customersData:has(customer) then
        return cb(false)
    end

    customersData:pick(customer)
    local list = customersData:find()
    if #list < 1 then
        TriggerEvent("esx_" .. JobKey .. ":DeleteCustomers", xPlayer)
        cb(true)

        -- add money
        xPlayer.addMoney(Config.Money)
    else
        cb(list)
        SetResourceKvp(key, TableSerialize(list))
    end
end)

AddEventHandler("esx_" .. JobKey .. ":DeleteCustomers", function(xPlayer)
    DeleteResourceKvpNoSync(string.gsub(SetCustomersKey, "{identifier}", xPlayer.identifier))
end)
