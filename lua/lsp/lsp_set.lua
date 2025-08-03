local M = {}
function  M.setup()
	vim.diagnostic.enable()

	vim.diagnostic.config({
	  virtual_text = {
		severity = { min = vim.diagnostic.severity.ERROR, max = vim.diagnostic.severity.ERROR },
	  },
	  signs = {
		severity = { min = vim.diagnostic.severity.ERROR, max = vim.diagnostic.severity.ERROR },
	  },
	  underline = {
		severity = { min = vim.diagnostic.severity.ERROR, max = vim.diagnostic.severity.ERROR },
	  },
	  float = {
		severity_sort = true,
		severity = { min = vim.diagnostic.severity.ERROR, max = vim.diagnostic.severity.ERROR },
	  },
	})

end

return M
