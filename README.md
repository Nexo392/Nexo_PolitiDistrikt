🚓 Politi Distrikt Notifikation System
Et FiveM script der viser notifikationer til politi når de bevæger sig mellem forskellige distrikter i Los Santos.
📋 Features

✅ Automatisk distrikt detection baseret på koordinater
✅ Kun synligt for politi der er on duty
✅ 3 hoveddistrikter: Nord, Vest og Øst
✅ Pæne ox_lib notifikationer
✅ Nem konfiguration
✅ Optimeret performance (tjekker kun hvert 2. sekund)
✅ Debug kommando til at tjekke nuværende distrikt

🗺️ Distrikt Opdeling
Nordlige Distrikt

Sandy Shores
Paleto Bay
Grapeseed
Mount Chiliad området
Alt nord for Los Santos by

Vestlige Distrikt

Vespucci (LSPD West)
Del Perro
Los Santos International Airport
Vest for Mission Row

Østlige Distrikt

Mission Row (LSPD Main)
Pillbox Hill
Legion Square
Vinewood
Mirror Park
Øst for centrum

📦 Dependencies

es_extended - ESX Framework
ox_lib - Notifikationer

🔧 Installation

Download scriptet og placer det i din resources mappe
Omdøb mappen til hvad du vil (f.eks. politi_distrikter)
Tilføj følgende til din server.cfg:

cfgensure politi_distrikter

Genstart serveren

⚙️ Konfiguration
Åbn config.lua for at tilpasse scriptet til din server.
Politi Jobs
Tilføj eller fjern politi job navne:
luaConfig.PoliceJobs = {
    'police',
    'sheriff',
    'state'  -- Tilføj flere hvis nødvendigt
}
Distrikt Grænser
Juster koordinaterne for at ændre distrikt grænserne:
luaConfig.Districts = {
    North = {
        minY = 0,  -- Alt over Y = 0 er nord
        name = "Nordlige Distrikt"
    },
    West = {
        maxX = -500,  -- Alt vest for X = -500
        maxY = 0,
        name = "Vestlige Distrikt"
    },
    East = {
        minX = -500,  -- Alt øst for X = -500
        maxY = 0,
        name = "Østlige Distrikt"
    }
}
Check Interval
Hvor ofte scriptet tjekker spillerens position (i millisekunder):
luaConfig.CheckInterval = 2000  -- 2 sekunder (anbefalet)
🎮 Kommandoer
/distrikt
Viser hvilket distrikt du befinder dig i lige nu.

Tilladelse: Kun politi on duty
Brug: Skriv /distrikt i chatten

📸 Screenshots
Tilføj screenshots af notifikationerne her
🐛 Fejlfinding
Notifikationer vises ikke

Tjek at ox_lib er korrekt installeret
Verificer at dit politi job navn matcher Config.PoliceJobs
Sørg for at du er on duty som politi

Forkerte distrikter

Åbn config.lua og juster koordinat grænserne
Brug /distrikt kommandoen til at teste
Tjek koordinater i-game med /coords (hvis du har det)

Script starter ikke

Verificer at alle dependencies er installeret
Tjek server console for fejl
Sørg for at fxmanifest.lua er korrekt

🔄 Opdateringer
Version 1.0.0

Første release
3 distrikter: Nord, Vest, Øst
ESX integration
ox_lib notifikationer

🤝 Support
Hvis du har problemer eller spørgsmål:
Kontakt mig: discord: mr.n2751 

Tjek fejlfinding sektionen ovenfor
Verificer at alle dependencies er opdateret
Opret et issue på GitHub (hvis relevant)

Licens
Dette script er open source og frit at bruge og modificere.
✨ Credits
Udviklet til dansk FiveM community.
