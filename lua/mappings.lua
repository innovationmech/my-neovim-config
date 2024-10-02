require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


-- Nvim dap
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- Go 相关的映射
map("n", "<leader>gr", "<cmd>GoRun<cr>", { desc = "Go Run" })
map("n", "<leader>gt", "<cmd>GoTest<cr>", { desc = "Go Test" })
map("n", "<leader>gi", "<cmd>GoImport<cr>", { desc = "Go Import" })
map("n", "<leader>gf", "<cmd>GoFmt<cr>", { desc = "Go Format" })

-- Go 调试相关的映射
map("n", "<leader>dgt", "<cmd>lua require'dap-go'.debug_test()<CR>", { desc = "Debug go test" })
map("n", "<leader>dgl", "<cmd>lua require'dap-go'.debug_last()<CR>", { desc = "Debug last go test" })

-- hop.nvim
local hop = require('hop')
local directions = require('hop.hint').HintDirection

-- 单行跳转
map('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
map('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
map('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
map('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})

-- 全局跳转
map('n', '<leader><leader>w', function()
  hop.hint_words()
end, {remap=true, desc = "Hop words"})
map('n', '<leader><leader>j', function()
  hop.hint_lines()
end, {remap=true, desc = "Hop lines"})
map('n', '<leader><leader>k', function()
  hop.hint_lines({direction = directions.BEFORE_CURSOR})
end, {remap=true, desc = "Hop lines upward"})

-- C++ 相关的映射
map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch between source/header" })
map("n", "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>", { desc = "Show type hierarchy" })
map("n", "<leader>cm", "<cmd>ClangdSymbolInfo<cr>", { desc = "Show symbol info" })

-- CMake 相关的映射
map("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
map("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
map("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })

-- Python 相关的映射
map("n", "<leader>pr", "<cmd>!python3 %<cr>", { desc = "运行 Python 文件" })
map("n", "<leader>pc", "<cmd>lua require('dap-python').test_class()<CR>", { desc = "运行 Python 测试类" })
map("n", "<leader>ps", "<cmd>lua require('dap-python').debug_selection()<CR>", { desc = "调试 Python 选择" })

-- Java 相关的映射
map("n", "<leader>jc", "<cmd>lua require('jdtls').compile('full')<CR>", { desc = "Compile Java project" })
map("n", "<leader>jf", "<cmd>lua require('jdtls').organize_imports()<CR>", { desc = "Organize imports" })
map("n", "<leader>jt", "<cmd>lua require('jdtls').test_class()<CR>", { desc = "Run test class" })
map("n", "<leader>jn", "<cmd>lua require('jdtls').test_nearest_method()<CR>", { desc = "Run nearest test" })