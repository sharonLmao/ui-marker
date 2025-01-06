RegisterCommand("test-marker", function(source, args, rawCommand)
    TriggerClientEvent('ui-marker:client:add-marker', source)
end, false)