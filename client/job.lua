local currentCustomer = nil
CreateThread(function()
    while true do
        local sleep = 1500
        if #CustomersData:find() and On_duty then
            sleep = 0;
            if currentCustomer == nil then
                currentCustomer = CustomersData:get()
                if type(currentCustomer) == "vector3" then
                    SetNewWaypoint(currentCustomer)
                end
            else
                -- check target pos and player pos
                local playerCoords = GetEntityCoords(ESX.PlayerData.ped);
                local distance = #(playerCoords - currentCustomer)
                local playerPed = PlayerPedId()
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
                            ESX.ShowNotification("Done Job")
                        else
                            CustomersData:pick(currentCustomer)
                            ESX.TextUI("successfully Job, Next" .. "Total Customer:" .. #CustomersData:find());
                        end
                        ESX.TriggerServerCallback(ServerCallBackEvents.UpadateCustomers, function(rep)
                            if type(rep) == "boolean" and rep == false then
                                --- invalid custoemr or off_duty
                                return;
                            end
                        end, currentCustomer)
                        currentCustomer = nil
                        DeleteWaypoint()
                    end
                end
            end
        end
        Wait(sleep)
    end
end)
