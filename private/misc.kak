## whitespace

# show tabs, non-breakable spaces and whitespace
hook global WinCreate .* %{ try %{
    add-highlighter buffer/show-whitespaces show-whitespaces -lf ' ' -spc ' ' -nbsp '⋅'
}}

#show trailing whitespace
define-command -hidden show-trailing-whitespaces %{ try %{ add-highlighter global/trailing-whitespaces regex '\h+$' 0:default,red } }
define-command -hidden hide-trailing-whitespaces %{ try %{ remove-highlighter global/trailing-whitespaces } }
hook global WinDisplay .*              show-trailing-whitespaces
hook global ModeChange 'insert:normal' show-trailing-whitespaces
hook global ModeChange 'normal:insert' hide-trailing-whitespaces

# remove trailing whitespace on save
hook global BufWritePre .* %{ try %{ execute-keys -draft \%s\h+$<ret>d } }


## other highlighters
# show git diff (git-gutter)
hook global WinCreate .* %{ try %{
    add-highlighter buffer/show-whitespaces show-whitespaces -lf ' ' -spc ' ' -nbsp '⋅'
    git show-diff
}}
hook global BufWritePost .* %{ try %{
    git show-diff
}}

hook global BufCreate .*(zshenv|zprofile|zshrc|direnvrc|envrc|\benv) %{
    set-option buffer filetype sh
}

