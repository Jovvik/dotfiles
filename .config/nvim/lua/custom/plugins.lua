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
    auto_reload_compiled = true,
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
        -- commit = "f079dda3dc23450d69b4bad11bfbd9af2c77f6f3",
        as = "catppuccin",
        config = function()
            require("catppuccin").setup {
                transparent_background = true,
                -- styles = {
                --     comments = "italic",
                --     conditionals = "italic",
                --     loops = "NONE",
                --     functions = "NONE",
                --     keywords = "NONE",
                --     strings = "NONE",
                --     variables = "NONE",
                --     numbers = "NONE",
                --     booleans = "NONE",
                --     properties = "NONE",
                --     types = "NONE",
                --     operators = "NONE",
                -- },
            }
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
    use { "zbirenbaum/copilot-cmp", after = { "copilot.vim", "nvim-cmp" } }
    -- use { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" } -- Tabnine
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
    use {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip").config.set_config {
                history = false,
                -- updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = false,
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
    } -- for latex (autoexpandng)

    -- LSP
    use "neovim/nvim-lspconfig" -- LSP itself
    use "williamboman/nvim-lsp-installer" -- LSP installer

    use "nvim-telescope/telescope.nvim"

    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local configs = require "nvim-treesitter.configs"

            configs.setup {
                ensure_installed = "all",
                ignore_install = { "latex" }, -- Conceal with treesitter should be defined in some obscure way that I'm not entirely aware of.
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
            require("rust-tools").setup()
            require("rust-tools").inlay_hints.enable()
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
                    diagnostics.mypy,
                    formatting.reorder_python_imports,
                },
                -- on_attach = function(client)
                --     if client.resolved_capabilities.document_formatting then
                --         vim.cmd [[
                --         augroup LspFormatting
                --             autocmd! * <buffer>
                --             autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                --         augroup END
                --         ]]
                --     end
                -- end,
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

    use {
        "lervag/vimtex",
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.tex_conceal = "abdmg"
            vim.opt.conceallevel = 2
        end,
    }

    -- use {
    --     "Jovvik/tex-conceal.vim",
    --     ft = "tex",
    --     config = function()
    --         vim.cmd "set conceallevel=2"
    --         vim.cmd 'let g:tex_conceal="abdgm"'
    --     end,
    -- }

    use {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
        end,
    }

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

    use {
        "kdheepak/tabline.nvim",
        config = function()
            require("tabline").setup()
        end,
    }

    use {
        "goolord/alpha-nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    }

    use {
        "akinsho/toggleterm.nvim",
        tag = "v2.*",
        config = function()
            require("toggleterm").setup {
                open_mapping = [[<C-t>]],
                direction = "float",
                shell = "fish",
            }
        end,
    }

    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            local saga = require "lspsaga"

            saga.init_lsp_saga {
                code_action_lightbulb = {
                    enabled = true,
                    virtual_text = false,
                },
            }
        end,
    }

    use {
        "lewis6991/impatient.nvim",
        config = function()
            require "impatient"
        end,
    }

    use {
        "roxma/nvim-yarp",
    }

    use {
        "gelguy/wilder.nvim",
        config = function()
            local wilder = require "wilder"
            wilder.setup { modes = { ":", "/", "?" } }
            wilder.set_option("pipeline", {
                wilder.branch(
                    wilder.python_file_finder_pipeline {
                        -- to use ripgrep : {'rg', '--files'}
                        -- to use fd      : {'fd', '-tf'}
                        file_command = { "find", ".", "-type", "f", "-printf", "%P\n" },
                        -- to use fd      : {'fd', '-td'}
                        dir_command = { "find", ".", "-type", "d", "-printf", "%P\n" },
                        -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
                        -- found at https://github.com/nixprime/cpsm
                        filters = { "fuzzy_filter", "difflib_sorter" },
                    },
                    wilder.cmdline_pipeline(),
                    wilder.python_search_pipeline()
                ),
            })
            wilder.set_option(
                "renderer",
                wilder.popupmenu_renderer {
                    highlighter = wilder.basic_highlighter(),
                    left = { ' ', wilder.popupmenu_devicons() },
                }
            )
        end,
        run = ":UpdateRemotePlugins",
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }

    use {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
            }
        end
    }
end)
