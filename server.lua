-- RegisterCommand("test-marker", function(source, args, rawCommand)
--     local player = source
--     local ped = GetPlayerPed(player)
--     local coords = GetEntityCoords(ped)
--     TriggerClientEvent('ui-marker:client:add-marker', player, coords)
-- end, false)

local testCount = 0
RegisterCommand("add-marker", function(source, args, rawCommand)
    local player = source
    local ped = GetPlayerPed(player)
    local coords = GetEntityCoords(ped)
    testCount = testCount + 1
    Config.targetCoords["test"..testCount] = coords
    TriggerClientEvent('ui-marker:client:sync-markers', -1, Config.targetCoords)
end, true)

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
