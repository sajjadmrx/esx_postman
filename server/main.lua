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
