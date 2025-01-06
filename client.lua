function PrintDistanceToTarget(distance)
    if ShouldUseMetricMeasurements() then
        local distanceInKm = distance / 1000
        return string.format("%.5f km.", distanceInKm)
    else
        local distanceInMiles = distance / 1609.34
        return string.format("%.0f mi.", distanceInMiles)
    end
end

function DrawText3D(coords, text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

RegisterNetEvent("ui-marker:client:add-marker")
AddEventHandler("ui-marker:client:add-marker", function()
    local isDisplaying = true
    local lastXXX = 0
    local lastYYY = 0
    local playerCoords = vector3(0, 0, 0)
    local distance = 0
    Citizen.CreateThread(function()
        while isDisplaying do
            Citizen.Wait(0)
            playerCoords = GetEntityCoords(PlayerPedId())
            distance = #(playerCoords - Config.targetCoords)
            if distance < 25.0 then
                DrawText3D(Config.targetCoords, "[E] ")
            end
            local onScreen, xxx, yyy =
                GetHudScreenPositionFromWorldPosition(
                    2829.993896,
                    1474.732544,
                    24.555395)
            if onScreen == 1 then -- up
                yyy = 0
            end
            if onScreen == 2 then -- right
                xxx = 1
            end
            if onScreen == 3 then -- down
                yyy = 1
            end
            if onScreen == 4 then -- left
                xxx = 0
            end
            if lastXXX ~= xxx or lastYYY ~= yyy then
                lastXXX = xxx
                lastYYY = yyy
                SendNUIMessage({
                    toggle = true,
                    xxx = xxx * 100,
                    yyy = yyy * 100,
                    distance = distance,
                    onScreen = onScreen,
                    left = PrintDistanceToTarget(distance)
                })
            end
        end
        if isDisplaying == false then
            SendNUIMessage({ toggle = false })
        end
    end)
    Citizen.CreateThread(function()
        Citizen.Wait(100000)
        isDisplaying = false
        SendNUIMessage({ toggle = false })
    end)
end)
