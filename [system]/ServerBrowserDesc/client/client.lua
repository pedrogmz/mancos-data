Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(575444332014862346)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('mancos_logo')
		SetDiscordRichPresenceAssetText('🌍MANCOS RP') --Big picture hover text
		
		local pId = GetPlayerServerId(PlayerId())
		local pName = GetPlayerName(PlayerId())

		players = {}
		for i = 0, 255 do
			if NetworkIsPlayerActive( i ) then
				table.insert( players, i )
			end
		end

		SetRichPresence("ID: "..pId.." | "..pName.. " | "..#players .. "/64")

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)
