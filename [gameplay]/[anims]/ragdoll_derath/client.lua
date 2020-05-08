local ragdolll = false
function setRagdoll(flag)
  ragdolll = flag
end
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ragdolll then
      SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    end
  end
end)

ragdool = true
RegisterNetEvent("Ragdoll")
AddEventHandler("Ragdoll", function()
	if ( ragdool ) then
		setRagdoll(true)
		ragdool = false
	else
		setRagdoll(false)
		ragdool = true
	end
end)

RegisterCommand("suelo", function(source, args, raw) --change command here
    TriggerEvent("Ragdoll")
end, false) --False, allow everyone to run it