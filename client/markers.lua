local jobKey = Config.jobKey
local CurrentAction, CurrentActionMsg, CurrentActionData
local EventsEnum = {
    EnteredMarker = "esx_" .. jobKey .. ":hasEnteredMarker",
    ExitedMarker = "esx_" .. jobKey .. ":hasExitedMarker",
}

local Actions = {
    VehicleSpawner = "vehicle_spawner",
    VehicleDeleter = "vehicle_deleter",
    ChangeClothes = "ChangeClothes"
}



CreateThread(function()
    while true do
        local sleep = 1500
        if ESX.PlayerData.job
            and ESX.PlayerData.job.name == jobKey then
            sleep = 0

            local playerCoords = GetEntityCoords(PlayerPedId())
            local isInMarker, currentZone = false, nil

            for k, v in pairs(Config.Zones) do
                local zonePos = v.pos
                local distance = #(playerCoords - zonePos)
                local distanceAre = (v.Size.x)
                if distance < v.Marker.drawDistance then
                    MarkerManager
                        .Draw(v.Marker.type, zonePos, v.Marker.size, v.Marker.color)
                end
                if distance <= distanceAre then
                    isInMarker, currentZone = true, k
                end
                if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                    HasAlreadyEnteredMarker, LastZone = true, currentZone
                    TriggerEvent(EventsEnum.EnteredMarker, currentZone)
                end
                if not isInMarker and HasAlreadyEnteredMarker then
                    HasAlreadyEnteredMarker = false
                    TriggerEvent(EventsEnum.ExitedMarker, LastZone)
                end
            end
        end
        Wait(sleep)
    end
end)


AddEventHandler(EventsEnum.EnteredMarker, function(zone)
    if zone == "CloakRoom" then
        CurrentAction = Actions.ChangeClothes
        CurrentActionMsg = Config.Zones.CloakRoom.Hint
        CurrentActionData = {}
    elseif zone == "VehiclesSpawner" then
        CurrentAction = Actions.VehicleSpawner
        CurrentActionMsg = Config.Zones.VehiclesSpawner.Hint
        CurrentActionData = {}
    end
end)

AddEventHandler(EventsEnum.ExitedMarker, function()
    ESX.CloseContext()
    CurrentAction = nil
end)


CreateThread(function()
    while true do
        local sleep = 2000
        if ESX.PlayerData.job and ESX.PlayerData.job.name == jobKey then
            if CurrentAction and not ESX.PlayerData.dead then
                sleep = 0;
                ESX.ShowHelpNotification(CurrentActionMsg)
                if IsControlJustReleased(0, 38) then
                    Logger.info("Action Handler:", CurrentAction)
                end
            end
        end
        Wait(sleep)
    end
end)
