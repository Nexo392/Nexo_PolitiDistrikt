-- client.lua
ESX = exports['es_extended']:getSharedObject()

local currentDistrict = nil
local PlayerData = {}
local isPoliceOnDuty = false

-- Register ESX
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    CheckPoliceStatus()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    CheckPoliceStatus()
end)

-- Tjek om spilleren er politi og on duty
function CheckPoliceStatus()
    if PlayerData.job then
        local isPolice = false
        for _, jobName in ipairs(Config.PoliceJobs) do
            if PlayerData.job.name == jobName then
                isPolice = true
                break
            end
        end
        isPoliceOnDuty = isPolice
    else
        isPoliceOnDuty = false
    end
end

-- Få nuværende distrikt baseret på koordinater
function GetCurrentDistrict()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    -- Tjek Nord distrikt først
    if coords.y >= Config.Districts.North.minY then
        return 'North'
    end
    
    -- Tjek Vest distrikt
    if coords.x < Config.Districts.West.maxX and coords.y < Config.Districts.West.maxY then
        return 'West'
    end
    
    -- Ellers er det Øst distrikt
    if coords.x >= Config.Districts.East.minX and coords.y < Config.Districts.East.maxY then
        return 'East'
    end
    
    return nil
end

-- Vis notifikation når man skifter distrikt
function ShowDistrictNotification(district)
    local districtName = Config.Districts[district].name
    
    lib.notify({
        title = 'Distrikt',
        description = 'Du bevæger dig ind i det ' .. districtName,
        type = 'inform',
        position = 'top',
        duration = 5000
    })
end

-- Hovedloop der tjekker distrikt
CreateThread(function()
    while true do
        Wait(Config.CheckInterval)
        
        if isPoliceOnDuty then
            local district = GetCurrentDistrict()
            
            if district and district ~= currentDistrict then
                currentDistrict = district
                ShowDistrictNotification(district)
            end
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
        end
    else
        lib.notify({
            title = 'Adgang Nægtet',
            description = 'Du skal være politi og på arbejde',
            type = 'error'
        })
    end
end)
