local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
	spec = {
		{ -- Set color scheme and disable bg
			"ellisonleao/gruvbox.nvim",
			config = function()
				require("gruvbox").setup({
					dim_inactive = false,
					transparent_mode = true,
				})
				vim.cmd.colorscheme "gruvbox"
			end
		},
		{ -- Bufferline tabs
			'akinsho/bufferline.nvim',
			version = '*',
			dependencies = 'nvim-tree/nvim-web-devicons',
			config = function()
				require('bufferline').setup()
			end,
		},
		{
			'goolord/alpha-nvim',
			config = function()
				require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
			end
		},
		{
			'nvim-tree/nvim-web-devicons',
		},
		{ import = "config.plugins" },
	},
	change_detection = {
		enabled = false,
		notify = false,
	},
})
