--[[ ===================================================== ]] --
--[[              MH Stashes Script by MaDHouSe            ]] --
--[[ ===================================================== ]] --
fx_version 'cerulean'
games {'gta5'}

author 'MaDHouSe79'
description 'mh-stashes'
version '1.0'

shared_scripts {'@qb-core/shared/locale.lua', 'locales/en.lua', 'config.lua'}
client_scripts {'client/main.lua'}
server_scripts {'@oxmysql/lib/MySQL.lua', 'server/sv_config.lua', 'server/main.lua', 'server/update.lua'}

dependencies {'oxmysql', 'qb-core', 'qb-inventory'}

lua54 'yes'