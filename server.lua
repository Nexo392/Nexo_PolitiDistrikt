ESX = exports['es_extended']:getSharedObject()

-- Log når politi skifter distrikt (optional)
RegisterNetEvent('district:log')
AddEventHandler('district:log', function(district)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
local name = 'Ukendt'
local identifier = 'Ukendt'


if xPlayer then
name = xPlayer.getName() or 'Ukendt'
identifier = xPlayer.identifier or identifier
end


print(('[DISTRIKT] [%s] %s (%s) bevægede sig ind i %s'):format(os.date('%Y-%m-%d %H:%M:%S'), name, identifier, tostring(district)))
end)