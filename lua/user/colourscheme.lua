local colourscheme = "default"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colourscheme)
if not status_ok then
  vim.notify("colorscheme " .. colourscheme .. " not found!")
  return
end
