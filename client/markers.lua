local CurrentAction, CurrentActionMsg, CurrentActionData
local menuIsShowed, TextUIdrawing = false, false




CreateThread(function()
    while true do
        local sleep = 2000
        if ESX.PlayerData.job and ESX.PlayerData.job.name == JobKey then
            local playerCoords = GetEntityCoords(ESX.PlayerData.ped)
            local isInMarker = false
            local lastZone;

            sleep = 1500
            for k, v in pairs(Config.Zones) do
                local distance = #(playerCoords - v.pos)
                if v.Marker then
                    if On_duty or v.Type == "cloakroom" then
                        if distance < v.Marker.drawDistance then
                            sleep = 5
                            RemovePeskyVehicles()
                            MarkerManager.Draw(v.Marker.type, v.pos, v.Marker.size, v.Marker.color)
                            lastZone = v.Type
                        else
                            lastZone = nil
                        end
                        if distance < (v.Marker.size.x / 2) then
                            isInMarker = true
                            TriggerEvent(EventsEnum.EnteredMarker, k)
                        else
                            if not isInMarker then
                                TriggerEvent(EventsEnum.ExitedMarker, lastZone)
                            end
                        end
                    end
                end
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
    if zone ~= nil then
        CurrentAction = nil
        HideUI()
    end
end)


function OpenCloakRoomMenu()
    menuIsShowed = true
    local elements = {
        {
            unselectable = "true",
            title = TranslateCap("elements_Locker_Room"),
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
            GetPlayerSkin()
            CustomersData:clear()
        elseif element.value == "on_duty" then
            On_duty = true
            GetPlayerSkin()
        end

        BlipManager.DeleteBlips()
        BlipManager.RefreshBlips()
        TriggerServerEvent(ServerEvents.ToggleDutyJob)
    end, function()
        HideUI()
    end)
end

local loading = false
function PickUpBoxesHandler()
    local time = Config.pickUpBoxesTime
    if #CustomersData:find() > 0 then
        ESX.TextUI(TranslateCap("box_pickup_error"), "error")
        return
    end
    if loading then
        ESX.TextUI(TranslateCap("moving_boxes_to_vehicle"), "error")
        return;
    end


    loading = true

    ESX.TriggerServerCallback(ServerCallBackEvents.SetCustomers, function(resp)
        if resp.isOld then
            --error
            loading = false
            ESX.TextUI(TranslateCap("box_pickup_error"), "error")

            CustomersData:set(resp.list)
        else
            --        if vehicle and GetIsVehicleEngineRunning(vehicle) then
            CreateThread(function()
                local vehicle = getPedVehicle()
                while loading do -- and vehicle and VehicleEngineRunning do
                    vehicle = getPedVehicle()
                    SetVehicleEngineOn(vehicle, false, true, false)
                    Wait(0)
                end
            end)
            --    end
            ProgressBar(TranslateCap("moving_boxes_to_vehicle"), time, function()
                ESX.ShowHelpNotification(TranslateCap("boxes_moved_successfully"))
                loading = false

                CustomersData:set(resp.list)
            end)
        end
    end)
end

function HideUI()
    menuIsShowed = false
    TextUIdrawing = false
    ESX.CloseContext()
    ESX.HideUI()
    TextUIdrawing = false
end

function ProgressBar(text, time, cb)
    ESX.Progressbar(text, time, {
        FreezePlayer = true,
        onFinish = function()
            cb()
        end
    })
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
