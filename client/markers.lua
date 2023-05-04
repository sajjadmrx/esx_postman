local CurrentAction, CurrentActionMsg, CurrentActionData
local menuIsShowed, TextUIdrawing = false, false




CreateThread(function()
    while true do
        local sleep = 1500
        local playerCoords = GetEntityCoords(ESX.PlayerData.ped)
        local isInMarker = false
        if ESX.PlayerData.job
            and ESX.PlayerData.job.name == JobKey then
            for k, v in pairs(Config.Zones) do
                local distance = #(playerCoords - v.pos)
                if v.Marker then
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
        if ESX.PlayerData.job and ESX.PlayerData.job.name == JobKey then
            if CurrentAction and not ESX.PlayerData.dead then
                sleep = 0;
                if not TextUIdrawing then
                    ESX.TextUI(CurrentActionMsg)
                    TextUIdrawing = true
                end
                if IsControlJustReleased(0, 38) then
                    if CurrentAction == Actions.ChangeClothes and not menuIsShowed then
                        OpenCloakRoomMenu()
                        ESX.HideUI()
                    elseif CurrentAction == Actions.VehicleSpawner then
                        TriggerEvent(EventsEnum.VehicleSpawner)
                    elseif CurrentAction == Actions.PickUpBoxes then
                        PickUpBoxesHandler()
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
    elseif zone == "boxes"
    then
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if IsPedInVehicle(playerPed, vehicle, true) then
            CurrentAction = Actions.PickUpBoxes
            CurrentActionMsg = Config.Zones.boxes.Hint
        end
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
            title = TranslateCap("TranslateCap"),
            icon = "fas fa-person-booth"
        },
        {
            title = TranslateCap("elements_postman_wear"),
            value = "on_duty",
            icon = "fas fa-clipboard-user"
        },
        {
            title = TranslateCap("elements_citizen_wear"),
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

local loading = false
function PickUpBoxesHandler()
    local time = Config.pickUpBoxesTime
    if IsWorking then
        ESX.ShowHelpNotification(TranslateCap("box_pickup_error"))
        return
    end
    if loading then
        ESX.TextUI(TranslateCap("moving_boxes_to_vehicle"))
        return;
    end


    loading = true

    local vehicle = getPedVehicle()
    if vehicle and GetIsVehicleEngineRunning(vehicle) then
        CreateThread(function()
            while loading do
                Wait(1)
                SetVehicleEngineOn(vehicle, false, true, false)
            end
        end)
    end

    ProgressBar(time)
    Wait(time)
    ESX.ShowHelpNotification(TranslateCap("boxes_moved_successfully"))
    IsWorking = true
    loading = false
end

function HideUI()
    menuIsShowed = false
    TextUIdrawing = false
    ESX.CloseContext()
    ESX.HideUI()
    TextUIdrawing = false
end

function ProgressBar(time)
    ESX.ShowHelpNotification(TranslateCap("moving_boxes_to_vehicle"))
end

function getPedVehicle()
    local PlayerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(PlayerPed)
    if IsPedInAnyVehicle(PlayerPed, false) then
        return vehicle
    else
        return nil
    end
end
