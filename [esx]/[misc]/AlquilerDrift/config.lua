-- Script Made By Aljunier | Made For ESX Framework --

Config = {}

Config.MarkerType = 36 --https://docs.fivem.net/game-references/markers/

--Rental Cars
Config.RentalCars = {
    ['Capri'] = {
        ['Rental Info'] = {
            ['model'] = 'fordcapri',
            ['information'] = 'Ford Capri 150$',
            ['price'] = 150
        }
    },
    ['NissanSilviaS15'] = {
        ['Rental Info'] = {
            ['model'] = 's15mak',
            ['information'] = 'Nissan Silvia S15 150$',
            ['price'] = 150
        }
    },
    ['Nissan350z'] = {
        ['Rental Info'] = {
            ['model'] = '350zrb',
            ['information'] = 'Nissan 350Z Rocket Bunny 150$',
            ['price'] = 150
        }
    },
	['Toyotasupra'] = {
		['Rental Info'] = {
            ['model'] = 'variszupra',
            ['information'] = 'Toyota Supra A80 150$',
            ['price'] = 150
        }
    },
	['ToyotaTrueno'] = {
        ['Rental Info'] = {
            ['model'] = 'ae86',
            ['information'] = 'Toyota Trueno AE86 150$',
            ['price'] = 150
        }
    },
    ['Nissan_GTR_R35_Liberty_Walk_Silhouette'] = {
        ['Rental Info'] = {
            ['model'] = 'gtrsilhouette',
            ['information'] = 'Nissan GTR R35 Linerty Walk Silhouette 150$',
            ['price'] = 150
        }
    },
    ['BMWM3'] = {
        ['Rental Info'] = {
            ['model'] = 'e36prb',
            ['information'] = 'BMW M3 E36 Pandem 150$',
            ['price'] = 150
        }
    },
    ['BMWM3B'] = {
        ['Rental Info'] = {
            ['model'] = 'rm3e36',
            ['information'] = 'BMW M3 E36 Rocket Bunny V2 150$',
            ['price'] = 150
        }
    },
    ['FORDMUSTANG'] = {
        ['Rental Info'] = {
            ['model'] = 'keenblock',
            ['information'] = 'Ford Mustang Hoonigan 150$',
            ['price'] = 150
        }
    },
    ['HONDANSX'] = {
        ['Rental Info'] = {
            ['model'] = 'nsexrb',
            ['information'] = 'Honda NSX 150$',
            ['price'] = 150
        }
    },
    ['LAMBORGHINI'] = {
        ['Rental Info'] = {
            ['model'] = 'lwhuracan',
            ['information'] = 'Lamborghini Huracan Liberty Walk 150$',
            ['price'] = 150
        }
    },
    ['MAZDARX7'] = {
        ['Rental Info'] = {
            ['model'] = 'fc3s',
            ['information'] = 'Mazda RX7 FC3S 150$',
            ['price'] = 150
        }
    },
    ['MAZDARX7B'] = {
        ['Rental Info'] = {
            ['model'] = 'rx7veilside',
            ['information'] = 'Mazda RX7 Veilside Fortune 150$',
            ['price'] = 150
        }
    },
    ['MERCEDESBENZ'] = {
        ['Rental Info'] = {
            ['model'] = 'lwc63',
            ['information'] = 'Mercedes Benz C63 Liberty Walk 150$',
            ['price'] = 150
        }
    },
    ['MITSUBISHI'] = {
        ['Rental Info'] = {
            ['model'] = 'evo9',
            ['information'] = 'Mitsubishi Lancer Evolution IX 150$',
            ['price'] = 150
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
    ['Nissan_GTR_R35_Liberty_Walk_Silhouette'] = {
        ['Rental Info'] = {
            ['model'] = 'gtrsilhouette',
            ['information'] = 'Nissan GTR R35 Linerty Walk Silhouette 150$',
            ['price'] = 150
        }
    },
}


----NOTE: There is not a need to lower your 'Z' value by 1 anymore, the script handles that by itself!----
Config.RentalLocations = {

    -- Car Rentals
    ['Hipodromo'] = {
        ['Marker'] = {
            ['Type'] = 'Car Rental',
            ['x'] = 1174.44,
            ['y'] = 305.87,
            ['z'] = 82.50,
        },
        ['VehicleReturn'] = {
            ['x'] = 1157.94,
            ['y'] = 281.75,
            ['z'] = 82.50,
        },
        ['VehicleSpawn'] = {
            ['x'] = 1176.86,
            ['y'] = 301.39,
            ['z'] = 81.42,
            ['Heading'] = 157.87
        }
    },

    ['Norte'] = {
        ['Marker'] = {
            ['Type'] = 'Car Rental',
            ['x'] = 1228.46,
            ['y'] = 7393.21,
            ['z'] = 81.04,
        },
        ['VehicleReturn'] = {
            ['x'] = 1219.17,
            ['y'] = 7371.42,
            ['z'] = 80.7,
        },
        ['VehicleSpawn'] = {
            ['x'] = 1233.87,
            ['y'] = 7390.69,
            ['z'] = 79.7,
            ['Heading'] = 130.38
        }
    },

    -- Commercial Rentals
    
}