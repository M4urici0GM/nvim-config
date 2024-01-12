local M = {}

function M.get_cwd()
    local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        local lsp_client = vim.lsp.get_active_clients()[1]
        if lsp_client ~= nil then
            cwd = lsp_client.config.root_dir
        end
    end

    return cwd
end

return M