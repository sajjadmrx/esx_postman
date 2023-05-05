Logger.info("starting..")

On_duty = false


---@type Customers
CustomersData = Customers:new(nil, {})

function fetchDutyJob()
    ESX.TriggerServerCallback(ServerCallBackEvents.FetchDutyJob, function(result)
        On_duty = result
        GetPlayerSkin()
        BlipManager.RefreshBlips()
        TriggerEvent("esx_postman:updatedDuty")
    end)

    ESX.TriggerServerCallback(ServerCallBackEvents.GetCustomers, function(rep)
        if type(rep) == "table" then
            CustomersData:set(rep)
        end
    end)
end

function getRandomCoordsInRadius(center, radius)
    local x0, y0, z0 = table.unpack(center)
    local rd, t, u = math.random(), math.random(), math.random()
    local theta = 2 * math.pi * t
    local phi = math.acos(2 * u - 1)
    local r = radius * math.cbrt(rd)
    local x = x0 + r * math.sin(phi) * math.cos(theta)
    local y = y0 + r * math.sin(phi) * math.sin(theta)
    local z = z0 + r * math.cos(phi)
    return vector3(x, y, z)
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
