-- Activar todos los jobs para esx_service
for k, job in pairs(Config.AvailableJobs) do
    TriggerEvent('esx_service:activateService', job, 20)
end
