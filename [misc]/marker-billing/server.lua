ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Arnedo5 marker-billing
RegisterServerEvent('marker_billing:checkJob')
AddEventHandler('marker_billing:checkJob', function(marker)

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    
    if Pointers[marker] then

        local marker = Pointers[marker]

        if (xPlayer.job.name == marker.job) then -- Acceso al ordenador
            TriggerClientEvent('marker_billing:showPc', source, marker.job)	
        else -- Error al entrar al ordenador
            TriggerClientEvent('chatMessage', source, '[ERROR] ', {255, 0, 0},  _U('error_job'))

            -- Enviamos entorno a los policias en caso de que sea el PC de la policia
            if (marker.job == 'police') then
                for i=1, #xPlayers, 1 do
                    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    if xPlayer.job.name == 'police' then
                        TriggerClientEvent('chatMessage', xPlayers[i], 'SEGURIDAD', {0, 0, 255}, _U('error_violation')..' Policia')
                    end
                end
            end
        end
    end
end)

RegisterServerEvent('marker_billing:checkTotal')
AddEventHandler('marker_billing:checkTotal', function(id, job)

    local xPlayer = ESX.GetPlayerFromId(id)
    local _source = source

    if xPlayer then
        MySQL.Async.fetchAll("SELECT COALESCE(SUM(amount),0) AS 'TOTAL' FROM billing LEFT JOIN tablet_npenal ON billing.id = tablet_npenal.TABNIDPENAL WHERE billing.identifier = @identifier AND billing.target = @target AND tablet_npenal.TABNPAID = 0", {
            ['@identifier'] = xPlayer.identifier,
            ['@target'] = 'society_'..job,
        }, function (result)
            
            -- Obtenemos el total a pagar
            local totalBilling = result[1].TOTAL;
            TriggerClientEvent("showData",  _source, "Total: "..totalBilling.." $")
        end)
    else
        TriggerClientEvent("showData", _source, _U('error_search'))
    end
end)

RegisterServerEvent('marker_billing:billing')
AddEventHandler('marker_billing:billing', function(id, date)

    local xPlayer = ESX.GetPlayerFromId(id)
    --local xPlayers = ESX.GetPlayers()
    local _source = source

    if xPlayer then
        MySQL.Async.fetchAll("SELECT COALESCE(SUM(amount),0) AS 'TOTAL' FROM billing LEFT JOIN tablet_npenal ON billing.id = tablet_npenal.TABNIDPENAL WHERE billing.identifier = @identifier AND tablet_npenal.TABNPAID = 0", {
            ['@identifier'] = xPlayer.identifier
        }, function (result)
            
            -- Obtenemos el total a pagar
            local totalBilling = result[1].TOTAL;

            if (tonumber(totalBilling) > 0) then

                if (tonumber(xPlayer.getBank()) > tonumber(totalBilling)) or 1 == 1 then

                    -- En caso de tener dinero en el  banco, retiramos el dinero
                    xPlayer.removeAccountMoney('bank', tonumber(totalBilling))

                    removeMoney(_source, xPlayer, date)
					
					TriggerClientEvent('esx:showNotification', id, "~r~ MAZE BANK INFORMA: ~s~"..totalBilling.._U('success_'..xPlayer.job.name).."")
					-- Arnedo5 | El dinero se guarda en la sociedad
					TriggerClientEvent('billingSocietyAdd', id, 'police', totalBilling) -- Le sacamos dinero y se lo ponemos a la sociedad

                    --[[for i=1, #xPlayers, 1 do
                        local xPlayerr = ESX.GetPlayerFromId(xPlayers[i])
                        if xPlayerr.identifier == xPlayer.identifier then
                            
                        end
                    end]]

                else -- En caso de no tener dinero mostramos un mensaje de alerta por el terminal 
                    TriggerClientEvent("showData", _source,  _U('error_money'))
                end 
            else -- En caso de no tener facturas / multas / delitos pendientes mostramos un mensaje de error
                TriggerClientEvent("showData", _source, _U('error_total'))
            end
        end)
    else
        TriggerClientEvent("showData", _source, _U('error_search'))
    end
end)

-- Una vez pagada la factura ponemos todos los pendientes a PAGADAS
function removeMoney(_source, xPlayer, date) 
    local xPlay = xPlayer
    local _source = _source

    MySQL.Async.execute("UPDATE tablet_npenal SET tablet_npenal.TABNPAID = 1, tablet_npenal.TABNLASTUPDATE = @date WHERE tablet_npenal.TABNIDPENAL IN (SELECT id FROM billing WHERE billing.identifier = @identifier) AND tablet_npenal.TABNPAID = 0", {
        ['@identifier'] = xPlayer.identifier,
        ['@date'] = date,
	}, function(rowsChanged)
        if rowsChanged == 0 then
			TriggerClientEvent("showData", _source, "Error al tramitar la facturacion")
        else 
            TriggerClientEvent("showData", _source,  _U('msg_'..ESX.GetPlayerFromId(_source).job.name))
        end
    end)
end

RegisterServerEvent('marker_billing:billingMechanic')
AddEventHandler('marker_billing:billingMechanic', function(id, description, note, total, date)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(id)
    local sourceXPlayer = ESX.GetPlayerFromId(_source)

    if (xPlayer) then
       
        if (tonumber(xPlayer.getBank()) >= tonumber(total)) or 1 == 1 then

            --En caso de tener dinero en el  banco, retiramos el dinero
            --xPlayer.removeAccountMoney('bank', tonumber(total))
         
            MySQL.Async.execute("INSERT INTO billing (id, identifier, sender, target_type, target, label, amount, term) VALUES (NULL, @identifier, @sender, 'society', 'society_mechanic', @description, @amount, 0)", {
				['@identifier'] = xPlayer.identifier,
				['@sender'] = sourceXPlayer.identifier,
				['@description'] = description,
				['@amount'] = total
			}, function (rowsChanged)
	
                if (rowsChanged >= 1) then

                    -- Obtenemos la id del registro insertado
					MySQL.Async.fetchAll("SELECT id FROM billing WHERE identifier = @identifier AND sender = @sender AND amount = @amount AND target = 'society_mechanic' ORDER BY id DESC LIMIT 1", {
						['@identifier'] = xPlayer.identifier,
						['@sender'] = sourceXPlayer.identifier,
						['@amount'] = total
					}, function(result)
						
						MySQL.Async.execute("INSERT INTO tablet_npenal (id, TABNIDPENAL, TABNIDENTIFIER, TABNDESCRIPTION, TABNLASTUPDATE, TABNPAID) VALUES (NULL, @id, @sender, @note, @date, 1)", {
							['@id'] = result[1].id,
                            ['@sender'] = sourceXPlayer.identifier,
                            ['@note'] = note,
							['@date'] = date
						}, function (rowsChanged)
							TriggerClientEvent('esx:showNotification', id, "~r~ MAZE BANK INFORMA: ~s~"..total.."$ retirados por pago de factura en Mecánico ["..description.."]")
							
							xPlayer.removeAccountMoney('bank', tonumber(total))
							-- Arnedo5 | El dinero se guarda en la sociedad
							TriggerClientEvent('billingSocietyAdd', id, 'mechanic', tonumber(total)) -- Le sacamos dinero y se lo ponemos a la sociedad

                            -- Restart values form
                            TriggerClientEvent("marker_billing:exit", _source)
						end)
					end)
                end
			end)
        else -- En caso de no tener dinero mostramos un mensaje de alerta por el terminal 
            TriggerClientEvent("showData", _source,  _U('error_money'))
        end
    else
        TriggerClientEvent("showData", _source, _U('error_search'))
    end
end)
