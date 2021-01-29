provide-module bindings %{

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

declare-user-mode spacekak-buffers
map global spacekak b ':enter-user-mode<space>spacekak-buffers<ret>' -docstring 'buffers'

map global spacekak-buffers b ':buffer<space>' -docstring 'change'
map global spacekak-buffers d ':delete-buffer<ret>' -docstring 'delete'
map global spacekak-buffers <a-d> ':delete-buffer!<ret>' -docstring 'delete (force)'
map global spacekak-buffers f ':format<ret>' -docstring 'format buffer'
map global spacekak-buffers n ':buffer-next<ret>' -docstring 'next'
map global spacekak-buffers p ':buffer-previous<ret>' -docstring 'previous'
map global spacekak-buffers s ':scratch<ret>' -docstring 'scratch'

declare-user-mode spacekak-comment
map global spacekak c ':enter-user-mode<space>spacekak-comment<ret>' -docstring 'comment'

map global spacekak-comment c ':comment-line<ret>' -docstring 'line'
map global spacekak-comment l ':comment-line<ret>' -docstring 'line'
map global spacekak-comment b ':comment-block<ret>' -docstring 'block'
map global spacekak-comment y 'y:comment-line<ret>' -docstring 'line (and yank)'

declare-user-mode spacekak-easymotion
map global spacekak e ':enter-user-mode<space>spacekak-easymotion<ret>' -docstring 'easymotion'

map global spacekak-easymotion e     ':easy-motion-char<ret>'     -docstring 'char ->'
# map global spacekak-easymotion E     'Z:easy-motion-char<ret><a-z>u'     -docstring 'char ->'
map global spacekak-easymotion c     ':easy-motion-char<ret>'     -docstring 'char ->'
map global spacekak-easymotion w     ':easy-motion-w<ret>'        -docstring 'word ->'
map global spacekak-easymotion <a-w> ':easy-motion-W<ret>'        -docstring 'WORD ->'
map global spacekak-easymotion j     ':easy-motion-j<ret>'        -docstring 'line <-'
map global spacekak-easymotion k     ':easy-motion-k<ret>'        -docstring 'line ->'
map global spacekak-easymotion f     ':easy-motion-f<ret>'        -docstring 'char ->'
map global spacekak-easymotion <a-f> ':easy-motion-alt-f<ret>'    -docstring 'char <-'
map global spacekak-easymotion b     ':easy-motion-b<ret>'        -docstring 'word <-'
map global spacekak-easymotion <a-b> ':easy-motion-B<ret>'        -docstring 'WORD <-'
map global spacekak-easymotion s     ':easy-motion-on-regex<ret>' -docstring 'regex'
map global spacekak-easymotion /     ':easy-motion-on-regex<ret>' -docstring 'regex'

declare-user-mode spacekak-files
map global spacekak f ':enter-user-mode<space>spacekak-files<ret>' -docstring 'files'

map global spacekak-files b ':repl broot<ret>' -docstring 'browse (broot)'
map global spacekak-files c ':enter-user-mode<space>spacekak-files-cd<ret>' -docstring 'change directory'
map global spacekak-files e ':edit<space>' -docstring 'create/edit'
map global spacekak-files f ':file<space>' -docstring 'find'
map global spacekak-files <a-f> ':file-all<space>' -docstring 'find (all)'
map global spacekak-files t ':set-option<space>current<space>filetype<space>' -docstring 'change filetye'
map global spacekak-files l ':repl lf<ret>' -docstring 'browse (lf)'
map global spacekak-files s ':try %{write} catch %{sudo-write}<ret>' -docstring 'save'
map global spacekak-files <a-s> ':write-all<ret>' -docstring 'save'
map global spacekak-files r ':recentf ' -docstring 'save'

declare-user-mode spacekak-files-cd
map global spacekak-files-cd c ':autocd<ret>' -docstring 'current file'
map global spacekak-files-cd <a-c> ':autocd-prompt<ret>' -docstring 'current file (prompt)'
map global spacekak-files-cd g ':autocd-git-root<ret>' -docstring 'current git-root'

declare-user-mode spacekak-git
map global spacekak g ':enter-user-mode<space>spacekak-git<ret>' -docstring 'git'

map global spacekak-git s ':git status<ret>' -docstring 'status'
map global spacekak-git a ':git-write<ret>' -docstring 'add'
map global spacekak-git T ':repl "tig --branches"<ret>' -docstring 'tig'
map global spacekak-git L ':repl "lazygit"<ret>' -docstring 'lazygit'
map global spacekak-git u ':git update-diff<ret>' -docstring 'update diff'

declare-user-mode spacekak-git-commit
map global spacekak-git c ':enter-user-mode<space>spacekak-git-commit<ret>' -docstring 'commit'
map global spacekak-git-commit c ':git commit<ret>' -docstring 'commit'
map global spacekak-git-commit a ':git commit --amend<ret>' -docstring 'amend'

declare-user-mode spacekak-git-diff
map global spacekak-git d ':enter-user-mode<space>spacekak-git-diff<ret>' -docstring 'diff'
map global spacekak-git-diff d ':git diff<ret>' -docstring 'diff'
map global spacekak-git-diff s ':git diff --staged<ret>' -docstring 'diff (staged)'

declare-user-mode spacekak-insert
map global spacekak i ':enter-user-mode<space>spacekak-insert<ret>' -docstring 'insert'

# TODO insert symbol

map global spacekak 'k' ':enter-user-mode<space>-lock<space>tree<ret>' -docstring 'tree'
declare-user-mode tree
map global tree p ': tree-select-previous-node<ret>' -docstring 'select previous'
map global tree n ': tree-select-next-node<ret>' -docstring 'select next'
map global tree u ': tree-select-parent-node<ret>' -docstring 'select parent'
map global tree d ': tree-select-children<ret>' -docstring 'select children'
map global tree k ': tree-select-first-child<ret>' -docstring 'select first child'
map global tree f ': tree-select-first-child<ret>' -docstring 'select first child'

map global spacekak '<a-k>' ':enter-user-mode<space>tree-kind<ret>' -docstring 'tree'
declare-user-mode tree-kind
map global tree-kind p ': tree-select-previous-node<space>' -docstring 'select previous'
map global tree-kind n ': tree-select-next-node<space>' -docstring 'select next'
map global tree-kind u ': tree-select-parent-node<space>' -docstring 'select parent'
map global tree-kind d ': tree-select-children<space>' -docstring 'select children'
map global tree-kind k ': tree-select-first-child<space>' -docstring 'select first child'
map global tree-kind f ': tree-select-first-child<space>' -docstring 'select first child'
map global tree-kind s ': tree-node-sexp<ret>' -docstring 'show info'

declare-user-mode spacekak-mirror
map global spacekak m ':enter-user-mode<space>-lock<space>mirror<ret>' -docstring 'mirror'

declare-user-mode spacekak-phantom-sel
map global spacekak p ':enter-user-mode<space>spacekak-phantom-sel<ret>' -docstring 'phantom selections'

map global spacekak-phantom-sel c ':phantom-selection-add-selection<ret>' -docstring 'add'
map global spacekak-phantom-sel a ':phantom-selection-select-all<ret>' -docstring 'activate all'
map global spacekak-phantom-sel d ':phantom-selection-clear<ret>' -docstring 'clear'
map global spacekak-phantom-sel n ':phantom-selection-iterate-next<ret>' -docstring 'next'
map global spacekak-phantom-sel p ':phantom-selection-iterate-prev<ret>' -docstring 'prev'

declare-user-mode spacekak-quit
map global spacekak q ':enter-user-mode<space>spacekak-quit<ret>' -docstring 'quit'

map global spacekak-quit q ':quit<ret>' -docstring 'quit'
map global spacekak-quit <a-q> ':quit!<ret>' -docstring 'quit impolitely'
map global spacekak-quit w ':write-quit!<ret>' -docstring 'quit and save (current-buffer)'
map global spacekak-quit <a-w> ':write-all-quit<ret>' -docstring 'quit and save (all)'

declare-user-mode spacekak-selection
map global spacekak s ':enter-user-mode<space>spacekak-selection<ret>' -docstring 'selection'

declare-user-mode spacekak-selection-clear
map global spacekak-selection c ':enter-user-mode<space>spacekak-selection-clear<ret>' -docstring 'clear'
map global spacekak-selection-clear c '<a-space>' -docstring 'current'
map global spacekak-selection-clear o '<space>' -docstring 'rest'

map global spacekak-selection s ':enter-user-mode<space>split-object<ret>' -docstring 'split object'
map global spacekak-selection "'" ':select-complement<ret>' -docstring 'complement'
map global spacekak-selection f ':format-selections<ret>' -docstring 'format'

declare-user-mode surround
map global spacekak S ':enter-user-mode surround<ret>'
map global surround s ':surround<ret>' -docstring 'surround'
map global surround c ':change-surround<ret>' -docstring 'change'
map global surround d ':delete-surround<ret>' -docstring 'delete'
map global surround t ':select-surrounding-tag<ret>' -docstring 'select tag'

declare-user-mode spacekak-toggles
map global spacekak t ':enter-user-mode<space>spacekak-toggles<ret>' -docstring 'toggles'

map global spacekak-toggles d ':git<space>show-diff<ret>' -docstring 'git diff'
map global spacekak-toggles <a-a> ':auto-pairs-disable<ret>' -docstring 'disable autopairs'
map global spacekak-toggles a ':auto-pairs-enable<ret>' -docstring 'enable autopairs'
map global spacekak-toggles <a-w> ':autowrap-disable<ret>' -docstring 'disable autowrap'
map global spacekak-toggles w ':autowrap-enable<ret>' -docstring 'enable autowrap'
map global spacekak-toggles W ':add-highlighter window/ wrap -indent -marker ↪<ret>' -docstring 'enable line wrap'
map global spacekak-toggles <a-W> ':remove-highlighter window/wrap_-indent_-marker_↪<ret>' -docstring 'disable line wrap'
declare-user-mode crosshairs
map global spacekak-toggles c ':enter-user-mode<space>crosshairs<ret>' -docstring 'crosshairs'
map global crosshairs c ':crosshairs<ret>' -docstring 'line and column'
map global crosshairs x ':cursorline<ret>' -docstring 'line'
map global crosshairs y ':cursorcolumn<ret>' -docstring 'column'

declare-user-mode spacekak-windows
map global spacekak w ':enter-user-mode<space>spacekak-windows<ret>' -docstring 'windows'

map global spacekak-windows s ':split<ret>' -docstring 'split'
map global spacekak-windows / ':vsplit<ret>' -docstring 'vsplit'
map global spacekak-windows d ':quit!<ret>' -docstring 'close window' # todo close if only attached session

declare-user-mode spacekak-text
map global spacekak x ':enter-user-mode<space>spacekak-text<ret>' -docstring 'text'

map global spacekak-text u '~' -docstring 'upcase'
map global spacekak-text l '`' -docstring 'downcase'

declare-user-mode spacekak-text-inflection
map global spacekak-text i ':enter-user-mode<space>spacekak-text-inflection<ret>' -docstring 'inflection'
map global spacekak-text-inflection k ':kebabcase<ret>' -docstring 'kebabcase'
map global spacekak-text-inflection c ':camelcase<ret>' -docstring 'camelcase'
map global spacekak-text-inflection s ':snakecase<ret>' -docstring 'snakecase'

declare-user-mode spacekak-search
map global spacekak '/' ':enter-user-mode<space>spacekak-search<ret>' -docstring 'search'

map global spacekak-search '/' ':flygrep<ret>' -docstring 'flygrep'
map global spacekak-search '<a-/>' ':flygrep-all<ret>' -docstring 'flygrep (all)'
map global spacekak-search 'a' ':find-apply-changes<space>-force<ret>' -docstring 'apply changes'

}
