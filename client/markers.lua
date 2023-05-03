CreateThread(function()
    while true do
        local sleep = 1500
        -- if ESX.PlayerData.job
        --     and ESX.PlayerData.job.name == Config.jobKey then
        sleep = 0

        local playerCoords = GetEntityCoords(PlayerPedId())
        local isInMarker, currentZone = false, nil

        for k, v in pairs(Config.Zones) do
            local zonePos = v.pos
            local distance = #(playerCoords - zonePos)

            if distance < v.Marker.drawDistance then
                isInMarker = true
                currentZone = k
                MarkerManager
                    .Draw(v.Marker.type, zonePos, v.Marker.size, v.Marker.color)
            else
                isInMarker = false
            end
        end
        -- end
        Wait(sleep)
    end
end)
