Logger.info("starting..")
RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
    BlipManager.RefreshBlips()
    Logger.info("playerLoaded")
end)

if ESX.PlayerLoaded then
    BlipManager.RefreshBlips()
end
