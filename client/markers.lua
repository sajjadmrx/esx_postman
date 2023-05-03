local jobKey = Config.jobKey
local CurrentAction, CurrentActionMsg, CurrentActionData
local menuIsShowed, TextUIdrawing = false, false

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
        local playerCoords = GetEntityCoords(ESX.PlayerData.ped)
        local isInMarker = false
        if ESX.PlayerData.job
            and ESX.PlayerData.job.name == jobKey then
            for k, v in pairs(Config.Zones) do
                local distance = #(playerCoords - v.pos)
                if On_duty or v.Type == "cloakroom" then
                    if distance < v.Marker.drawDistance then
                        sleep = 0
                        MarkerManager.Draw(v.Marker.type, v.pos, v.Marker.size, v.Marker.color)
                    end
                    if distance < (v.Marker.size.x / 2) then
                        isInMarker = true
                        TriggerEvent(EventsEnum.EnteredMarker, k)
                    end
                end
            end
            if not isInMarker then
                TriggerEvent(EventsEnum.ExitedMarker)
            end
        end
        Wait(sleep)
    end
end)







CreateThread(function()
    while true do
        local sleep = 2000
        if ESX.PlayerData.job and ESX.PlayerData.job.name == jobKey then
            if CurrentAction and not ESX.PlayerData.dead then
                sleep = 0;
                if not TextUIdrawing then
                    ESX.TextUI(CurrentActionMsg)
                    TextUIdrawing = true
                end
                if IsControlJustReleased(0, 38) then
                    Logger.info("Action Handler:", CurrentAction)
                    if CurrentAction == Actions.ChangeClothes and not menuIsShowed then
                        OpenCloakRoomMenu()
                        ESX.HideUI()
                    end
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

AddEventHandler(EventsEnum.ExitedMarker, function(zone)
    CurrentAction = nil
    HideUI()
end)


function OpenCloakRoomMenu()
    menuIsShowed = true
    local elements = {
        {
            unselectable = "true",
            title = "Locker Room",
            icon = "fas fa-person-booth"
        },
        {
            title = "Postman wear | on duty",
            value = "on_duty",
            icon = "fas fa-clipboard-user"
        },
        {
            title = "Citizen wear | off duty",
            value = "off_duty",
            icon  = "fas fa-person-running"
        }
    }

    ESX.OpenContext("right", elements, function(menu, element)
        HideUI()
        if element.value == "off_duty" then
            On_duty = false
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
        elseif element.value == "on_duty" then
            On_duty = true

            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                end
            end)
        end

        BlipManager.DeleteBlips()
        BlipManager.RefreshBlips()
    end, function()
        HideUI()
    end)
end

function HideUI()
    menuIsShowed = false
    TextUIdrawing = false
    ESX.CloseContext()
    ESX.HideUI()
    TextUIdrawing = false
end
