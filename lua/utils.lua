local M = {}

function M.folderExists(folder)
    return vim.loop.fs_stat(folder)
end

function M.formatPath(folder)
    return vim.fn.stdpath("data") .. folder
end

function M.checkCommand(cmd)
    return vim.fn.executable(cmd) == 1
end

function M.evaluateCommand(command, errorMsg)
    if not M.checkCommand(command) then
        error(errorMsg)
    end
end

local lazy_repository = "https://github.com/folke/lazy.nvim.git"
local java_debug_repository = "https://github.com/microsoft/java-debug.git"
local vscode_java_test_repository = 'https://github.com/microsoft/vscode-java-test.git'
local plugin_file =
'/mourice.nvim/java.debug/tmp/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'

function M.setupEnvironment()
    M.evaluateCommand("mvn", "maven is not installed. trying to install with brew")
    M.evaluateCommand("npm", "npm is not installed, please install node and try again.")

    local java_debug_path = M.formatPath("/mourice.nvim/java.debug")
    if not M.folderExists(java_debug_path) then
        local temp_folder = java_debug_path .. '/tmp'
        local maven_pom = string.format("-f %s/pom.xml", temp_folder)
        local plugin_file_path = M.formatPath(plugin_file)
        local plugin_folder = M.formatPath('/mourice.nvim/java.debug/')

        print("cloning java-debug...")
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            java_debug_repository,
            temp_folder
        })

        print("successfully cloned java-debug, installing it with maven")
        print("maven pom: " .. maven_pom)

        print(vim.fn.system(string.format("mvn install %s", maven_pom)))

        print("successfully installed java-debug")
        print("cleaning up")


        print(string.format('moving %s to %s', plugin_file_path, plugin_folder))
        print(vim.fn.system(string.format('mv %s %s', plugin_file_path, plugin_folder)))
        print(vim.fn.system({ "rm", "-rf", temp_folder }))
        print("successfully installed java debug")
    end

    local vscode_java_test_folder = M.formatPath("/mourice.nvim/java.test")
    if not M.folderExists(vscode_java_test_folder) then
        local temp_folder = vscode_java_test_folder .. '/tmp'
        print("cloning java-test...")
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            vscode_java_test_repository,
            temp_folder
        })

        print("successfully cloned vscode-java-test, installing it..")
        vim.fn.system(string.format('npm --prefix %s install', temp_folder))

        print("successfully installed packages, building..")
        vim.fn.system(string.format('npm --prefix %s run build-plugin', temp_folder))

        print("successfully built vscode-java-test, installing it.")
        vim.fn.system(string.format('mv %s/server/*.jar %s/', temp_folder, vscode_java_test_folder))

        print("cleaning up..")
        vim.fn.system(string.format('rm -rf %s', temp_folder))
    end
end

function M.setupLazy()
    local lazypath = M.formatPath("/lazy/lazy.nvim")
    if not M.folderExists(lazypath) then
        vim.fn.system({ "git", "clone", "--filter=blob:none", lazy_repository, "--branch=stable" })
    end

    vim.opt.rtp:prepend(lazypath)
end

function M.getOs()
    -- Determine OS
    local os_config = "linux"
    if vim.fn.has "mac" == 1 then
        os_config = "mac"
    end
    return os_config
end

function M.setupClipboard()
    if vim.fn.has "mac" == 1 then
        vim.cmd('set clipboard=unnamed "OSX')
    else
        vim.cmd('set clipboard=unnamedplus "Linux')
    end
end

return M
