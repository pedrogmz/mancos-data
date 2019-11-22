
function playerRank(source) 
	if IsPlayerAceAllowed(source, "tag.jefe") then
		return '~g~[JEFE] ~w~'
	elseif IsPlayerAceAllowed(source, "tag.superadmin") then
		return '~y~[SUPERADMIN] ~w~'
	elseif IsPlayerAceAllowed(source, "tag.admin") then
		return '~r~[ADMIN] ~w~'
	elseif IsPlayerAceAllowed(source, "tag.mod") then
		return '~o~[MOD] ~w~'
	elseif IsPlayerAceAllowed(source, "tag.support") then
		return '~b~[SOPORTE] ~w~'
	else 
		return ''
	end
end

prefixes = {}
hidePrefix = {}
hideAll = {}

local function get_index (tab, val)
	local counter = 1
    for index, value in ipairs(tab) do
        if value == val then
            return counter
        end
		counter = counter + 1
    end

    return nil
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

RegisterCommand("tag", function(source, args, rawCommand)
	local name = GetPlayerName(source)
	if (has_value(hidePrefix, name)) then
	
		---
		local src = source
		local roleGive = playerRank(src)
		table.insert(prefixes, {GetPlayerName(src), roleGive})
		TriggerClientEvent("GetStaffID:StaffStr:Return", -1, prefixes, false)
		---
	
		-- Turn on their tag-prefix and remove them
		table.remove(hidePrefix, get_index(hidePrefix, name))
		TriggerClientEvent("ID:Tag-Toggle", -1, hidePrefix, false)
		TriggerClientEvent('chatMessage', source, "^9[^1Tags^9] ^3Your tag is now ^2active")
	else
		-- Turn off their tag-prefix and add them
		table.insert(hidePrefix, name)
		TriggerClientEvent("ID:Tag-Toggle", -1, hidePrefix, false)
		TriggerClientEvent('chatMessage', source, "^9[^1Tags^9] ^3Your tag is no longer ^1active")
	end
end)
RegisterCommand("tags", function(source, args, rawCommand)
	local name = GetPlayerName(source)
	if (has_value(hideAll, name)) then
		-- Have them hide all tags
		table.remove(hideAll, get_index(hideAll, name))
		TriggerClientEvent("ID:Tags-Toggle", source, false, false)
		TriggerClientEvent('chatMessage', source, "^9[^1Tags^9] ^3Tags of players are now ^2active")
	else
		-- Have them not hide all tags
		table.insert(hideAll, name)
		TriggerClientEvent("ID:Tags-Toggle", source, true, false)
		TriggerClientEvent('chatMessage', source, "^9[^1Tags^9] ^3Tags of players are no longer ^1active")
	end
end)

AddEventHandler('playerConnecting', function(source)
	local src = source

	local roleGive = playerRank(src)
	table.insert(prefixes, {GetPlayerName(src), roleGive})
	TriggerClientEvent("GetStaffID:StaffStr:Return", -1, prefixes, false)
end)
