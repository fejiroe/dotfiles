return {
  cmd = { 'clangd',
    '--background-index',
    '--completion-style=detailed',
    '--clang-tidy'},
  root_markers = { '.clangd', 
    'compile_commands.json',
    'build.ninja',
    '.git',
    'Makefile'},
  filetypes = { 'c', 'cpp' },
}
