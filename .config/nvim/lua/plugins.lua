local packer = require("packer")

local use = packer.use
packer.reset()

packer.startup(function()
    -- core plugins
    use({
        "wbthomason/packer.nvim",
        opt = false,
    })
    use({ "neovim/nvim-lspconfig" }) -- Configurations for Nvim LSP
    use({ "nvim-treesitter/nvim-treesitter" })
    use({ "williamboman/mason.nvim" })
    use({ "jay-babu/mason-null-ls.nvim" })
    use({ "jay-babu/mason-nvim-dap.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

    -- tools and UIs
    use({ "nvim-telescope/telescope.nvim" }) -- fuzzy find and UI
    use({ "nvim-telescope/telescope-ui-select.nvim" })
    use({ "nvim-lua/plenary.nvim" })
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" })
    use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "lewis6991/gitsigns.nvim" })
    use({ "Mofiqul/vscode.nvim" }) -- vscode like theme

    -- utils
    use({ "windwp/nvim-autopairs" })
    use({ "akinsho/toggleterm.nvim" })
    use({ "numToStr/Comment.nvim" })
    use({ "kylechui/nvim-surround", tag = "*" })
    use({ "crusj/bookmarks.nvim", branch = "main", requires = "kyazdani42/nvim-web-devicons" })
    use({ "chentoast/marks.nvim" })
    use({ "declancm/maximize.nvim" })
    use({ "famiu/bufdelete.nvim" })
    use({ "p00f/clangd_extensions.nvim" })

    -- keymaps
    use({ "folke/which-key.nvim" })
    use({ "mrjones2014/legendary.nvim" })

    -- snippets
    use({ "L3MON4D3/LuaSnip" })
    use({ "rafamadriz/friendly-snippets" })

    --autocompletion
    use({ "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "hrsh7th/cmp-cmdline" })
    use({ "saadparwaiz1/cmp_luasnip" })

    --debug
    use({ "mfussenegger/nvim-dap" })
    use({ "theHamsta/nvim-dap-virtual-text", requires = "mfussenegger/nvim-dap" })
    use({ "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" })
    use({ "nvim-telescope/telescope-dap.nvim" })
    use({ "mxsdev/nvim-dap-vscode-js", requires = "mfussenegger/nvim-dap" })
    use({ "microsoft/vscode-js-debug", opt = true, run = "npm install --legacy-peer-deps && npm run compile" })
end)
