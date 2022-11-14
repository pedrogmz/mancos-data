fx_version 'cerulean'
game 'gta5'

description 'ESX NPC Drug Sales Zones'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua',
	
}

dependencies {
	'es_extended',
}



