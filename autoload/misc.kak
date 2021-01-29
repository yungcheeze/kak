provide-module misc %{

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

# Highlight TODO, FIXME, NOTE and XXX comments
add-highlighter global/ regex \b(TODO|FIXME|XXX|NOTE)\b 0:default+rb

add-highlighter global/ show-matching

# remove trailing whitespace on save
hook global BufWritePre .* %{ try %{ execute-keys -draft \%s\h+$<ret>d } }
define-command delete-trailing-whitespace-buffer %{  execute-keys -draft \%s\h+$<ret>d  }
define-command delete-trailing-whitespace-selection %{  execute-keys -draft s\h+$<ret>d  }

## other highlighters
# show git diff (git-gutter)
hook global WinCreate .* %{ try %{
    add-highlighter buffer/show-whitespaces show-whitespaces -lf ' ' -spc ' ' -nbsp '⋅'
    git show-diff
}}
hook global BufWritePost .* %{ try %{
    git show-diff
}}

hook global  KakBegin .* %{
    autocd-git-root
}

# delete COMMIT_EDITMSG buffers so they don't persist in sessions
hook global ClientClose .* %{
    try %{
        delete-buffer! COMMIT_EDITMSG
    }
    try %{
        delete-buffer! MERGE_MSG
    }
}

}

