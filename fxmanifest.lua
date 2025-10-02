-- fxmanifest.lua

fx_version 'cerulean'
game 'gta5'

author 'Your Name'
description 'Politi Distrikt Notifikation System'
version '1.0.0'

shared_script '@ox_lib/init.lua'

shared_script 'config.lua'

client_script 'client.lua'

server_script 'server.lua'

dependencies {
    'es_extended',
    'ox_lib'
}