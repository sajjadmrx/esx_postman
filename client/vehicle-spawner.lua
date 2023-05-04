AddEventHandler(EventsEnum.VehicleSpawner, function()
    local spawnPoint = Config.Zones.VehicleSpawnPoint.pos

    local vehicles = ESX.Game.GetVehiclesInArea(spawnPoint, 10)
    if #vehicles > 0 then
        ESX.ShowNotification(TranslateCap("many_vehicles_area"), "error")
        return;
    end


    ESX.TriggerServerCallback(ServerCallBackEvents.SpawnVehicle, function(response)
        if type(response) == "string" then
            ESX.ShowNotification(response, "error")
        end
        ESX.HideUI()
    end)
end)
