
colorscheme lucius

# Avoid escape key
map -docstring "avoid escape key" global normal '<c-g>' ';<space>'
map -docstring "avoid escape key" global prompt '<c-g>' '<esc>'
map -docstring "avoid escape key" global insert '<c-g>' '<esc>'
hook global InsertChar k %{ try %{
      exec -draft hH <a-k>jk<ret> d
        exec <esc>
}}
hook global InsertChar j %{ try %{
        exec -draft hH <a-k>kj<ret> d
        exec <esc>
}}


declare-user-mode spacekak
map global normal <space> ':enter-user-mode<space>spacekak<ret>'

map global spacekak <space> ':'

declare-user-mode spacekak-files
map global spacekak f ':enter-user-mode<space>spacekak-files<ret>' -docstring 'files'

map global spacekak-files s ':w<ret>' -docstring 'save file'

declare-user-mode spacekak-quit
map global spacekak q ':enter-user-mode<space>spacekak-quit<ret>' -docstring 'quit'

map global spacekak-quit q ':quit<ret>' -docstring 'quit'
map global spacekak-quit Q ':quit!<ret>' -docstring 'quit impolitely'
map global spacekak-quit w ':write-quit!<ret>' -docstring 'quit and save'
