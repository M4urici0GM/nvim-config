

vim.g.mapleader = " "

local utils = require("utils")
utils.setupLazy()
utils.setupClipboard()
utils.setupEnvironment()

require("plugins")
require("modules")

