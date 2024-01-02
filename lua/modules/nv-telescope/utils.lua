local conf = require("telescope.config").values
local telescope = require("telescope")
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local utils = require "telescope.utils"

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

function M.symbols_sorter(symbols)
    if vim.tbl_isempty(symbols) then
        return symbols
    end

    local current_buf = vim.api.nvim_get_current_buf()

    -- sort adequately for workspace symbols
    local filename_to_bufnr = {}
    for _, symbol in ipairs(symbols) do
        if filename_to_bufnr[symbol.filename] == nil then
            filename_to_bufnr[symbol.filename] = vim.uri_to_bufnr(vim.uri_from_fname(symbol.filename))
        end
        symbol.bufnr = filename_to_bufnr[symbol.filename]
    end

    table.sort(symbols, function(a, b)
        if a.bufnr == b.bufnr then
            return a.lnum < b.lnum
        end
        if a.bufnr == current_buf then
            return true
        end
        if b.bufnr == current_buf then
            return false
        end
        return a.bufnr < b.bufnr
    end)

    return symbols
end

function M.search_symbols(opts)
    local query = opts.query or ""
    local lsp_name = vim.lsp.get_active_clients()[1].name

    if query == "" and lsp_name == "jdtls" then
        query = "**"
    end

    local params = { query = query }
    vim.lsp.buf_request(opts.bufnr, "workspace/symbol", params, function(err, server_result, _, _)
        if err then
            vim.api.nvim_err_writeln("Error when finding workspace symbols: " .. err.message)
            return
        end

        local locations = vim.lsp.util.symbols_to_items(server_result or {}, opts.bufnr) or {}
        locations = utils.filter_symbols(locations, opts, symbols_sorter)
        if locations == nil then
            return
        end

        opts.ignore_filename = vim.F.if_nil(opts.ignore_filename, false)

        pickers
            .new(opts, {
                prompt_title = "LSP Workspace Symbols",
                finder = finders.new_table {
                    results = locations,
                    entry_maker = opts.entry_maker or make_entry.gen_from_lsp_symbols(opts),
                },
                previewer = conf.qflist_previewer(opts),
                sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts)
            })
            :find()
    end)
end

return M
