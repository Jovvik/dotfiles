local lsp_installer = require "nvim-lsp-installer"
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("custom.lsp.handlers").on_attach,
        capabilities = require("custom.lsp.handlers").capabilities,
    }

    -- if server.name == "jsonls" then
    --     local jsonls_opts = require("custom.lsp.settings.jsonls")
    --     opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    -- end

    if server.name == "sumneko_lua" then
        local sumneko_opts = require "custom.lsp.settings.sumneko_lua"
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server.name == "texlab" then
        local texlab_opts = require "custom.lsp.settings.texlab"
        opts = vim.tbl_deep_extend("force", texlab_opts, opts)
    end

    if server.name == "rust-analyzer" then
        local rust_analyzer_opts = require "custom.lsp.settings.rust_analyzer"
        opts = vim.tbl_deep_extend("force", rust_analyzer_opts, opts)
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
