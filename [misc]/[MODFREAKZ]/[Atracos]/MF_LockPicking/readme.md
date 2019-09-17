https://www.ModFreakz.net
https://discord.gg/ukgQa5K

Requirements
-- ESX

Installation
- 1. Place MF_LockPicking folder into resources folder.
- 2. Start MF_LockPicking in server.cfg
- 3. Join https://discord.gg/ukgQa5K to be activated to use script (user activations happen twice a day in bulk - so it may take upto 24 hours to get this processed)

Usage

Start:
TriggerEvent('MF_LockPicking:StartMinigame')

Finish:
AddEventHandler('MF_LockPicking:MinigameComplete', function(didWin)
end)