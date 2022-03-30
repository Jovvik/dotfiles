-- Update on file save
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

vim.cmd "packadd packer.nvim"
local packer = require "packer"

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

packer.startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        "catppuccin/nvim",
        config = function()
            vim.cmd "colorscheme catppuccin"
        end,
    }

    use "shaunsingh/nord.nvim" -- fallback theme

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp" -- LSP completions
    use "hrsh7th/cmp-nvim-lsp-signature-help" -- LSP function signature highlight
    use { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" } -- Tabnine
    use {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            require("crates").setup()
        end,
    } -- Crates info and version completions
    use "hrsh7th/cmp-nvim-lua"
    use "onsails/lspkind-nvim"

    use "rrethy/vim-illuminate" -- Highlight the symbol under the cursor.

    -- snippets
    -- TODO: add latex autoexpanding snippets
    use {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip").config.set_config {
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
            }
        end,
    } -- snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
    use {
        "SirVer/ultisnips",
        config = function()
            vim.cmd "let g:UltiSnipsExpandTrigger = '<tab>'"
            vim.cmd "let g:UltiSnipsJumpForwardTrigger = '<tab>'"
            vim.cmd "let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'"
            vim.cmd "let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/ultisnips']"
        end,
    }

    -- LSP
    use "neovim/nvim-lspconfig" -- LSP itself
    use "williamboman/nvim-lsp-installer" -- LSP installer

    use "nvim-telescope/telescope.nvim"

    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local configs = require "nvim-treesitter.configs"

            configs.setup {
                ensure_installed = "maintained",
                ignore_install = { "latex" }, -- Treesiter conflicts with latex conceal.
                autopairs = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            }
        end,
    }

    use {
        "simrat39/rust-tools.nvim",
        config = function()
            require("rust-tools").setup {}
            require("rust-tools.inlay_hints").set_inlay_hints()
        end,
    }

    use {
        "brymer-meneses/grammar-guard.nvim",
        requires = {
            "neovim/nvim-lspconfig",
            "williamboman/nvim-lsp-installer",
        },
        config = function()
            require("grammar-guard").init()
        end,
    }

    use {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require "null-ls"
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local completion = null_ls.builtins.completion
            local code_actions = null_ls.builtins.code_actions
            null_ls.setup {
                sources = {
                    code_actions.gitsigns,
                    formatting.stylua.with {
                        extra_args = { "--indent-type", "Spaces", "--call-parentheses", "None" },
                    },
                    -- completion.spell,
                    formatting.black,
                    diagnostics.flake8,
                    diagnostics.mypy,
                    formatting.reorder_python_imports,
                },
                on_attach = function(client)
                    if client.resolved_capabilities.document_formatting then
                        vim.cmd [[
                        augroup LspFormatting
                            autocmd! * <buffer>
                            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                        augroup END
                        ]]
                    end
                end,
            }
        end,
    }

    use {
        "steelsojka/pears.nvim",
        config = function()
            require("pears").setup()
        end,
    }

    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        config = function()
            require("nvim-tree").setup {
                view = {
                    width = "30%",
                },
            }
        end,
    }

    -- use {
    --     "lervag/vimtex",
    --     config = function()
    --         vim.cmd "let g:vimtex_view_method = 'zathura'"
    --     end,
    -- }

    use {
        "KeitaNakamura/tex-conceal.vim",
        ft = "tex",
        config = function()
            vim.cmd "set conceallevel=2"
            vim.cmd 'let g:tex_conceal="abdgm"'
        end,
    }

    use "github/copilot.vim"

    use "wakatime/vim-wakatime"

    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    }

    use "tpope/vim-fugitive"

    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    }

    use "lukas-reineke/indent-blankline.nvim"

    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup {
                theme = "catppuccin",
            }
        end,
    }
end)
