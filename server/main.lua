Logger.info("Hello World")

ESX.RegisterServerCallback(ServerCallBackEvents.SpawnVehicle, function(source, cb)
    local src = source;
    local xPlayer = ESX.GetPlayerFromId(src);
    local spawnPoint = Config.Zones.VehicleSpawnPoint.pos
    if not xPlayer.job or xPlayer.job.name ~= Config.jobKey then
        print(('[^3WARNING^7] Player ^5%s^7 attempted to Exploit Vehicle Spawing!!'):format(source))
        return
    end

    ESX.OneSync.SpawnVehicle("rumpo2", spawnPoint, 500.0, {}, function(netId)
        local vNet = NetworkGetEntityFromNetworkId(netId)
        local breakTime = 0;
        while DoesEntityExist(vNet) and GetPedInVehicleSeat(vNet, -1) ~= GetPlayerPed(src) do
            Wait(math.random(1, 10))
            TaskWarpPedIntoVehicle(GetPlayerPed(src), vNet, -1)
            if breakTime > 10 then
                break;
            end
            breakTime = breakTime + 1;
        end
    end)
end)



local Actives = {}
local key = "esx_" .. Config.jobKey .. ":on_duty_{identifier}"
ESX.RegisterServerCallback(ServerCallBackEvents.FetchDutyJob, function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.job and xPlayer.job.name == Config.jobKey then
        -- cb(Actives[xPlayer.identifier] and true or false)
        local value = GetResourceKvpString(string.gsub(key, "{identifier}", xPlayer.identifier))
        if value == nil or value ~= "true" then
            cb(false)
            return
        end

        cb(true)
    else
        cb(false)
    end
end)


RegisterNetEvent(ServerEvents.ToggleDutyJob, function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer and xPlayer.job and xPlayer.job.name == Config.jobKey then
        local key = string.gsub(key, "{identifier}", xPlayer.identifier)
        local on_duty = GetResourceKvpString(key)
        if on_duty == nil or on_duty == "false" then
            SetResourceKvp(key, "true")
        else
            SetResourceKvp(key, "false")
        end
    end
end)

-- DELETE_RESOURCE_KVP
RegisterCommand("esx:" .. Config.jobKey .. "_reset_kvp", function(source)
    local x = source
    if x ~= 0 then
        return;
    end
    DeleteResourceKvp("postman_job")
    print("DELETED", x)
end)
