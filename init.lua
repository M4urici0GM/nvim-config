vim.g.mapleader = " "

local utils = require('utils')

require('config.settings')
require('config.keymap')
require('config.lazy')

utils.setupEnvironment()