Logger.info("starting..")


On_duty = true
IsWorking = false
print(not On_duty)

RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
    BlipManager.RefreshBlips()
    Logger.info("playerLoaded")
end)

if ESX.PlayerLoaded then
    BlipManager.RefreshBlips()
end


RegisterNetEvent('esx:setJob', function(job)
    BlipManager.DeleteBlips()
    BlipManager.RefreshBlips(job)
end)
