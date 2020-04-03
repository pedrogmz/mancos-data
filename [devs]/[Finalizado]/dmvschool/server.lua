ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--[[Info]]--

--require "resources/essentialmode/lib/MySQL"
--MySQL:open("127.0.0.1", "DBNAME", "root", "password")



--[[Register]]--
RegisterServerEvent("dmv:success")
RegisterServerEvent("dmv:LicenseStatus")
RegisterServerEvent("dmv:ttcharge")
RegisterServerEvent("dmv:dtcharge")  
RegisterServerEvent("dmv:selectlicence") 
RegisterServerEvent("dmv:insertlicense") 

--[[DMV TheoryTest]]--
AddEventHandler("dmv:success", function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  MySQL.Async.execute("UPDATE users SET DmvTest='Passed' WHERE identifier = @identifier", {
    ['@identifier'] = xPlayer.identifier
  }, function(rowsChanged)

      if rowsChanged == 0 then
          TriggerClientEvent('esx:showNotification', _source, "~b~Autoescuela Mancos RP ~s~Error al tramitar el examen teórico, contacte con un administrador!")
      else 
        TriggerClientEvent('esx:showNotification', _source, "~b~Autoescuela Mancos RP ~s~Prueba examen práctico teórico correctamente!")
      end
  end)

end)

-- Test teorico
AddEventHandler("dmv:ttcharge", function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if (tonumber(xPlayer.getBank()) >= tonumber(100)) then
    
    xPlayer.removeAccountMoney('bank', 100)

    TriggerClientEvent('esx:showNotification', _source, "~g~FLEECA INFORMA: ~s~ 200$ retirados por [pago test teorico]")

    TriggerClientEvent('dmv:openGui',_source, 0)

  else
    TriggerClientEvent('esx:showNotification', _source, "~r~¡Fondos insuficientes!")
  end

end)

-- Test práctico
AddEventHandler("dmv:dtcharge", function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if (tonumber(xPlayer.getBank()) >= tonumber(200)) then
    
    xPlayer.removeAccountMoney('bank', 200)

    TriggerClientEvent('esx:showNotification', _source, "~g~FLEECA INFORMA: ~s~200$ retirados por [pago test práctico]")

    -- Arnedo 5 | Error no comprovar dinero
    TriggerClientEvent('dmv:moneyok',_source) -- Examen teórico realizado

  else
    TriggerClientEvent('esx:showNotification', _source, "~r~¡Fondos insuficientes!")
  end
end)

-- Comprobar licencia
AddEventHandler("dmv:LicenseStatus", function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT DmvTest FROM users WHERE identifier = @username", {
      ['@username'] = xPlayer.identifier
    }, function (result)

      local LicStatus = result[1].DmvTest

      if (LicStatus == "Passed") then
        TriggerClientEvent('dmv:CheckLicStatus',_source, true) -- Examen teórico realizado
      else 
        TriggerClientEvent('dmv:CheckLicStatus',_source, false) -- Examen teórico no realizado
      end

    end)


end)

-- Comprobar licencia conducción
AddEventHandler("dmv:selectlicence", function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)


  MySQL.Async.fetchAll("SELECT * FROM user_licenses WHERE OWNER = @identifier", {
    ['@identifier'] = xPlayer.identifier
  }, function (result)

    if (result[1] ~= nil ) then -- Tiene licencia
      TriggerClientEvent('dmv:startptest',_source, true) -- Examen teórico no realizado
    else -- No tiene licencia
      TriggerClientEvent('dmv:startptest',_source, false) -- Examen teórico no realizado
    end

  end)

end)

-- Insert nueva licencia
AddEventHandler("dmv:insertlicense", function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  MySQL.Async.execute("INSERT INTO user_licenses (id, TYPE, OWNER) VALUES (NULL, 'drive', @identifier)", {
    ['@identifier'] = xPlayer.identifier
  }, function (rowsChanged)

    if rowsChanged == 0 then
      TriggerClientEvent('esx:showNotification', _source, "~b~Autoescuela Mancos RP ~s~Error el Permiso de circulación, contacte con un administrador!")
    else 
      TriggerClientEvent('esx:showNotification', _source, "~b~Autoescuela Mancos RP ~s~Permiso de circulación tramitado correctamente!")
    end
   
  end)

end)