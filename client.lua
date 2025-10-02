ESX = exports['es_extended']:getSharedObject()

local PlayerData = {}
local isPoliceOnDuty = false
local isPolice = false
local currentDistrict = nil
local lastNotify = 0

-- Helper funktion
local function safeHasKey(tbl, key)
    return tbl and tbl[key] ~= nil
end

-- Opdater spillerdata når ressourcen starter
CreateThread(function()
    while not ESX.IsPlayerLoaded() do
        Wait(100)
    end
    
    PlayerData = ESX.GetPlayerData()
    isPolice = PlayerData.job and PlayerData.job.name == 'police'
    
    if Config.UseOnDuty and safeHasKey(PlayerData.job, 'onDuty') then
        isPoliceOnDuty = isPolice and PlayerData.job.onDuty
    else
        isPoliceOnDuty = isPolice
    end
end)

-- Lyt efter job opdateringer
RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
    isPolice = job.name == 'police'
    
    if Config.UseOnDuty and safeHasKey(job, 'onDuty') then
        isPoliceOnDuty = isPolice and job.onDuty
    else
        isPoliceOnDuty = isPolice
    end
end)

-- Lyt efter onDuty status ændringer (hvis din server bruger dette event)
RegisterNetEvent('esx:setJobDuty', function(onDuty)
    if PlayerData.job and PlayerData.job.name == 'police' then
        PlayerData.job.onDuty = onDuty
        isPoliceOnDuty = onDuty
    end
end)

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

-- Vis notifikation når man skifter distrikt (inkl. debounce)
function ShowDistrictNotification(district)
    local now = GetGameTimer()
    if now - lastNotify < (Config.DistrictNotifyCooldown or 3000) then
        return
    end
    lastNotify = now

    local districtName = Config.Districts[district] and Config.Districts[district].name or district

    lib.notify({
        title = 'Distrikt',
        description = 'Du bevæger dig ind i ' .. districtName,
        type = 'inform',
        position = 'top-right',  -- HØJRE HJØRNE (eller 'top-left' for venstre)
        duration = 5000
    })

    -- Du kan fjerne denne linje hvis du ikke vil have server event overhovedet
    -- TriggerServerEvent('district:log', district)
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