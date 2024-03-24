-- local function isModuleAvailable(name)
-- 	if package.loaded[name] then
-- 		return true
-- 	else
-- 		for _, searcher in ipairs(package.searchers or package.loaders) do
-- 			local loader = searcher(name)
-- 			if type(loader) == 'function' then
-- 				package.preload[name] = loader
-- 				return true
-- 			end
-- 		end
-- 		return false
-- 	end
-- end
--
-- if not isModuleAvailable('neotest') then
-- 	return
-- end
--
-- local function getModule(moduleName)
-- 	if not isModuleAvailable(moduleName) then
-- 		return function(_) return {} end
-- 	end
--
-- 	return require(moduleName)
-- end
--

local neotest = require('neotest')
neotest.setup({
	adapters = {
		require('neotest-java')({ ignore_wrapper = true }),
		require('neotest-jest')({
			jestCommand = "npm test -- ",
			jestConfigFile = "",
			jest_test_discovery = true,
			env = { CI = true },
			cwd = function(_)
				return vim.fn.getcwd()
			end,
		})
	}
})
require("neodev").setup({ library = { plugins = { "neotest" }, types = true } })