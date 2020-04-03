--------------------------------------------------
--                 _   _ _     _                --
--       Made by  | \ | | |   (_)               --
--       ___  __ _|  \| | |__  _  ___           --
--      / __|/ _` | . ` | '_ \| |/ _ \          --
--      \__ \ (_| | |\  | | | | |  __/          --
--      |___/\__,_\_| \_/_| |_| |\___|          --
--                           _/ |               --
--                          |__/  2019          --
--                                              --
--    https://forum.fivem.net/u/stianhje/       --
--------------------------------------------------

-------------------------------------------------------------------------------
-- ESX
-------------------------------------------------------------------------------
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------------------------------------------------------------------------
-- Get Money / Remove money
-------------------------------------------------------------------------------
RegisterServerEvent('sawu_hookers:pay')
AddEventHandler('sawu_hookers:pay', function(boolean, Hooker)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local xPlayers  = ESX.GetPlayers()

    if (boolean == true) then
        if xPlayer.getMoney() >= Config.BlowjobPrice then
            xPlayer.removeMoney(Config.BlowjobPrice)
            TriggerClientEvent('sawu_hookers:startBlowjob', _source)
            TriggerClientEvent('sawu_hookers:notification', _source, 'Has pagado: ~g~'..Config.BlowjobPrice..'~w~$')

            -- Bajamos stress
            TriggerClientEvent('esx_status:remove', source, 'stress', 30000)
            TriggerClientEvent('esx_basicneeds:removeStress', source)

            -- this adds money to society_nightclub
            if Config.SocietyNightclub then
                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
                    account.addMoney(Config.BlowjobPrice)
                end)
            end
        else
            TriggerClientEvent('sawu_hookers:notification', _source, '~r~¡No tienes suficiente dinero!')
            TriggerClientEvent('sawu_hookers:noMoney', _source)
        end  
    else
        if xPlayer.getMoney() >= Config.SexPrice then
            xPlayer.removeMoney(Config.SexPrice)
            TriggerClientEvent('sawu_hookers:startSex', _source)
            TriggerClientEvent('sawu_hookers:notification', _source, 'Has pagado: ~g~'..Config.SexPrice..'~w~$')

            -- Bajamos stress
            TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
            TriggerClientEvent('esx_basicneeds:removeStress', source)

            -- this adds money to society_nightclub
            if Config.SocietyNightclub then
                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
                    account.addMoney(Config.SexPrice)
                end)
            end
        else
            TriggerClientEvent('sawu_hookers:notification', _source, '~r~¡No tienes suficiente dinero!')
            TriggerClientEvent('sawu_hookers:noMoney', _source)
        end 
    end
end)




