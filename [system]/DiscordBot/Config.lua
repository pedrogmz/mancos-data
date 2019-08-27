DiscordWebhookKeybindingLogs = 'https://discordapp.com/api/webhooks/579146522755858442/f98V2xRkcXmwZlmFvErQ7K_Hav5pvf0XQFi89Ptm3QzcFJ7gjT1j4SzZZ_g1ka5SVtOR'
DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/573325098551869449/akTZnQsTlXVX0g-7SBG4i8ejXByuaH2oKCou_49pIoCKTjWSnECJMgJ7CAeGRHKWcvdb'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/573394574559674369/JBY3Rx4vGMYktstlaEj32YFNeKfdZDZEDfoZgoE8F8gTYn4FD3W9qBdRxmY6UL5s093f'
DiscordWebhookChat = 'https://discordapp.com/api/webhooks/573393495654662147/mGrUvfPQzK9Bd4dShAnB0BYaof7MPPdHFmkSqA17P7jT7dlP5vqxAjfCM5JRYuZL3oVE'

SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'
UserAvatar = 'https://i.imgur.com/KIcqSYs.png'
SystemName = 'SYSTEM'

--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command

-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
	{'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
}

-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
	'/revive',
	'/AnyCommand2',
}

-- These Commands will use their own webhook
OwnWebhookCommands = {
	{'/AnotherCommand', 'WEBHOOK_LINK_HERE'},
	{'/AnotherCommand2', 'WEBHOOK_LINK_HERE'},
}

-- These Commands will be sent as TTS messages
TTSCommands = {
	'/Whatever',
	'/Whatever2',
}
