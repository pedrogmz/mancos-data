-- Script Made By Aljunier | Made For ESX Framework --

Config = {}

Config.MarkerType = 25 --https://docs.fivem.net/game-references/markers/

--Rental Cars
Config.RentalCars = {
    ['Asea'] = {
        ['Rental Info'] = {
            ['model'] = 'asea',
            ['information'] = 'Asea 200$',
            ['price'] = 200
        }
    },
    ['Rocoto'] = {
        ['Rental Info'] = {
            ['model'] = 'rocoto',
            ['information'] = 'Rocoto 250$',
            ['price'] = 250
        }
    },
    ['Felon'] = {
        ['Rental Info'] = {
            ['model'] = 'felon',
            ['information'] = 'Felon 300$',
            ['price'] = 300
        }
    },

--[[    Example

    ['Name'] = {                                        -- Name (Doesn't Matter What Name)
        ['Rental Info'] = {                             -- Keep As 'Rental Info'
            ['model'] = 'modelname',                    -- Here goes the vehicle model name you want to spawn
            ['information'] = 'Vehicle Name price$',    -- Here is what will be displayed in the menu. Ex: 'Panto $150'
            ['price'] = price                           -- Here goes the price you want the vehicle to go for. Also mark this price down in ['information'] so that the price appears in the menu
        }
    },

]]

}

Config.CommercialRentals = {
    ['Taco'] = {
        ['Rental Info'] = {
            ['model'] = 'taco',
            ['information'] = 'Taco Truck 275$',
            ['price'] = 450
        }
    },
    ['Pounder'] = {
        ['Rental Info'] = {
            ['model'] = 'pounder',
            ['information'] = 'Pounder 600$',
            ['price'] = 600
        }
    },
    ['Phantom'] = {
        ['Rental Info'] = {
            ['model'] = 'phantom',
            ['information'] = 'Phantom 900$',
            ['price'] = 900
        }
    },
    ['Packer'] = {
        ['Rental Info'] = {
            ['model'] = 'packer',
            ['information'] = 'Packer $900',
            ['price'] = 900
        }
    },
    ['Hauler'] = {
        ['Rental Info'] = {
            ['model'] = 'hauler',
            ['information'] = 'Hauler 900$',
            ['price'] = 900
        }
    },
    ['Mule'] = {
        ['Rental Info'] = {
            ['model'] = 'mule',
            ['information'] = 'Mule $350',
            ['price'] = 350
        }
    },
    ['Mule3'] = {
        ['Rental Info'] = {
            ['model'] = 'mule3',
            ['information'] = 'Mule With Pushbar $450',
            ['price'] = 450
        }
    },
    ['Benson'] = {
        ['Rental Info'] = {
            ['model'] = 'benson',
            ['information'] = 'Benson $450',
            ['price'] = 450
        }
    },
    ['Bus'] = {
        ['Rental Info'] = {
            ['model'] = 'bus',
            ['information'] = 'Bus $1050',
            ['price'] = 1050
        }
    },
    ['Coach Bus'] = {
        ['Rental Info'] = {
            ['model'] = 'coach',
            ['information'] = 'Coach Bus $1050',
            ['price'] = 1050
        }
    },
    ['Tour Bus'] = {
        ['Rental Info'] = {
            ['model'] = 'tourbus',
            ['information'] = 'Tour Bus $550',
            ['price'] = 550
        }
    },
    ['Brickade'] = {
        ['Rental Info'] = {
            ['model'] = 'brickade',
            ['information'] = 'Brickade $1450 Including Fees',
            ['price'] = 1450
        }
    },

--[[    Example

    ['Name'] = {                                        -- Name (Doesn't Matter What Name)
        ['Rental Info'] = {                             -- Keep As 'Rental Info'
            ['model'] = 'modelname',                    -- Here goes the vehicle model name you want to spawn
            ['information'] = 'Vehicle Name price$',    -- Here is what will be displayed in the menu. Ex: 'Panto $150'
            ['price'] = price                           -- Here goes the price you want the vehicle to go for. Also mark this price down in ['information'] so that the price appears in the menu
        }
    },

]]
}


----NOTE: There is not a need to lower your 'Z' value by 1 anymore, the script handles that by itself!----
Config.RentalLocations = {

    -- Car Rentals
    ['Prison'] = {
        ['Marker'] = {
            ['Type'] = 'Car Rental',
            ['x'] = 1854.69,
            ['y'] = 2582.28,
            ['z'] = 45.67,
        },
        ['VehicleReturn'] = {
            ['x'] = 1854.77,
            ['y'] = 2593.02,
            ['z'] = 45.67,
        },
        ['VehicleSpawn'] = {
            ['x'] = 1858.42,
            ['y'] = 2599.64,
            ['z'] = 45.67,
            ['Heading'] = 270.74
        }
    },
    ['Paleto Bay'] = {
        ['Marker'] = {
            ['Type'] = 'Car Rental',
            ['x'] = -144.02,
            ['y'] = 6305.72,
            ['z'] = 31.56,
        },
        ['VehicleReturn'] = {
            ['x'] = -157.86,
            ['y'] = 6302.68,
            ['z'] = 31.45,
        },
        ['VehicleSpawn'] = {
            ['x'] = -147.95,
            ['y'] = 6311.67,
            ['z'] = 31.41,
            ['Heading'] = 314.58
        }
    },
    ['LS Airport'] = {
        ['Marker'] = {
            ['Type'] = 'Car Rental',
            ['x'] = -966.43,
            ['y'] = -2609.96,
            ['z'] = 13.98,
        },
        ['VehicleReturn'] = {
            ['x'] = -960.9,
            ['y'] = -2589.72,
            ['z'] = 13.83,
        },
        ['VehicleSpawn'] = {
            ['x'] = -967.26,
            ['y'] = -2603.47,
            ['z'] = 13.83,
            ['Heading'] = 60.51
        }
    },
    ['LS North'] = {
        ['Marker'] = {
            ['Type'] = 'Car Rental',
            ['x'] = 598.66,
            ['y'] = 90.73,
            ['z'] = 92.83,
        },
        ['VehicleReturn'] = {
            ['x'] = 611.21,
            ['y'] = 98.63,
            ['z'] = 92.69,
        },
        ['VehicleSpawn'] = {
            ['x'] = 595.87,
            ['y'] = 84.35,
            ['z'] = 92.83,
            ['Heading'] = 254.04
        }
    },

    -- Commercial Rentals
    ['LS East Commercial'] = {
        ['Marker'] = {
            ['Type'] = 'Commercial Rental',
            ['x'] = 915.12,
            ['y'] = -1515.3,
            ['z'] = 31.13,
        },
        ['VehicleReturn'] = {
            ['x'] = 923.17,
            ['y'] = -1537.34,
            ['z'] = 30.88,
        },
        ['VehicleSpawn'] = {
            ['x'] = 908.75,
            ['y'] = -1552.3,
            ['z'] = 30.71,
            ['Heading'] = 126.98
        }
    },

--[[    Example

    ['Whatever Name Your Want'] = {                 -- Name (Doesn't Matter What Name)
        ['Marker'] = {                              -- Keep as 'Marker'
            ['Type'] = 'Rental Type',               -- Enter The Type Of Rental. Available Types: Car Rental    OR    Commercial Rental
            ['x'] = x,                              -- X Coordinate for where you want people to go to to rent vehicles
            ['y'] = y,                              -- Y Coordinate for where you want people to go to to rent vehicles
            ['z'] = z,                              -- Z Coordinate for where you want people to go to to rent vehicles
        },
        ['VehicleReturn'] = {                       -- Keep as 'VehicleReturn'
            ['x'] = x,                              -- X Coordinate for where you want the vehicle return to be at
            ['y'] = y,                              -- Y Coordinate for where you want the vehicle return to be at
            ['z'] = z,                              -- Z Coordinate for where you want the vehicle return to be at
        },
        ['VehicleSpawn'] = {                        -- Keep as 'VehicleSpawn'
            ['x'] = x,                              -- X Coordinate for where you want the vehicle spawn to be at (Make sure it's a place where cars wont spawn naturally)
            ['y'] = y,                              -- Y Coordinate for where you want the vehicle spawn to be at (Make sure it's a place where cars wont spawn naturally)
            ['z'] = z,                              -- Z Coordinate for where you want the vehicle spawn to be at (Make sure it's a place where cars wont spawn naturally)
            ['Heading'] = heading                   -- Heading value that you want the vehicle to face upon spawning
        }
    },

]]
}