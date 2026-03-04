local function set_transparent()
  local groups = {
    "Normal", "NormalNC", "SignColumn", "MsgArea",
    "NormalFloat", "FloatBorder",
    -- Telescope
    "TelescopeNormal", "TelescopeBorder",
    "TelescopePromptNormal", "TelescopePromptBorder",
    "TelescopeResultsNormal", "TelescopeResultsBorder",
    "TelescopePreviewNormal", "TelescopePreviewBorder",
  }
  for _, grp in ipairs(groups) do
    vim.api.nvim_set_hl(0, grp, { bg = "none" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_transparent,
})

function ColorMyPencils(color)
	color = color or "gruvbox-material"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
