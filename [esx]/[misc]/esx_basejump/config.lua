Config = {}
Config.Locale = 'es' -- Localisation

Config.CurrencyPrefix = '$' -- Ex. $ for USD - will be in front of the price
Config.CurrencySuffix = '' -- Ex. DKK for Danish Kroner - will be behind the price, remember a space in the start.

Config.Zones = {
    
    Basejumping = {
        Enable = true, -- Enable/Disable Basejumping
        Name = _U('basejumping_blip'), -- Blip Name
        DrawDistance = 10.0, -- DrawDistance lower is better! (controles how fare away you should be before the marker on the ground is drawn)
        MarkerType = 25, -- Marker Type https://forum.fivem.net/t/drawmarker-pictures-for-dev/99136
        ZoneSize = {x = 2.0, y = 2.0, z = 2.0}, -- Zone Size (How large the ring is)
        MarkerColor = {r = 255, g = 168, b = 0}, -- Marker Color RGB
        BlipSprite = 94, -- Map Marker Icon http://gtaxscripting.blogspot.com/2016/05/gta-v-blips-id-and-image.html
        BlipScale = 0.8, -- Size of Map Marker
        BlipColor = 81, -- Map Marker Color
        EnableBlips = true, -- Enable/Disable Map Markers
        Free = false, -- Controle if bike rental is free
        MenuTitle = _U('menu_title_basejumping'), -- Menu Title
        ItemType = 'weapon', -- Item Type (Is in use dont change or it will break)
        MenuActions = {
            MenuTrigger = 'basejumping_menu', -- Menu Trigger
            MenuMessage = _U('press_basejumping_menu'), -- Menu Help Text
        },
        Items = { -- Item, label, and price used for the menu
            {item = 'GADGET_PARACHUTE', label = 'Paracaídas', price = 500},
        },
        Pos = { -- Zone positions
            {x = 451.45, y = 5587.85, z = 780.23},
            -- {x = -1136.27, y = 4659.88, z = 243.02},
            -- {x = 1665.17, y = -28.0, z = 195.97},
            -- {x = -119.97, y = -977.51, z = 303.41},
            -- {x = -543.86, y = -2226.02, z = 121.44},
        },
        TelePos = { -- Basejump TP locations (used to launch the player for basejumping)
            {x = 446.74, y = 5587.83, z = 1500, h = 85.5},
            -- {x = -1146.22, y = 4660.92, z = 243.89, h = 88.5},
            -- {x = 1659.71, y = -29.39, z = 196.93, h = 103.5},
            -- {x = -118.81, y = -979.88, z = 304.24, h = 207.5},
            -- {x = -539.62, y = -2228.61, z = 122.36, h = 237.5},
        }
    }
}
