JobBlips = {}
Logger.info("ManageBlip")
BlipManager = {
    RefreshBlips = function(job)
        job = job or ESX.PlayerData.job
        if job ~= nil and
            job.name == Config.jobKey then
            for zoneKey, zoneValue in pairs(Config.Zones) do
                if zoneValue.Blip then
                    if zoneValue.Blip and (On_duty or zoneValue.Type == "cloakroom") then
                        local blip = AddBlipForCoord(zoneValue.pos.x, zoneValue.pos.y, zoneValue.pos.z)

                        SetBlipSprite(blip, zoneValue.BlipInfos.sprite)
                        SetBlipDisplay(blip, 4)
                        SetBlipScale(blip, 0.8)
                        SetBlipCategory(blip, 3)
                        SetBlipAsShortRange(blip, true)

                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentSubstringPlayerName(zoneValue.Name)
                        EndTextCommandSetBlipName(blip)

                        table.insert(JobBlips, blip)
                    end
                end
            end
        end
    end,
    DeleteBlips = function()
        if JobBlips[1] ~= nil then
            for i = 1, #JobBlips, 1 do
                RemoveBlip(JobBlips[i])
                JobBlips[i] = nil
            end
        end
    end
}
