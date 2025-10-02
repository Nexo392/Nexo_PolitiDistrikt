ESX = exports['es_extended']:getSharedObject()
elseif Config.UseOnDuty and safeHasKey(PlayerData.job, 'onDuty') then
isPoliceOnDuty = isPolice and PlayerData.job.onDuty
else
isPoliceOnDuty = isPolice
end
else
isPoliceOnDuty = false
end
end


-- Få nuværende distrikt baseret på koordinater
function GetCurrentDistrict()
local ped = PlayerPedId()
if not DoesEntityExist(ped) then return nil end


local coords = GetEntityCoords(ped)
local x, y = coords.x, coords.y


-- Tjek Nord distrikt først
if y >= Config.Districts.North.minY then
return 'North'
end


-- Tjek Vest distrikt
if x < Config.Districts.West.maxX and y < Config.Districts.West.maxY then
return 'West'
end


-- Ellers er det Øst distrikt
if x >= Config.Districts.East.minX and y < Config.Districts.East.maxY then
return 'East'
end


return nil
end


-- Vis notifikation når man skifter distrikt (inkl. debounce + server log)
function ShowDistrictNotification(district)
local now = GetGameTimer()
if now - lastNotify < (Config.DistrictNotifyCooldown or 3000) then
return
end
lastNotify = now


local districtName = Config.Districts[district] and Config.Districts[district].name or district


lib.notify({
title = 'Distrikt',
description = 'Du bevæger dig ind i det ' .. districtName,
type = 'inform',
position = 'top',
duration = 5000
})


-- Trigger server logging (server.lua håndterer output)
TriggerServerEvent('district:log', district)
end


-- Hovedloop der tjekker distrikt
CreateThread(function()
while true do
local waitTime = Config.CheckInterval or 2000
if not isPoliceOnDuty then
waitTime = Config.IdleCheckInterval or 5000
end
Wait(waitTime)


if isPoliceOnDuty then
local district = GetCurrentDistrict()


if district and district ~= currentDistrict then
currentDistrict = district
ShowDistrictNotification(district)
end
else
-- Hvis ikke på vagt, nulstil currentDistrict så spilleren får notifikation
-- når de senere går på vagt og bevæger sig i zonen
currentDistrict = nil
end
end
end)


-- Kommando til at tjekke nuværende distrikt (debug)
RegisterCommand('distrikt', function()
if isPoliceOnDuty then
local district = GetCurrentDistrict()
if district then
local districtName = Config.Districts[district].name
lib.notify({
title = 'Nuværende Distrikt',
description = districtName,
type = 'success'
})
else
lib.notify({
title = 'Nuværende Distrikt',
description = 'Ukendt/Gemt område',
type = 'warn'
})
end
else
lib.notify({
title = 'Adgang Nægtet',
description = 'Du skal være politi og på arbejde',
type = 'error'
})
end
end)