-- Add Test Marker in Current Location:
local testCount = 0
RegisterCommand("add-marker", function(source, args, rawCommand)
    local player = source
    local ped = GetPlayerPed(player)
    local coords = GetEntityCoords(ped)
    testCount = testCount + 1
    TriggerClientEvent('ui-marker:client:add-marker', source, "testmarker" .. testCount, coords)
end, true)

-- Remove Marker by Name:
RegisterCommand("remove-marker", function(source, args, rawCommand)
    if #args < 1 then
        print("Missing name!")
        return
    end
    local name = args[1]
    TriggerClientEvent('ui-marker:client:remove-marker', source, name)
end, true)

-- Show All Markers:
RegisterCommand("show-markers", function(source, args, rawCommand)
    TriggerClientEvent('ui-marker:client:show-markers', source)
end, false)

function ShowMarkers()
    TriggerClientEvent('ui-marker:client:show-markers', source)
end

exports("ShowMarkers", ShowMarkers);

-- Hide All Markers:
RegisterCommand("hide-markers", function(source, args, rawCommand)
    TriggerClientEvent('ui-marker:client:hide-markers', source)
end, false)

function HideMarkers()
    TriggerClientEvent('ui-marker:client:hide-markers', source)
end

exports("HideMarkers", HideMarkers);

-- Show Specific Markers:
RegisterCommand("show-marker", function(source, args, rawCommand)
    if #args < 1 then
        print("Missing name!")
        return
    end
    local name = args[1]
    TriggerClientEvent('ui-marker:client:show-marker', source, name)
end, false)

function ShowMarker(source, name)
    print("Showing marker with name: " .. name)
    TriggerClientEvent('ui-marker:client:show-marker', source, name)
end

exports("ShowMarker", ShowMarker);

RegisterCommand("show-marker-group", function(source, args, rawCommand)
    if #args < 1 then
        print("Missing name!")
        return
    end
    local name = args[1]
    TriggerClientEvent('ui-marker:client:show-marker', source, name)
end, false)

function ShowMarkerForGroup(groupID, name)
    print("Showing marker for group with name: " .. name)
    local groupmembers = exports["ps-playergroups"]:getGroupMembers(groupID)
    if groupmembers[1] then
        TriggerClientEvent("ui-marker:client:show-marker", groupmembers[1], name)
    end
    if groupmembers[2] then
        TriggerClientEvent("ui-marker:client:show-marker", groupmembers[2], name)
    end
    if groupmembers[3] then
        TriggerClientEvent("ui-marker:client:show-marker", groupmembers[3], name)
    end
    if groupmembers[4] then
        TriggerClientEvent("ui-marker:client:show-marker", groupmembers[4], name)
    end
end

exports("ShowMarkerForGroup", ShowMarkerForGroup);


-- Hide Specific Markers:
RegisterCommand("hide-marker", function(source, args, rawCommand)
    if #args < 1 then
        print("Missing name!")
        return
    end
    local name = args[1]
    TriggerClientEvent('ui-marker:client:hide-marker', source, name)
end, false)

function HideMarker(source, name)
    if Config.debug then print("Hiding marker with name: " .. name .. " For player id: " .. source) end
    TriggerClientEvent('ui-marker:client:hide-marker', source, name)
end

exports("HideMarker", HideMarker);

-- Delete All Markers:
RegisterCommand("clean-markers", function(source, args, rawCommand)
    TriggerClientEvent('ui-marker:client:clean-markers', source)
end, false)
