local currentCustomer = nil
local currentBlip = nil
local TextUIdrawing = false
local loading = false
AddEventHandler("esx_postman:updatedDuty", function()
    CreateThread(function()
        while On_duty do
            local sleep = 1500
            if #CustomersData:find() and On_duty then
                sleep = 0;
                if currentCustomer == nil then
                    currentCustomer = CustomersData:get()
                    if type(currentCustomer) == "vector3" then
                        SetNewWaypoint(currentCustomer)
                        currentBlip = BlipManager.addBlip(currentCustomer, 267, "[postman] Customer")
                    end
                else
                    -- check target pos and player pos
                    local playerCoords = GetEntityCoords(ESX.PlayerData.ped);
                    local distance = #(playerCoords - currentCustomer)
                    local playerPed = ESX.PlayerData.ped
                    local vehicle = GetVehiclePedIsIn(playerPed, false);
                    if distance < 30 then
                        MarkerManager.Draw(4, currentCustomer, { x = 5.1, y = 0.1, z = 10.1 },
                            { r = 50, g = 200, b = 50, a = 200 })
                        ESX.HideUI()
                    end
                    if distance < (5.2 / 2) then
                        local vehModel = GetEntityModel(vehicle)
                        if vehModel ~= joaat(Config.Vehicle) then
                            ESX.TextUI(TranslateCap("invalid_vehicle"), "error")
                        else
                            if not TextUIdrawing then
                                -- ESX.TextUI("press [E] to call customer")
                                ESX.ShowHelpNotification(TranslateCap("call_customer", "E"))
                                TextUIdrawing = true
                            end
                            if IsPedInVehicle(playerPed, vehicle, true) then
                                if IsControlJustReleased(0, 38) then
                                    loading = true
                                    CreateThread(function()
                                        local vehicle = getPedVehicle()
                                        while loading do
                                            SetVehicleEngineOn(vehicle, false, true, false)
                                            Wait(0)
                                        end
                                    end)
                                    ESX.Progressbar(TranslateCap("moving_boxes_from_vehicle"), Config.progressbarTime, {
                                        FreezePlayer = true,
                                        onFinish = function()
                                            if #CustomersData:find() == 1 then
                                                CustomersData:pick(currentCustomer)
                                                ESX.ShowNotification(TranslateCap("done"))
                                            else
                                                CustomersData:pick(currentCustomer)
                                                ESX.TextUI(TranslateCap("done_customer", #CustomersData:find()),
                                                    "success");
                                                CreateThread(function()
                                                    Wait(2000)
                                                    ESX.HideUI()
                                                end)
                                            end
                                            ESX.TriggerServerCallback(ServerCallBackEvents.UpadateCustomers,
                                                function(rep)
                                                    if type(rep) == "boolean" and rep == false then
                                                        --- invalid customer or off_duty
                                                        return;
                                                    end
                                                end, currentCustomer)


                                            DeleteWaypoint()
                                            BlipManager.deleteBlipByBlip(currentBlip)
                                            currentBlip = nil
                                            currentCustomer = nil
                                            TextUIdrawing = false
                                            loading = false
                                        end
                                    })
                                end
                            end
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end)
