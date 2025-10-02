Config = {}


-- Distrikt grænser (Y-koordinater for nord/syd og X-koordinater for vest/øst)
Config.Districts = {
-- Nord distrikt: Alt nord for Y = 0 (Sandy Shores, Paleto Bay, Grapeseed)
North = {
minY = 0,
name = "Nordlige Distrikt"
},


-- Vest distrikt: X mindre end -500 (Vespucci, Del Perro, Airport)
West = {
maxX = -500,
maxY = 0, -- Kun syd for nord-grænsen
name = "Vestlige Distrikt"
},


-- Øst distrikt: X større end -500 (Mission Row, Pillbox, Vinewood)
East = {
minX = -500,
maxY = 0, -- Kun syd for nord-grænsen
name = "Østlige Distrikt"
}
}


-- Tjek interval i millisekunder når spiller er aktiv på vagt
Config.CheckInterval = 2000


-- Tjek interval når spiller ikke er på vagt (lavere prioritet)
Config.IdleCheckInterval = 5000


-- Debounce / cooldown for notifikationer så de ikke spammer (ms)
Config.DistrictNotifyCooldown = 3000


-- Hvis din server har et on-duty flag i job-objektet, sæt true
-- (fx job.onduty eller job.onDuty afhængigt af din ESX-opsætning)
Config.UseOnDuty = false


-- Politi job navn (tilpas til din server)
Config.PoliceJobs = {
'police'
}