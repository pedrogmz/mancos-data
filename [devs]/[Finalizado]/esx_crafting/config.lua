Crafting = {}
-- You can configure locations here
Crafting.Locations = {
    [1] = {x = 1108.65, y = -3150.43, z = -37.52},
--  [2] = {x = 1108.52, y = -3150.53, z = -37.52},
--  [3] = {x = -1154.895, y = -2022.624, z = 13.176},
}
--[[
    You can add or remove if you want, be sure to use the right format like this:
    ["item_name"] = {
        label = "Item Label",
        needs = {
            ["item_to_use_name"] = {label = "Item Use Label", count = 1}, 
            ["item_to_use_name2"] = {label = "Item Use Label", count = 2},
        },
        threshold = 0,
    },

    #! 
        Threshold level is a level that gets saved (in the database) by crafting, if you craft succefully you gain points, if you fail you lose points.
        The threshold level can be changed to your liking.
    #!

    Also if you don't have the items below make sure to remove it and create your own version.
]]--
Crafting.Items = {
    ["WEAPON_CROWBAR"] = {
        label = "Palanca",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 1},
            ["plastic"] = {label = "Plastic", count = 2},
        },
        threshold = 0,
    },
    ["WEAPON_PISTOL"] = {
        label = "Pistola",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 2},
            ["plastic"] = {label = "Plastic", count = 4},
            ["bread"] = {label = "Pan", count = 1},
        },
        threshold = 15,
    },
    ["superlockpick"] = {
        label = "Advanced lockpick",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 4},
            ["plastic"] = {label = "Plastic", count = 6},
            ["stone"] = {label = "Stone", count = 1},
            ["wood"] = {label = "Wood", count = 1},
        },
        threshold = 20,
    },
    ["handcuffs"] = {
        label = "Handcuffs",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 5},
            ["simplelockpick"] = {label = "Small lockpick", count = 1},
        },
        threshold = 18,
    },
    ["drill"] = {
        label = "Drill",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 10},
            ["plastic"] = {label = "Plastic", count = 18},
            ["rubber"] = {label = "Rubber", count = 6},
            ["stone"] = {label = "Stone", count = 8},
        },
        threshold = 250,
    },
    ["fixkit"] = {
        label = "Repair kit",
        needs = {
            ["metalscrap"] = {label = "Metalscrap", count = 5},
            ["plastic"] = {label = "Plastic", count = 12},
            ["rubber"] = {label = "Rubber", count = 5},
            ["wood"] = {label = "Wood", count = 8},
        },
        threshold = 350,
    },
}