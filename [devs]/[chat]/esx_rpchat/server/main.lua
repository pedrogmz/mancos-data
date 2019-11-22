local server = GetConvar("server_number", "1")

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

function playerRank(source) 
	if IsPlayerAceAllowed(source, "tag.jefe") then
		return '^9[JEFE] ^7'
	elseif IsPlayerAceAllowed(source, "tag.superadmin") then
		return '^3[SUPERADMIN] ^7'
	elseif IsPlayerAceAllowed(source, "tag.admin") then
		return '^1[ADMIN] ^7'
	elseif IsPlayerAceAllowed(source, "tag.mod") then
		return '^4[MOD] ^7'
	elseif IsPlayerAceAllowed(source, "tag.support") then
		return '^5[SOPORTE] ^7'
	else 
		return ''
	end
end

AddEventHandler('chatMessage', function(source, name, message)
	args = stringsplit(message, " ")
	if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
    else 
		local playerName = GetPlayerName(source)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.1vw; margin: 0.1vw; border-radius: 3px;"> '..playerRank(source)..' {0}: {1}</div>',
			args = { playerName, message }
		})
	end
end)

--[[RegisterCommand('atwt', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(11)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.1vw; border-radius: 3px;"><i class="fab fa-twitter"></i> @Anonymous: {1}</div>',
        args = { fal, msg }
    })
	TriggerEvent('DiscordBot:ToDiscord', 'chat', playerName .. ' [ID: ' .. source .. '] Server: '..server, '**ANONTWITTER: **' .. msg, 'steam', true, source)
end, false)
]]

RegisterCommand('twt', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.1vw; border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}: {1}</div>',
        args = { fal, msg }
    })
	TriggerEvent('DiscordBot:ToDiscord', 'chat', playerName .. ' [ID: ' .. source .. '] Server: '..server, '**TWITTER: **' .. msg, 'steam', true, source)
end, false)


RegisterCommand('ooc', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local name = getIdentity(source)
	fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.1vw; border-radius: 3px;"><i class="fas fa-globe"></i> '..playerRank(source)..' {0}: {1}</div>',
        args = { playerName, msg }
    })
	TriggerEvent('DiscordBot:ToDiscord', 'chat', playerName .. ' [ID: ' .. source .. '] Server: '..server, '**OOC: **' .. msg, 'steam', true, source)
end, false)

RegisterCommand('ad', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.1vw; border-radius: 3px;"><i class="fas fa-ad"></i> Advertisement: {1}<br></div>',
        args = { fal, msg }
    })
	TriggerEvent('DiscordBot:ToDiscord', 'chat', playerName .. ' [ID: ' .. source .. '] Server: '..server, '**PUBLICIDAD: **' .. msg, 'steam', true, source)
end, false)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
