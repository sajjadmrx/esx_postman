function GetPlayerSkin()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if not On_duty then
            TriggerEvent('skinchanger:loadSkin', skin)
            return
        end
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male)
        else
            TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.female)
        end
    end)
end

function RemovePeskyVehicles(range)
    range = range or 15
    local pos = vector3(71.9553, 119.3413, 79.1718)

    RemoveVehiclesFromGeneratorsInArea(
        pos.x - range, pos.y - range, pos.z - range,
        pos.x + range, pos.y + range, pos.z + range
    );
end
