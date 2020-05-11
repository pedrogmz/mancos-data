DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/654148843390238720/QS8HC8tZ3inIx7-048CZqginDr3HpuFyjC4wumIDAr4mZeHHBFBprP2UwStx9qNL1AWL'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/708316796717105234/b9UEn-OFIBl7av0J31tu2_ErHiAOmlu_tEC8fJxHp2gAUPzo_i1vKHy-n5U95T_vAvDn'
DiscordWebhookChat = 'https://discordapp.com/api/webhooks/654147636655423488/vQQ4Cwom90wd1AWEP_-sCVF-8EJND4i5Gf0NNeldupWZQYWJcuCoFuMpwLW-t2e_HxkI'

SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'
UserAvatar = 'https://i.imgur.com/KIcqSYs.png'
SystemName = 'SYSTEM'

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
