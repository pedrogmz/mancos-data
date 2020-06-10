Config = {}

Config.VehicleMenu = true -- enable this if you wan't a vehicle menu.
Config.VehicleMenuButton = 344 -- change this to the key you want to open the menu with. buttons: https://docs.fivem.net/game-references/controls/
Config.RangeCheck = 100.0 -- this is the change you will be able to control the vehicle.

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
        -- ["camera"] = {  -- camera is not needed just if you want cool effects.
            -- ["x"] = 224.94281005859, 
            -- ["y"] = -930.33062744141, 
            -- ["z"] = 26.571212768555, 
            -- ["rotationX"] = -31.401574149728, 
            -- ["rotationY"] = 0.0, 
            -- ["rotationZ"] = -243.40157422423 
        -- }
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
        -- ["camera"] = { 
            -- ["x"] = 988.06, 
            -- ["y"] = -142.11, 
            -- ["z"] = 76.38, 
            -- ["rotationX"] = -12.637795701623, 
            -- ["rotationY"] = 0.0, 
            -- ["rotationZ"] = 195.73228356242 
        -- }
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
        -- ["camera"] = { 
            -- ["x"] = 283.28225708008, 
            -- ["y"] = -333.24017333984, 
            -- ["z"] = 50.004745483398, 
            -- ["rotationX"] = -21.637795701623, 
            -- ["rotationY"] = 0.0, 
            -- ["rotationZ"] = 125.73228356242 
        -- }
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
        -- ["camera"] = { 
            -- ["x"] = -701.73, 
            -- ["y"] = -987.62, 
            -- ["z"] = 25.39, 
            -- ["rotationX"] = -39.496062710881, 
            -- ["rotationY"] = 0.0, 
            -- ["rotationZ"] = -42.110235854983 
        -- }
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
        -- ["camera"] = { 
            -- ["x"] = -580.91, 
            -- ["y"] = 319.8, 
            -- ["z"] = 87.55, 
            -- ["rotationX"] = -39.496062710881, 
            -- ["rotationY"] = 0.0, 
            -- ["rotationZ"] = -42.110235854983 
        -- }
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
        -- ["camera"] = { 
            -- ["x"] = 2656.03, 
            -- ["y"] = 3277.23, 
            -- ["z"] = 60.25, 
            -- ["rotationX"] = -39.496062710881, 
            -- ["rotationY"] = 0.0, 
            -- ["rotationZ"] = -90.110235854983 
        -- }
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
        -- ["camera"] = { 
            -- ["x"] = 119.39, 
            -- ["y"] = 6614.61, 
            -- ["z"] = 36.86, 
            -- ["rotationX"] = -39.496062710881, 
            -- ["rotationY"] = 0.0, 
            -- ["rotationZ"] = 90.110235854983 
        -- }
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