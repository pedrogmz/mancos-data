DiscordWebhookSystemInfos = 'https://discord.com/api/webhooks/834477589925593098/pV_IcschIqnOcUE-TctPY9TmvfKr5r8OT9f63m0ChJ69RF2_kh1E7euS-BnhV8GEcT16'
DiscordWebhookKillinglogs = 'https://discord.com/api/webhooks/834477201202216969/ti3OmOX-8mPAmtT5aiu1mF5ZyeMtu0niyrharSvyx_l7h2hCzJ9pmCsqABBcuQ72lWKW'
DiscordWebhookChat = 'https://discord.com/api/webhooks/834489917153345538/bkb444ISeNAZRQxmsf9RTg30MLrRZCv1vFkTi1fP5haJ7aRgB59wzmIJAw_bAU9fWKu4'

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
