return {
	{
		"gnikdroy/projections.nvim",
		keys = {
			{
				"<leader>fp",
				function()
					vim.cmd("Telescope projections")
				end,
			},
		},
		config = function()
			vim.opt.sessionoptions:append("localoptions") -- Save localoptions to session file
			require("projections").setup({
        workspaces = {
          { "~/Projects", { ".git" } },
          { "~", { ".git" } },
        }
			})

			-- Bind <leader>fp to Telescope projections
			require("telescope").load_extension("projections")

			-- Autostore session on VimExit
			local Session = require("projections.session")
			vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
				callback = function()
					Session.store(vim.loop.cwd())
				end,
			})

			-- Switch to project if vim was started in a project dir
			local switcher = require("projections.switcher")
			vim.api.nvim_create_autocmd({ "VimEnter" }, {
				callback = function()
					if vim.fn.argc() == 0 then
						switcher.switch(vim.loop.cwd())
					end
				end,
			})
		end,
	},
}
