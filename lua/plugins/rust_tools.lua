-- set inlay hints
local status_ok, project = pcall(require, 'rust-tools.inlay_hints')
if not status_ok then
	return
end
project.set_inlay_hints()
