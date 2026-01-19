local present, toggleterm = pcall(require, 'toggleterm')
if not present then
  return
end

toggleterm.setup({ 
  cmd = "tmux && exit",
  open_mapping = [[<c-\>]],
  insert_mappings = false,
  start_in_insert = false,
  persist_mode = false,
  size = 60,
  direction = 'vertical',
  shade_terminals = false
})
