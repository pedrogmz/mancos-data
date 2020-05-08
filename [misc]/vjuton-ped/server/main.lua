ESX = nil
local Webhook = 'YOUR WEBHOOK HERE'

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('setped', function(source, args)
	id = args[1]
	ped = args[2]
	if ped == 'muscle' then
		TriggerClientEvent('muscle', id)
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'vjuton-ped', content = '``` ```**PEDS**: `ID:` **'..source..'** *set ped to* `ID:` **'..id..'**\n```MODEL: MUSCLE ```'}), { ['Content-Type'] = 'application/json' })			
	elseif ped == 'fat' then
		TriggerClientEvent('fat', id)
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'vjuton-ped', content = '``` ```**PEDS**: `ID:` **'..source..'** *set ped to* `ID:` **'..id..'**\n```MODEL: FAT```'}), { ['Content-Type'] = 'application/json' })			
	elseif ped == 'cop' then
		TriggerClientEvent('cop', id)
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'vjuton-ped', content = '``` ```**PEDS**: `ID:` **'..source..'** *set ped to* `ID:` **'..id..'**\n```MODEL: COP ```'}), { ['Content-Type'] = 'application/json' })		
	elseif ped == 'space' then
		TriggerClientEvent('space', id)
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'vjuton-ped', content = '``` ```**PEDS**: `ID:` **'..source..'** *set ped to* `ID:` **'..id..'**\n```MODEL: SPACE ```'}), { ['Content-Type'] = 'application/json' })		
	elseif ped == 'alien' then
		TriggerClientEvent('alien', id)
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'vjuton-ped', content = '``` ```**PEDS**: `ID:` **'..source..'** *set ped to* `ID:` **'..id..'**\n``` `MODEL: ALIEN```'}), { ['Content-Type'] = 'application/json' })		
	elseif ped == 'swat' then
		TriggerClientEvent('swat', id)
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = 'vjuton-ped', content = '``` ```**PEDS**: `ID:` **'..source..'** *set ped to* `ID:` **'..id..'**\n```MODEL: SWAT ```'}), { ['Content-Type'] = 'application/json' })	
	end
	end)
