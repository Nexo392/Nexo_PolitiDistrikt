- config.lua
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

-- Tjek interval i millisekunder
Config.CheckInterval = 2000

-- Politi job navn (tilpas til din server)
Config.PoliceJobs = {
    'police',
    'sheriff'
}