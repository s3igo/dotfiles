---@type { default: table, scheme: table }
local colors = require('colors')
---@type { fish: string, chissoku: string }
local deps = require('deps')

require('events')(colors.default, deps.chissoku)
return require('config')(colors.scheme, require('wezterm').font('UDEV Gothic NFLG'), require('mappings'), deps.fish)
