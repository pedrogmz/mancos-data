TriggerEvent('es:addCommand', 'hud', function(source, args)
	if not args then 
		TriggerClientEvent('chatMessage', source, "[SYNTAX]", {255, 0, 0}, "/hud [on/off]") 
	else
	local a = tostring(args[1])
		if a == "off" then
			TriggerClientEvent('mancos_hud:toggle', source, false)
		elseif a == "on" then
			TriggerClientEvent('mancos_hud:toggle', source, true)
		else
			TriggerClientEvent('chatMessage', source, "[SYNTAX]", {255, 0, 0}, "/hud [on/off]") 
		end
	end
end, {help = "Oculta o muestra el HUD"})


TriggerEvent('es:addCommand', 'update_mugshot', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"UPDATED"}
	})
	
	TriggerClientEvent('mancos_hud:updateMugshot', source, true)

end, {help = "Report a player or an issue"})
