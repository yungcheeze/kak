# Avoid escape key
map -docstring "avoid escape key" global normal '<c-g>' ';<space>'
map -docstring "avoid escape key" global prompt '<c-g>' '<esc>'
map -docstring "avoid escape key" global insert '<c-g>' '<esc>'
map -docstring "avoid escape key" global view '<c-g>' '<esc>'

# emacs character motion
map global insert '<c-n>' '<down>'
map global insert '<c-p>' '<up>'
map global insert '<c-f>' '<right>'
map global insert '<a-f>' '<esc>wli'
map global insert '<c-b>' '<left>'
map global insert '<a-b>' '<esc>b;i'
map global insert '<c-a>'           '<a-;>gh'      -docstring "move the cursor to the start of the line"
map global insert '<c-e>'           '<esc>glli'    -docstring "move the cursor to the end of the line"
map global insert '<c-d>'           '<a-;>c'       -docstring "delete the character under the anchor"
map global insert '<c-u>'           '<esc>h<a-h>c' -docstring "delete from the cursor to the start of the line"
map global insert '<c-k>'           '<esc><a-l>c'  -docstring "delete from the cursor to the end of the line"
map global insert '<a-d>'           '<esc>ec'      -docstring "delete until the next word boundary"
map global insert '<c-w>'           '<esc>c'      -docstring "delete selection"
map global insert '<a-backspace>' '<esc>bc'      -docstring "delete until the previous word boundary"
map global insert '<c-y>'           '<esc>Pi'      -docstring "paste before the cursor"

# emacs page scrolling
map global normal '<c-v>' '<pagedown>'
map global normal '<a-v>' '<pageup>'

# still used to meta-x
map global insert '<a-x>' ':'
map global normal '<a-x>' ':'

# temporarily unbind <c-n> and <c-p> for completions
hook global InsertCompletionShow .* %{ try %{
    unmap global insert '<c-n>' '<down>'
    unmap global insert '<c-p>' '<up>'
}}
hook global InsertCompletionHide .* %{
    map global insert '<c-n>' '<down>'
    map global insert '<c-p>' '<up>'
}

# misc
map global normal '<a-*>' ':select-or-add-cursor<ret>'

# spacekak

declare-user-mode spacekak
map global normal <space> ':enter-user-mode<space>spacekak<ret>'

map global spacekak <space> ':enter-user-mode<space>user<ret>'

declare-user-mode spacekak-files
map global spacekak f ':enter-user-mode<space>spacekak-files<ret>' -docstring 'files'

map global spacekak-files s ':w<ret>' -docstring 'save'
map global spacekak-files f ':file<space>' -docstring 'find'
map global spacekak-files F ':file-all<space>' -docstring 'find (all)'
map global spacekak-files e ':edit<space>' -docstring 'create/edit'
map global spacekak-files t ':set-option<space>current<space>filetype<space>' -docstring 'change filetye'
map global spacekak-files c ':autocd<ret>' -docstring 'change buffer to current directory'
map global spacekak-files l ':repl lf<ret>' -docstring 'browse (lf)'
map global spacekak-files b ':repl broot<ret>' -docstring 'browse (broot)'

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
map global spacekak-buffers f ':format<ret>' -docstring 'format buffer'

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

declare-user-mode spacekak-toggles
map global spacekak t ':enter-user-mode<space>spacekak-toggles<ret>' -docstring 'toggles'

map global spacekak-toggles d ':git<space>show-diff<ret>' -docstring 'git diff'
map global spacekak-toggles a ':auto-pairs-disable<ret>' -docstring 'disable autopairs'
map global spacekak-toggles A ':auto-pairs-enable<ret>' -docstring 'enable autopairs'
map global spacekak-toggles w ':autowrap-disable<ret>' -docstring 'disable autopairs'
map global spacekak-toggles W ':autowrap-enable<ret>' -docstring 'enable autopairs'
map global spacekak-toggles i ':tagbar-toggle-or-enable<ret>' -docstring 'imenu'
define-command -hidden tagbar-toggle-or-enable %{
    try %{
        tagbar-toggle
    } catch %{
        tagbar-enable
    }
}

declare-user-mode spacekak-comment
map global spacekak c ':enter-user-mode<space>spacekak-comment<ret>' -docstring 'comment'

map global spacekak-comment c ':comment-line<ret>' -docstring 'line'
map global spacekak-comment l ':comment-line<ret>' -docstring 'line'
map global spacekak-comment b ':comment-block<ret>' -docstring 'block'
map global spacekak-comment y 'y:comment-line<ret>' -docstring 'line (and yank)'

declare-user-mode spacekak-insert
map global spacekak i ':enter-user-mode<space>spacekak-insert<ret>' -docstring 'insert'

map global spacekak-insert O 'O<esc>j' -docstring 'line'
map global spacekak-insert o 'o<esc>k' -docstring 'line'

declare-user-mode spacekak-mirror
map global spacekak m ':enter-user-mode<space>-lock<space>mirror<ret>' -docstring 'mirror'

declare-user-mode spacekak-text
map global spacekak x ':enter-user-mode<space>spacekak-text<ret>' -docstring 'text'

map global spacekak-text u '~' -docstring 'upcase'
map global spacekak-text l '`' -docstring 'downcase'

declare-user-mode spacekak-text-inflection
map global spacekak-text i ':enter-user-mode<space>spacekak-text-inflection<ret>' -docstring 'inflection'
map global spacekak-text-inflection k ':kebabcase<ret>' -docstring 'kebabcase'
map global spacekak-text-inflection c ':camelcase<ret>' -docstring 'camelcase'
map global spacekak-text-inflection s ':snakecase<ret>' -docstring 'snakecase'

declare-user-mode spacekak-easymotion
map global spacekak e ':enter-user-mode<space>spacekak-easymotion<ret>' -docstring 'easymotion'

map global spacekak-easymotion e ':easy-motion-char<ret>' -docstring 'char ->'
map global spacekak-easymotion c ':easy-motion-char<ret>' -docstring 'char ->'
map global spacekak-easymotion w ':easy-motion-w<ret>' -docstring 'word ->'
map global spacekak-easymotion W ':easy-motion-W<ret>' -docstring 'WORD ->'
map global spacekak-easymotion j ':easy-motion-j<ret>' -docstring 'line <-'
map global spacekak-easymotion k ':easy-motion-k<ret>' -docstring 'line ->'
map global spacekak-easymotion f ':easy-motion-f<ret>' -docstring 'char ->'
map global spacekak-easymotion <a-f> ':easy-motion-alt-f<ret>' -docstring 'char <-'
map global spacekak-easymotion b ':easy-motion-b<ret>' -docstring 'word <-'
map global spacekak-easymotion B ':easy-motion-B<ret>' -docstring 'WORD <-'
map global spacekak-easymotion s ':easy-motion-on-regex<ret>' -docstring 'regex'
map global spacekak-easymotion / ':easy-motion-on-regex<ret>' -docstring 'regex'

declare-user-mode spacekak-phantom-sel
map global spacekak p ':enter-user-mode<space>spacekak-phantom-sel<ret>' -docstring 'phantom selections'

map global spacekak-phantom-sel c ':phantom-selection-add-selection<ret>' -docstring 'add'
map global spacekak-phantom-sel a ':phantom-selection-select-all<ret>' -docstring 'add'
map global spacekak-phantom-sel d ':phantom-selection-clear<ret>' -docstring 'clear'
map global spacekak-phantom-sel n ':phantom-selection-iterate-next<ret>' -docstring 'next'
map global spacekak-phantom-sel p ':phantom-selection-iterate-prev<ret>' -docstring 'prev'
