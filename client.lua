local isDisplaying = true

function StartShowingMarkers()
    local lastXXX = 0
    local lastYYY = 0
    local playerCoords = vector3(0, 0, 0)
    local distance = 0
    Citizen.CreateThread(function()
        local delayPlayerPos = 0
        while isDisplaying do
            Citizen.Wait(0.6)
            delayPlayerPos = delayPlayerPos + 0.6
            if delayPlayerPos >= 60 then
                delayPlayerPos = 0
                playerCoords = GetEntityCoords(PlayerPedId())
            end
            for name, target in pairs(Config.targetCoords) do
                if target.hide then
                    if target.showbydefualt then
                        target.hide = false
                    end
                else
                    if not target.showbydefualt then
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
                            showbydefualt = target.showbydefualt,
                            xxx = xxx * 100,
                            yyy = yyy * 100,
                            distance = distance,
                            onScreen = onScreen,
                            left = PrintDistanceToTarget(distance)
                        })
                    end
                end
            end
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
        Config.targetCoords[markerName].showbydefualt = true
        Config.targetCoords[markerName].hide = false
        SendNUIMessage({ action = "showSpecificMarker", id = markerName })
        print(markerName, "Marker shown!")
    else
        print(markerName, "Marker not found!")
    end
end)

RegisterNetEvent('ui-marker:client:hide-marker')
AddEventHandler('ui-marker:client:hide-marker', function(markerName)
    if Config.targetCoords[markerName] then
        Config.targetCoords[markerName].showbydefualt = false
        Config.targetCoords[markerName].hide = true
        SendNUIMessage({ action = "hideSpecificMarker", id = markerName })
        print(markerName, "Marker hidden!")
    else
        print(markerName, "Marker not found!")
    end
end)

RegisterNetEvent("ui-marker:client:show-markers")
AddEventHandler("ui-marker:client:show-markers", function()
    if not isDisplaying then
        isDisplaying = true
        StartShowingMarkers()
        SendNUIMessage({ action = "showAllMarkers" })
        print("Show all markers")
    end
end)

RegisterNetEvent("ui-marker:client:hide-markers")
AddEventHandler("ui-marker:client:hide-markers", function()
    if isDisplaying then
        isDisplaying = false
        SendNUIMessage({ action = "hideAllMarkers" })
        print("Hide all markers")
    end
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
