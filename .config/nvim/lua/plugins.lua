local packer = require("packer")

local use = packer.use
packer.reset()

packer.startup(function()
	use({
		"wbthomason/packer.nvim",
		opt = false,
	})
	use("neovim/nvim-lspconfig") -- Configurations for Nvim LSP
	use("nvim-lua/plenary.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("nvim-telescope/telescope.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
	})
	use("Mofiqul/vscode.nvim")
	use("L3MON4D3/LuaSnip")
	use({
		"declancm/maximize.nvim",
		config = function()
			require("maximize").setup()
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({ "williamboman/mason.nvim" })
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({ "mfussenegger/nvim-dap" })
	use({ "theHamsta/nvim-dap-virtual-text", requires = { "mfussenegger/nvim-dap" } })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	-- snapshots 22.09.18
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npm run compile",
	})
	use("nvim-telescope/telescope-dap.nvim")
	use({ "lewis6991/gitsigns.nvim" })
	use({
		"akinsho/toggleterm.nvim",
	})
	-- uskk"famiu/bufdelete.nvim")
	use({
		"crusj/bookmarks.nvim",
		branch = "main",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use("lukas-reineke/indent-blankline.nvim")
	use("folke/which-key.nvim")
	use({ "mrjones2014/legendary.nvim" })
end)
