fx_version 'adamant'
game 'gta5'
author 'sajjadmrx'
version '1.0.0'
description 'postman job'
lua54 'yes'


shared_script '@es_extended/imports.lua'

client_scripts({
    'config.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'shared/**/*.lua',
    'client/shared/*.lua',
    'client/*.lua'
})

server_script({
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'shared/**/*.lua',
    'server/db/*.lua',
    'server/*.lua'
})

dependency 'es_extended'
