local M = {}

function M.setupLsp()
    local floatOptions = {
        focusable = true,
        style = "minimal",
        border = "rounded"

    }
    local lspConfig = {
        float = floatOptions,
        diagnostics = {
            virtual_text = { spacing = 4 },
            underline = true,
            update_on_insert = false,
            severity_sort = true,
            float = floatOptions
        },
    }

    -- Diagnostic signs
    local diagnostic_signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }
    for _, sign in ipairs(diagnostic_signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end


    vim.diagnostic.config(lspConfig.diagnostics)
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, lspConfig.float)
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, lspConfig.float)
    vim.opt.completeopt = { 'menu', 'menuone' }
end

return M
