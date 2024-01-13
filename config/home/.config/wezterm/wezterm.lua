local colors = require('colors')

require('events')(colors.default)
return require('config')(colors.scheme, require('wezterm').font('UDEV Gothic NFLG'), require('mappings'))
