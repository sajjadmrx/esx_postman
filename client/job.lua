local currentCustomer = nil
local currentBlip = nil
AddEventHandler("esx_postman:updatedDuty", function()
    CreateThread(function()
        while On_duty do
            local sleep = 1500
            print(7)
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
                    if distance < (2.2 / 2) then
                        if IsPedInVehicle(playerPed, vehicle, true) then
                            if #CustomersData:find() == 1 then
                                CustomersData:pick(currentCustomer)
                                ESX.ShowNotification(TranslateCap("done"))
                            else
                                CustomersData:pick(currentCustomer)
                                ESX.TextUI(TranslateCap("done_customer", #CustomersData:find()));
                            end
                            ESX.TriggerServerCallback(ServerCallBackEvents.UpadateCustomers, function(rep)
                                if type(rep) == "boolean" and rep == false then
                                    --- invalid customer or off_duty
                                    return;
                                end
                            end, currentCustomer)
                            BlipManager.deleteBlipByBlip(currentBlip)
                            currentBlip = nil
                            currentCustomer = nil
                            DeleteWaypoint()
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end)
