-- server.lua (optional - kan bruges til logging)
ESX = exports['es_extended']:getSharedObject()

-- Log når politi skifter distrikt (optional)
RegisterNetEvent('district:log')
AddEventHandler('district:log', function(district)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        print(('[DISTRIKT] %s (%s) bevægede sig ind i %s'):format(xPlayer.getName(), xPlayer.identifier, district))
    end
end)