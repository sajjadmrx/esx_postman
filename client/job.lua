local currentCustomer = nil
CreateThread(function()
    while true do
        local sleep = 1500
        if #GetAllCustomers() and On_duty then
            sleep = 0;
            if currentCustomer == nil then
                currentCustomer = GetCustomer()
                if type(currentCustomer) == "vector3" then
                    SetNewWaypoint(currentCustomer)
                end
            else
                -- check target pos and player pos
                local playerCoords = GetEntityCoords(ESX.PlayerData.ped);
                local distance = #(playerCoords - currentCustomer)
                if distance < 30 then
                    MarkerManager.Draw(4, currentCustomer, { x = 5.1, y = 0.1, z = 10.1 },
                        { r = 50, g = 200, b = 50, a = 200 })
                    ESX.HideUI()
                end
                if distance < (2.2 / 2) then
                    if #GetAllCustomers() == 1 then
                        PickCustomer(currentCustomer)
                        -- call server
                        ESX.ClearTimeout("its Done ! ")
                    else
                        PickCustomer(currentCustomer)
                        ESX.TextUI("successfully Job, Next" .. "Total Customer:" .. #GetAllCustomers());
                    end
                    currentCustomer = nil
                    DeleteWaypoint()
                end
            end
        end
        Wait(sleep)
    end
end)
