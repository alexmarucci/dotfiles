local present, toggleterm = pcall(require, 'toggleterm')
if not present then
  return
end

toggleterm.setup({ 
  cmd = "tmux && exit",
  open_mapping = [[<c-\>]],
  insert_mappings = false,
  size = 60,
  direction = 'vertical',
  shade_terminals = false
})
