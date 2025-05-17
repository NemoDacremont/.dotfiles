
local config = function()
	vim.g.vimtex_view_method = "zathura"
	vim.g.vimtex_view_general_method = "zathura"
end


return {
	'lervag/vimtex',
	config = config
}

