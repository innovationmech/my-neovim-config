-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",
}

-- 新增 Mason 配置
M.mason = {
	pkgs = {
		-- Go 相关
		"gopls",
		"golangci-lint",
		"delve",
		-- Rust 相关
		"rust-analyzer",
		-- 可以添加其他您需要的包
		-- C++ 相关
		"clangd",
		"clang-format",
		"codelldb",
		"cmake-language-server",
		-- python 相关
		"pyright",
		"isort",
		-- Java 相关
		"jdtls",
		"java-debug-adapter",
		"java-test",
	}
}

return M
