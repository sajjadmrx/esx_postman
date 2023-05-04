function GetPlayerSkin()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if not On_duty then
            TriggerEvent('skinchanger:loadSkin', skin)
            return
        end
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
        else
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
        end
    end)
end
