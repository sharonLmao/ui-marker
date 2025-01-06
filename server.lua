-- Add Test Marker in Current Location:
local testCount = 0
RegisterCommand("add-marker", function(source, args, rawCommand)
    local player = source
    local ped = GetPlayerPed(player)
    local coords = GetEntityCoords(ped)
    testCount = testCount + 1
    Config.targetCoords["testmarker"..testCount] = coords
    TriggerClientEvent('ui-marker:client:sync-markers', -1, Config.targetCoords)
    print("test marker added with id:", "testmarker"..testCount)
end, true)

-- Remove Marker by Name:
RegisterCommand("remove-marker", function(source, args, rawCommand)
    if #args < 1 then
        print("Missing name!")
        return
    end
    local name = args[1]
    if Config.targetCoords[name] then
        Config.targetCoords[name] = nil
        TriggerClientEvent('ui-marker:client:sync-markers', -1, Config.targetCoords)
    else
        print("Marker not found!")
    end
end, true)

-- Show All Markers:
RegisterCommand("show-markers", function(source, args, rawCommand)
    TriggerClientEvent('ui-marker:client:show-markers', source)
end, false)

-- Hide All Markers:
RegisterCommand("hide-markers", function(source, args, rawCommand)
    TriggerClientEvent('ui-marker:client:hide-markers', source)
end, false)

-- Delete All Markers:
RegisterCommand("clean-markers", function(source, args, rawCommand)
    TriggerClientEvent('ui-marker:client:clean-markers', source)
end, false)
