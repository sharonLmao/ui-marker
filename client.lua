liczba = 0

RegisterNetEvent("3dme:me")
AddEventHandler("3dme:me", function(text, source, icon)
    local playerId = GetPlayerFromServerId(source)
    if playerId ~= -1 or source == GetPlayerServerId(PlayerId()) then
        local isDisplaying = true
        liczba = liczba + 1
        icon = 'comment-dots'
        local lastXXX = 0
        local lastYYY = 0
        Citizen.CreateThread(function()
            while isDisplaying do
                Citizen.Wait(0)
                local nearCoords = GetEntityCoords(PlayerPedId())
                local testcor = vector3(2829.993896, 1474.732544, 24.555395)
                distance = #(nearCoords - testcor)
                if distance < 25.0 then
                    DrawText3D(testcor, "[E] ")
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
                        onScreen = onScreen
                    })
                end
            end
            if isDisplaying == false then
                SendNUIMessage({ toggle = false })
            end
        end)
        Citizen.CreateThread(function()
            Citizen.Wait(100000)
            liczba = liczba - 1
            isDisplaying = false
            SendNUIMessage({ toggle = false })
        end)
    end
end)
