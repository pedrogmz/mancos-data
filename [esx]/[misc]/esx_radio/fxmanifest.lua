-- Manifest Version
fx_version 'cerulean'
game 'gta5'

client_script "client/main.lua"
server_script "server/main.lua"

-- NUI Default Page
ui_page('html/index.html')

files({
    'html/index.html',
    -- Begin Sound Files Here...
    'html/sounds/copradio.ogg',
    'html/sounds/copradiooff.ogg'
})



