
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
