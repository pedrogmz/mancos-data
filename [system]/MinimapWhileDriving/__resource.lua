resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Minimap while driving'

client_script {
	'client/MinimapValues.lua',
	'client/RadarWhileDriving.lua',
}

exports {
	'GetMinimapAnchor'
}
