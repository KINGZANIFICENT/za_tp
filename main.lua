Citizen.CreateThread(function()
    for index, location in ipairs(Config.TeleportLocations) do
        exports['qb-target']:AddCircleZone("teleport_entrance_" .. index, location.entrance.coords, 1.5, {
            name = "teleport_entrance_" .. index,
            debugPoly = false,
            useZ = true,
        }, {
            options = {
                {
                    type = "client",
                    event = "teleport:client:handleTeleport",
                    icon = "fas fa-sign-in-alt",
                    label = location.entrance.label,
                    teleportData = {
                        destination = location.exit.coords,
                        message = "Teleported from entrance to exit."
                    }
                }
            },
            distance = 2.5
        })


        exports['qb-target']:AddCircleZone("teleport_exit_" .. index, location.exit.coords, 1.5, {
            name = "teleport_exit_" .. index,
            debugPoly = false,
            useZ = true,
        }, {
            options = {
                {
                    type = "client",
                    event = "teleport:client:handleTeleport",
                    icon = "fas fa-sign-out-alt",
                    label = location.exit.label,
                    teleportData = {
                        destination = location.entrance.coords,
                        message = "Teleported from exit to entrance."
                    }
                }
            },
            distance = 2.5
        })
    end
end)


RegisterNetEvent('teleport:client:handleTeleport', function(data)
    if data and data.teleportData and data.teleportData.destination then
        local destination = data.teleportData.destination
        local playerPed = PlayerPedId()
        SetEntityCoords(playerPed, destination.x, destination.y, destination.z, false, false, false, true)
        TriggerEvent('za:notify', data.teleportData.message or "Teleported!")
    else
        TriggerEvent('za:notify', "Teleport destination not defined!")
    end
end)
