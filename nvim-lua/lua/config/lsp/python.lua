return {
	setup = function(lspconfig, capabilities)
		lspconfig.basedpyright.setup {
			capabilities = capabilities,
			root_dir = function(...)
				local util = require "lspconfig.util"
				return util.find_git_ancestor(...)
					or util.root_pattern(unpack {
						"pyproject.toml",
						"setup.py",
						"setup.cfg",
						"requirements.txt",
						"Pipfile",
						"pyrightconfig.json",
					})(...)
			end,
			settings = {
				basedpyright = {
					analysis = {
						typeCheckingMode = "basic",
						autoImportCompletions = true,
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
						reportMissingTypeStubs = false,
						diagnosticSeverityOverrides = {
							reportUnusedImport = "information",
							reportUnusedFunction = "information",
							reportUnusedVariable = "information",
							reportGeneralTypeIssues = "none",
							reportOptionalMemberAccess = "none",
							reportOptionalSubscript = "none",
							reportPrivateImportUsage = "none",
						},
					},
				},
			},
		}
	end
}
