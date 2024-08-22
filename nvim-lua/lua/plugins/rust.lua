return {
	{
	  "mrcjkb/rustaceanvim",
	  version = "^4", -- Recommended
	  ft = { "rust" },
	  opts = {
		server = {
		  on_attach = function(_, bufnr)
			vim.keymap.set("n", "<leader>cR", function()
			  vim.cmd.RustLsp("codeAction")
			end, { desc = "Code Action", buffer = bufnr })
			vim.keymap.set("n", "<leader>dr", function()
			  vim.cmd.RustLsp("debuggables")
			end, { desc = "Rust Debuggables", buffer = bufnr })
		  end,
		  default_settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {
			  cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			  },
			  -- Add clippy lints for Rust.
			  checkOnSave = {
				allFeatures = true,
				command = "clippy",
				extraArgs = { "--no-deps" },
			  },
			  procMacro = {
				enable = true,
				ignored = {
				  ["async-trait"] = { "async_trait" },
				  ["napi-derive"] = { "napi" },
				  ["async-recursion"] = { "async_recursion" },
				},
			  },
			},
		  },
		},
	  },
	  config = function(_, opts)
		vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
	  end,
	},
    {
        "rust-lang/rust.vim",
        config = function()
            vim.cmd([[
                let g:rustfmt_command = "rustfmt"
                let g:rust_clip_command = 'pbcopy'
                let g:rustfmt_autosave = 1
                let g:rustfmt_emit_files = 1
                let g:rustfmt_fail_silently = 0
                " let g:rustfmt_options = '--edition 2018'
                let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"
            ]])
        end
    }
}
