Logger.info("starting..")


On_duty = false
IsWorking = false

function fetchDutyJob()
    ESX.TriggerServerCallback(ServerCallBackEvents.FetchDutyJob, function(result)
        On_duty = result
        GetPlayerSkin()
        BlipManager.RefreshBlips()
    end)
end

RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
    fetchDutyJob()
    Logger.info("playerLoaded")
end)

if ESX.PlayerLoaded then
    fetchDutyJob()
end




RegisterNetEvent('esx:setJob', function(job)
    BlipManager.DeleteBlips()
    BlipManager.RefreshBlips(job)
end)
