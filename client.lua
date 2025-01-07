local isDisplaying = true
local sleep = 0.6

function StartShowingMarkers()
    local lastXXX = 0
    local lastYYY = 0
    local playerCoords = vector3(0, 0, 0)
    local distance = 0
    sleep = 0.6
    Citizen.CreateThread(function()
        local delayPlayerPos = 0
        while isDisplaying do
            delayPlayerPos = delayPlayerPos + 0.6
            if delayPlayerPos >= 60 then
                delayPlayerPos = 0
                playerCoords = GetEntityCoords(PlayerPedId())
            end
            local hiddenCount = 0
            local totalCount = 0
            for name, target in pairs(Config.targetCoords) do
                totalCount = totalCount + 1
                if target.hide then
                    if target.show then
                        target.hide = false
                    end
                    hiddenCount = hiddenCount + 1
                else
                    if not target.show then
                        target.hide = true
                    end
                    distance = #(playerCoords - target.coords)
                    local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(target.coords.x, target.coords.y, target.coords.z)
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
                            label = target.label,
                            labeldistance = target.distance,
                            show = target.show,
                            xxx = xxx * 100,
                            yyy = yyy * 100,
                            distance = distance,
                            onScreen = onScreen,
                            left = PrintDistanceToTarget(distance)
                        })
                    end
                end
            end
            print("Hide Now?", "Hidden Count:", hiddenCount, "Total Count:", totalCount)
            if hiddenCount == totalCount then -- All coordinades are hidden
                sleep = 1000
            else
                sleep = 0.6
            end
            Citizen.Wait(sleep)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        if NetworkIsPlayerActive(PlayerId()) then
            print("Player has logged in.")
            break
        end
        Citizen.Wait(500)
    end
    Wait(2300)
    StartShowingMarkers()
    print("^2UI-MARKER v1.0.0 created by Sharon and Burgil^0")
    print("^3Commands:^0")
    print("^5WIP /add-marker [name] [x] [y] [z]^0 - Adds a marker at the specified coordinates.")
    print("^5/add-marker^0 - Adds a marker at the current coordinates with a test ID.")
    print("^5/remove-marker [name]^0 - Removes the marker with the specified name.")
    print("^5/show-marker [name]^0 - Shows the marker with the specified name.")
    print("^5/hide-marker [name]^0 - Hides the marker with the specified name.")
    print("^5/show-markers^0 - Shows all markers.")
    print("^5/hide-markers^0 - Hides all markers.")
    print("^5/clean-markers^0 - Deletes all markers.")
end)

RegisterNetEvent('ui-marker:client:add-marker')
AddEventHandler('ui-marker:client:add-marker', function(markerName, markerPosition)
    Config.targetCoords[markerName] = markerPosition
    -- When markers update they arleady get created if they dont exist by the UI
    print("Marker added with id:", markerName)
end)

RegisterNetEvent('ui-marker:client:remove-marker')
AddEventHandler('ui-marker:client:remove-marker', function(markerName)
    if Config.targetCoords[markerName] then
        Config.targetCoords[markerName] = nil
        SendNUIMessage({ action = "removeSpecificMarker", id = markerName })
        print(markerName, "Marker removed!")
    else
        print(markerName, "Marker not found!")
    end
end)

RegisterNetEvent('ui-marker:client:show-marker')
AddEventHandler('ui-marker:client:show-marker', function(markerName)
    if Config.targetCoords[markerName] then
        Config.targetCoords[markerName].show = true
        SendNUIMessage({ action = "showSpecificMarker", id = markerName })
        print(markerName, "Marker shown!")
    else
        print(markerName, "Marker not found!")
    end
end)

RegisterNetEvent('ui-marker:client:hide-marker')
AddEventHandler('ui-marker:client:hide-marker', function(markerName)
    if Config.targetCoords[markerName] then
        Config.targetCoords[markerName].show = false
        SendNUIMessage({ action = "hideSpecificMarker", id = markerName })
        print(markerName, "Marker hidden!")
    else
        print(markerName, "Marker not found!")
    end
end)

RegisterNetEvent("ui-marker:client:show-markers")
AddEventHandler("ui-marker:client:show-markers", function()
    Citizen.CreateThread(function()
        print("Show all markers")
        sleep = 0.6
        for name, target in pairs(Config.targetCoords) do
            target.show = true
        end
        if not isDisplaying then
            isDisplaying = true
            StartShowingMarkers()
        end
        Wait(2300)
        SendNUIMessage({ action = "showAllMarkers" })
    end)
end)

RegisterNetEvent("ui-marker:client:hide-markers")
AddEventHandler("ui-marker:client:hide-markers", function()
    Citizen.CreateThread(function()
        if isDisplaying then
            sleep = 0.6
            isDisplaying = false
            print("Hide all markers")
            for name, target in pairs(Config.targetCoords) do
                target.show = false
            end
            SendNUIMessage({ action = "hideAllMarkers" })
        end
    end)
end)

RegisterNetEvent("ui-marker:client:clean-markers")
AddEventHandler("ui-marker:client:clean-markers", function()
    if isDisplaying then
        isDisplaying = false
        Config.targetCoords = {}
        SendNUIMessage({ action = "cleanAllMarkers" })
        print("Deleted all markers")
    end
end)
