Config = {}

Config.VehicleMenu = true -- enable this if you wan't a vehicle menu. 
--Above disabled by DeadlyEmu#0001 This function is buggy and i CBA to fix it. there is better resources out there which does this job
Config.VehicleMenuButton = 344 -- change this to the key you want to open the menu with. buttons: https://docs.fivem.net/game-references/controls/
Config.RangeCheck = 25.0 -- this is the change you will be able to control the vehicle.

Config.Impound = true --Enable/Disable impound feature
Config.ImpoundPrice = 200 --Price it will cost player to recover vehicle
Config.ImpoundName = "Impound" --Name to show on blip
Config.RebootRestore = true --send all cars back to the garage on restart of the resource?
Config.ImpoundAutoBan = true --Autoban player if exploit is discovered? (Trying to put car in garage via lua executor) Requires EasyAdmin
Config.AutoBanMessage = "You have been banned for exploiting the the impound system" -- Ban message to show

Config.LockGarage = true --True restrict garage(store in one cnat take it out the other) False can take all cars out of all garages
Config.OneBlipName = true
Config.GarageName = "Garage - " .. GetConvar("server_number", "Mancos01")


--Logging
Config.EnableLogs = true
--Webhooks
Config.GarageWebhook = "https://discordapp.com/api/webhooks/720228722916982824/SrfVlNUtAJ0Zb0ClU_8oCIQ1N0KXgMmZdCWyUtVetdA6C1X52Usrz559K7W9fqilHP2Q"
Config.ImpoundWebhook = "https://discordapp.com/api/webhooks/720228722916982824/SrfVlNUtAJ0Zb0ClU_8oCIQ1N0KXgMmZdCWyUtVetdA6C1X52Usrz559K7W9fqilHP2Q"

--Colours
--use this for help getting decimal colour https://convertingcolors.com/mass-conversion.html
Config.ColourExploit = 16711680
Config.ColourInfo = 65280

Config.BlipImpound = {
    Sprite = 527,
    Color = 60,
    Display = 2,
    Scale = 0.7
}

Config.DrawDistance = 100.0

--Impounds

Config.CarPounds = {
    Pound_LosSantos = {
        PoundPoint = { x = 408.61, y = -1625.47, z = 28.29 },
        SpawnPoint = { x = 405.64, y = -1643.4, z = 27.61, h = 229.54 }
    },
    
    Pound_Sandy = {
        PoundPoint = { x = 1651.38, y = 3804.84, z = 37.65 },
        SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
    },
    
    Pound_Paleto = {
        PoundPoint = { x = -234.82, y = 6198.65, z = 30.94 },
        SpawnPoint = { x = -230.08, y = 6190.24, z = 30.49, h = 140.24 }
    }
}

Config.PoundMarker = {
    r = 0, g = 0, b = 100,     -- Blue Color
    x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

--Garages
Config.Garages = {
    ["Central"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(211.8094329834, -934.98626708984, 24.275938034058)
            },
            ["vehicle"] = {
                ["position"] = vector3(219.86030578613, -932.77551269531, 24.141599655151), 
                ["heading"] = 140.0
            }
        },
        ["camera"] = {  -- camera is not needed just if you want cool effects.
            ["x"] = 224.94281005859, 
            ["y"] = -930.33062744141, 
			["z"] = 26.571212768555, 
			["rotationX"] = -31.401574149728, 
			["rotationY"] = 0.0, 
			["rotationZ"] = -243.40157422423 
        }
    },
	
	["PRIVADO: Motor Club"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(988.23, -140.96, 73.05)
            },
            ["vehicle"] = {
                ["position"] = vector3(985.64, -138.51, 73.03), 
                ["heading"] = 55.49
            }
        },
        ["camera"] = { 
            ["x"] = 988.06, 
            ["y"] = -142.11, 
            ["z"] = 76.38, 
            ["rotationX"] = -12.637795701623, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 195.73228356242 
        }
    },
	
    ["Occupation Av."] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(273.67422485352, -344.15573120117, 44.919834136963)
            },
            ["vehicle"] = {
                ["position"] = vector3(272.50082397461, -337.40579223633, 44.919834136963), 
                ["heading"] = 160.0
            }
        },
        ["camera"] = { 
            ["x"] = 283.28225708008, 
            ["y"] = -333.24017333984, 
            ["z"] = 50.004745483398, 
            ["rotationX"] = -21.637795701623, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 125.73228356242 
        }
    },

    ["Little Seoul"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-701.63, -972.18, 20.39)
            },
            ["vehicle"] = {
                ["position"] = vector3(-696.02, -982.17, 20.39), 
                ["heading"] = 357.84
            }
        },
        ["camera"] = { 
            ["x"] = -701.73, 
            ["y"] = -987.62, 
            ["z"] = 25.39, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -42.110235854983 
        }
    },
    ["Tequi-la-la"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-570.37, 314.65, 84.48)
            },
            ["vehicle"] = {
                ["position"] = vector3(-576.48, 323.91, 84.67), 
                ["heading"] = 355.07
            }
        },
        ["camera"] = { 
            ["x"] = -580.91, 
            ["y"] = 319.8, 
            ["z"] = 87.55, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -42.110235854983 
        }
    },
    ["Sandy Shores"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(2669.38, 3286.85, 55.24)
            },
            ["vehicle"] = {
                ["position"] = vector3(2661.73, 3278.36, 55.24), 
                ["heading"] = 65.97
            }
        },
        ["camera"] = { 
            ["x"] = 2656.03, 
            ["y"] = 3277.23, 
            ["z"] = 60.25, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -90.110235854983 
        }
    },
    ["Paleto Bay"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(105.84, 6611.0, 31.95)
            },
            ["vehicle"] = {
                ["position"] = vector3(111.99, 6614.56, 31.87), 
                ["heading"] = 227.06
            }
        },
        ["camera"] = { 
            ["x"] = 119.39, 
            ["y"] = 6614.61, 
            ["z"] = 36.86, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 90.110235854983 
        }
    }	
}

Config.Labels = {
    ["menu"] = "~INPUT_CONTEXT~ Abrir garaje %s.",
    ["vehicle"] = "~INPUT_CONTEXT~ Guarda '%s' en tu garaje."
}

Config.Trim = function(value)
    if value then
        return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
    else
        return nil
    end
end

Config.AlignMenu = "right" -- this is where the menu is located [left, right, center, top-right, top-left etc.]