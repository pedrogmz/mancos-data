ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Activar todos los jobs para esx_service
for k, job in pairs(Config.AvailableJobs) do	
        TriggerEvent('esx_service:activateService', job, 10)
end


-- Arnedo 5 | Nueva función generica
RegisterServerEvent('duty:service')
AddEventHandler('duty:service', function(job, grade)
        local newJob = ""
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

         -- Esta fuera de servicio (Tenemos que entrar en servicio)
        if string.match(job, "off") then
                newJob = job:gsub("off", "")
                
                xPlayer.setJob(job:gsub("off", ""), grade)
   
                updateUser(xPlayer, newJob, grade)
        else -- Esta en servicio (Tenemos que salir de servicio)

                newJob = 'off'..job

                xPlayer.setJob('off'..job, grade)

                updateUser(xPlayer, newJob, grade)
        end
end)

-- Update user in BBDD || Para que muestre bien el contenido de la tablet
function updateUser(player, job, grade)

        local xPlayer = player

        MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.identifier,
                ['@job'] = job,
                ['@job_grade'] = grade
        }, function (rowsChanged)
                if rowsChanged == 0 then
                        --print("Error")
                else
                        --print("Ok")
                end
        end)
end

