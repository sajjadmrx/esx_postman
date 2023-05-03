JobBlips = {}
Logger.info("ManageBlip")
BlipManager = {
    RefreshBlips = function()
        if ESX.PlayerData.job ~= nil then
            for zoneKey, zoneValue in pairs(Config.Zones) do
                if zoneValue.Blip then
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

}
