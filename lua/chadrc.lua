-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",
}

-- 新增 Mason related
M.mason = {
	pkgs = {
		-- Go related
		"gopls",
		"golangci-lint",
		"delve",
		-- Rust realted
		"rust-analyzer",
		-- C++ related
		"clangd",
		"clang-format",
		"codelldb",
		"cmake-language-server",
		-- python related
		"pyright",
		"isort",
		-- Java related
		"jdtls",
		"java-debug-adapter",
		"java-test",
	}
}

return M
