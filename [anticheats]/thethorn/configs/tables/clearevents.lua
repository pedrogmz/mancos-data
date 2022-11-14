
-- DO NOT ADD GETSHAREDOBJECT HERE!

-- capvalue = nil (No capvalue check for this event)

LynxClearEvents = {
    [1] = {event = "esx_fueldelivery:pay", capvalue = 1000},
    [2] = {event = "esx_carthief:pay", capvalue = 1000},
    [3] = {event = "esx_godirtyjob:pay", capvalue = 1000},
    [4] = {event = "esx_pizza:pay", capvalue = 1000},
    [5] = {event = "esx_ranger:pay", capvalue = 1000},
    [6] = {event = "esx_garbagejob:pay", capvalue = 1000},
    [7] = {event = "esx_gopostaljob:pay", capvalue = 1000},
    [8] = {event = "esx_slotmachine:sv:2", capvalue = 1000},
    [9] = {event = "esx_dmvschool:pay", capvalue = 1000},
    [10] = {event = "esx_tankerjob:pay", capvalue = 1000},
    [11] = {event = "AdminMenu:giveBank", capvalue = 1000},
    [12] = {event = "AdminMenu:giveCash", capvalue = 1000},
    [13] = {event = "LegacyFuel:PayFuel", capvalue = 1000},
    [14] = {event = "esx_society:billing", capvalue = 100000},
    [15] = {event = "js:jailuser", capvalue = -1},
    [16] = {event = "ljail:jailplayer", capvalue = nil},
    [17] = {event = "esx_jailer:sendToJail", capvalue = nil},
    [18] = {event = "esx_jail:sendToJail", capvalue = -1},
    [19] = {event = "esx-qalle-jail:jailPlayer", capvalue = -1}

}

LynxClearEventsBlacklistedStrings = {
    "Mod Menu",
    "You got fucked",
    "ATG",
    "on top",
    "anticheat",
    "cheat"
}