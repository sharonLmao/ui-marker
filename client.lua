local isDisplaying = true

-- Citizen.CreateThread(function()
--     while true do
--         local ped = PlayerPedId()
--         local pedCo = GetEntityCoords(ped)
--         local sleep = 1000
--         for _, targetCoords in ipairs(Config.targetCoords) do
--             local placeDist = #(pedCo - targetCoords)
--             if placeDist <= 1.2 then
--                 sleep = 7
--             end
--         end
--         Citizen.Wait(sleep)
--     end
-- end)

Citizen.CreateThread(function()
    while true do
        if NetworkIsPlayerActive(PlayerId()) then
            print("Player has logged in.")
            break
        end
        Citizen.Wait(500)
    end
    StartShowingMarkers()
end)

RegisterNetEvent('ui-marker:client:sync-markers')
AddEventHandler('ui-marker:client:sync-markers', function(newMarkers)
    Config.targetCoords = newMarkers
end)

function StartShowingMarkers()
    local lastXXX = 0
    local lastYYY = 0
    local playerCoords = vector3(0, 0, 0)
    local distance = 0
    Citizen.CreateThread(function()
        while isDisplaying do
            Citizen.Wait(0)
            playerCoords = GetEntityCoords(PlayerPedId())
            for name, targetCoords in pairs(Config.targetCoords) do
                distance = #(playerCoords - targetCoords)
                if distance < 25.0 then
                    DrawText3D(targetCoords, "[E] " .. name)
                end
                local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(targetCoords.x, targetCoords.y, targetCoords.z)
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
                        action = "moveMarkers",
                        id = name,
                        xxx = xxx * 100,
                        yyy = yyy * 100,
                        distance = distance,
                        onScreen = onScreen,
                        left = PrintDistanceToTarget(distance)
                    })
                end
            end
        end
    end)
end

RegisterNetEvent("ui-marker:client:show-markers")
AddEventHandler("ui-marker:client:show-markers", function()
    if not isDisplaying then
        isDisplaying = true
        StartShowingMarkers()
    end
end)

RegisterNetEvent("ui-marker:client:hide-markers")
AddEventHandler("ui-marker:client:hide-markers", function()
    if isDisplaying then
        isDisplaying = false
        SendNUIMessage({ action = "hideAllMarkers" })
    end
end)

RegisterNetEvent("ui-marker:client:clean-markers")
AddEventHandler("ui-marker:client:clean-markers", function()
    if isDisplaying then
        isDisplaying = false
        SendNUIMessage({ action = "removeAllMarkers" })
    end
end)
