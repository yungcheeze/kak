source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "delapouite/kakoune-text-objects"
plug "ul/kak-lsp" do %{
        cargo install --locked --force --path .
} subset %{

} config %{
    eval %sh{kak-lsp --kakoune -s $kak_session}
    hook global WinSetOption filetype=(python|c|cpp) %{
            lsp-enable-window
            map global spacekak <a-l> ':enter-user-mode<space>lsp<ret>'
    }
}

plug alexherbo2/auto-pairs.kak config %{
  hook global WinCreate .* %{
    auto-pairs-enable
  }
}
plug "andreyorst/smarttab.kak" config %{

    hook global WinCreate .* %{ try %{
        expandtab
        set-option window softtabstop 2
        set-option window indentwidth 2
    }}

    hook global WinSetOption filetype=(python|kak) %{
        set-option window softtabstop 4
        set-option window indentwidth 4
    }
}
plug "alexherbo2/auto-pairs.kak" %{
        hook global WinCreate .* auto-pairs-enable
}
plug "occivink/kakoune-vertical-selection"
plug "alexherbo2/split-object.kak" config %{
      map -docstring "split object" global normal '<a-I>' ': enter-user-mode split-object<ret>'
}

plug "danr/kakoune-easymotion" config %{
    set-option global em_jumpchars asdfghjkl
}

source "%val{config}/private/commands.kak"
source "%val{config}/private/recentf.kak"
source "%val{config}/private/formatters.kak"
colorscheme lucius

# editor stuff
hook global WinCreate .* %{ try %{
    add-highlighter buffer/show-whitespaces show-whitespaces -lf ' ' -spc ' ' -nbsp '⋅'
    git show-diff
}}

hook global BufWritePost .* %{ try %{
    git show-diff
}}

# remove trailing whitespace on save
hook global BufWritePre .* %{ try %{ execute-keys -draft \%s\h+$<ret>d } }

#show trailing whitespace
define-command -hidden show-trailing-whitespaces %{ try %{ add-highlighter global/trailing-whitespaces regex '\h+$' 0:default,red } }
define-command -hidden hide-trailing-whitespaces %{ try %{ remove-highlighter global/trailing-whitespaces } }
hook global WinDisplay .*              show-trailing-whitespaces
hook global ModeChange 'insert:normal' show-trailing-whitespaces
hook global ModeChange 'normal:insert' hide-trailing-whitespaces

hook global BufCreate .*(zshenv|zprofile|zshrc|direnvrc|envrc|\benv) %{
    set-option buffer filetype sh
}

# LSP
# Avoid escape key
map -docstring "avoid escape key" global normal '<c-g>' ';<space>'
map -docstring "avoid escape key" global prompt '<c-g>' '<esc>'
map -docstring "avoid escape key" global insert '<c-g>' '<esc>'
map -docstring "avoid escape key" global view '<c-g>' '<esc>'

# emacs character motion
map global insert '<c-n>' '<down>'
map global insert '<c-p>' '<up>'
map global insert '<c-f>' '<right>'
map global insert '<c-b>' '<left>'
map global insert '<c-a>' '<a-;>gh'      -docstring "move the cursor to the start of the line"
map global insert '<c-e>' '<esc>glli'    -docstring "move the cursor to the end of the line"
map global insert '<c-d>' '<a-;>c'       -docstring "delete the character under the anchor"
map global insert '<c-u>' '<esc>h<a-h>c' -docstring "delete from the cursor to the start of the line"
map global insert '<c-k>' '<esc><a-l>c'  -docstring "delete from the cursor to the end of the line"
map global insert '<a-d>' '<esc>ec'      -docstring "delete until the next word boundary"
map global insert '<c-w>' '<esc>bc'      -docstring "delete until the previous word boundary"
map global insert '<c-y>' '<esc>Pi'      -docstring "paste before the cursor"

map global insert '<a-x>' ':'
map global normal '<a-x>' ':'

hook global InsertCompletionShow .* %{ try %{
    execute-keys -draft 'h<a-K>\h<ret>'
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
    map window insert <c-g> <c-o>
    unmap global insert '<c-n>' '<down>'
    unmap global insert '<c-p>' '<up>'
}}
hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
    unmap window insert <c-g> <c-o>
    map global insert '<c-n>' '<down>'
    map global insert '<c-p>' '<up>'
}

map global normal '<a-*>' ':select-or-add-cursor<ret>'

declare-user-mode spacekak
map global normal <space> ':enter-user-mode<space>spacekak<ret>'

map global spacekak <space> ':enter-user-mode<space>user<ret>'

declare-user-mode spacekak-files
map global spacekak f ':enter-user-mode<space>spacekak-files<ret>' -docstring 'files'

map global spacekak-files s ':w<ret>' -docstring 'save file'
map global spacekak-files f ':file<space>' -docstring 'find file'

declare-user-mode spacekak-quit
map global spacekak q ':enter-user-mode<space>spacekak-quit<ret>' -docstring 'quit'

map global spacekak-quit q ':quit<ret>' -docstring 'quit'
map global spacekak-quit Q ':quit!<ret>' -docstring 'quit impolitely'
map global spacekak-quit w ':write-quit!<ret>' -docstring 'quit and save'

declare-user-mode spacekak-buffers
map global spacekak b ':enter-user-mode<space>spacekak-buffers<ret>' -docstring 'buffers'

map global spacekak-buffers b ':buffer<space>' -docstring 'change'
map global spacekak-buffers d ':delete-buffer<ret>' -docstring 'delete'
map global spacekak-buffers n ':buffer-next<ret>' -docstring 'next'
map global spacekak-buffers p ':buffer-previous<ret>' -docstring 'previous'

declare-user-mode spacekak-windows
map global spacekak w ':enter-user-mode<space>spacekak-windows<ret>' -docstring 'windows'

map global spacekak-windows s ':split<ret>' -docstring 'split'
map global spacekak-windows / ':vsplit<ret>' -docstring 'vsplit'

declare-user-mode spacekak-yank
map global spacekak y ':enter-user-mode<space>spacekak-yank<ret>' -docstring 'yank'
# System clipboard mappings
map -docstring "copy to system clipboard"                   global spacekak-yank 'y' '<a-|>xsel -b -i<ret>:<space>echo -markup %{{Information}yanked selection to system clipboard}<ret>'
map -docstring "cut to system clipboard"                    global spacekak-yank 'd' '|xsel -b -i<ret>'
map -docstring "cut to system clipboard, enter insert mode" global spacekak-yank 'c' '|xsel -b -i<ret>i'
map -docstring "paste from system clipboard before cursor"  global spacekak-yank 'P' '!xsel --output --clipboard<ret>'
map -docstring "paste from system clipboard after cursor"   global spacekak-yank 'p' '<a-!>xsel --output --clipboard<ret>'
map -docstring "replace selection with system clipboard"    global spacekak-yank 'R' '|xsel --output --clipboard<ret>'

