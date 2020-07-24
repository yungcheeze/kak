
define-command -docstring "Convert all leading spaces to tabs" \
leading-spaces-to-tabs %{
    execute-keys -draft %{%s^\h+<ret><a-@>}
}
define-command -docstring "Convert all leading tabs to spaces" \
leading-tabs-to-spaces %{
    execute-keys -draft %{%s^\h+<ret>@}
}


define-command -docstring \
"search-file <filename>: search for file recusively under path option: %opt{path}" \
search-file -params 1 %{ evaluate-commands %sh{
    if [ -n "$(command -v fd)" ]; then                          # create find command template
        find='fd -L --type f "${file}" "${path}"'               # if `fd' is installed it will
    else                                                        # be used because it is faster
        find='find -L "${path}" -mount -type f -name "${file}"' # if not, we fallback to find.
    fi
    file=$(printf "%s\n" $1 | sed -E "s:^~/:$HOME/:") # we want full path
    eval "set -- ${kak_quoted_buflist}"
    while [ $# -gt 0 ]; do            # Check if buffer with this
        if [ "${file}" = "$1" ]; then # file already exists. Basically
            printf "%s\n" "buffer $1" # emulating what edit command does
            exit
        fi
        shift
    done
    if [ -e "${file}" ]; then                     # Test if file exists under
        printf "%s\n" "edit -existing %{${file}}" # servers' working directory
        exit                                      # this is last resort until
    fi                                            # we start recursive searchimg
    # if everthing  above fails - search for file under `path'
    eval "set -- ${kak_quoted_opt_path}"
    while [ $# -gt 0 ]; do                # Since we want to check fewer places,
        case $1 in                        # I've swapped ./ and %/ because
            (./) path=${kak_buffile%/*} ;; # %/ usually has smaller scope. So
            (%/) path=${PWD}            ;; # this trick is a speedi-up hack.
            (*)  path=$1                ;; # This means that `path' option should
        esac                              # first contain `./' and then `%/'
        if [ -z "${file##*/*}" ] && [ -e "${path}/${file}" ]; then
            printf "%s\n" "edit -existing %{${path}/${file}}"
            exit
        else
            # build list of candidates or automatically select if only one found
            # this doesn't support files with newlines in them unfortunately
            IFS='
'
            for candidate in $(eval "${find}"); do
                [ -n "${candidate}" ] && candidates="${candidates} %{${candidate}} %{evaluate-commands %{edit -existing %{${candidate}}}}"
            done
            # we want to get out as early as possible
            # so if any candidate found in current cycle
            # we prompt it in menu and exit
            if [ -n "${candidates}" ]; then
                printf "%s\n" "menu -auto-single ${candidates}"
                exit
            fi
        fi
        shift
    done
    printf "%s\n" "echo -markup %{{Error}unable to find file '${file}'}"
}}

define-command -docstring \
"select a word under cursor, or add cursor on next occurrence of current selection" \
select-or-add-cursor %{
    try %{
        execute-keys "<a-k>\A.\z<ret>"
        execute-keys -save-regs '' "_<a-i>w*"
    } catch %{
        execute-keys -save-regs '' "_*<s-n>"
    } catch nop
}

define-command -override -docstring "file <path> [<line>]: Fuzzy search and open file. If <line> argument is specified jump to the <line> after opening" \
file-all -shell-script-candidates %{
    [ -n "$(command -v fd)" ] && fd . -L --hidden --no-ignore --type f || find . -follow -type f
} -params 1..2 %{ evaluate-commands %sh{
    file=$(printf "%s\n" "$1" | sed "s/&/&&/g")
    printf "%s\n" "edit -existing -- %&${file}&"
    [ $# -gt 1 ] && printf "%s\n" "execute-keys '${2}g'"
}}

define-command -override -docstring "file <path> [<line>]: Fuzzy search and open file. If <line> argument is specified jump to the <line> after opening" \
file -shell-script-candidates %{
    [ -n "$(command -v fd)" ] && fd . -L --type f || find . -follow -type f
} -params 1..2 %{ evaluate-commands %sh{
    file=$(printf "%s\n" "$1" | sed "s/&/&&/g")
    printf "%s\n" "edit -existing -- %&${file}&"
    [ $# -gt 1 ] && printf "%s\n" "execute-keys '${2}g'"
}}

hook global ModuleLoaded tmux %{
    define-command -docstring "vsplit [<commands>]: split tmux vertically" \
    vsplit -params .. -command-completion %{
        tmux-terminal-horizontal kak -c %val{session} -e "%arg{@}"
    }
    define-command -docstring "split [<commands>]: split tmux horizontally" \
    split -params .. -command-completion %{
        tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"
    }
    define-command -docstring "tabnew [<commands>]: create new tmux window" \
    tabnew -params .. -command-completion %{
        tmux-terminal-window kak -c %val{session} -e "%arg{@}"
    }
}

define-command select-prev-subword %{
  exec <a-/>[A-Z][a-z]+|[A-Z]+|[a-z]+<ret>
}
define-command select-next-subword %{
  exec /[A-Z][a-z]+|[A-Z]+|[a-z]+<ret>
}
define-command extend-prev-subword %{
  exec <a-?>[A-Z][a-z]+|[A-Z]+|[a-z]+<ret>
}
define-command extend-next-subword %{
  exec ?[A-Z][a-z]+|[A-Z]+|[a-z]+<ret>
}

# foo_bar → fooBar
# foo-bar → fooBar
# foo bar → fooBar
define-command camelcase %{
  exec '`s[-_<space>]<ret>d~<a-i>w'
}

# fooBar → foo_bar
# foo-bar → foo_bar
# foo bar → foo_bar
define-command snakecase %{
  exec '<a-:><a-;>s-|[a-z][A-Z]<ret>;a<space><esc>s[-\s]+<ret>c_<esc><a-i>w`'
}

# fooBar → foo-bar
# foo_bar → foo-bar
# foo bar → foo-bar
define-command kebabcase %{
  exec '<a-:><a-;>s_|[a-z][A-Z]<ret>;a<space><esc>s[_\s]+<ret>c-<esc><a-i>w`'
}

define-command git-write %{
  write
  git add
}

define-command git-commit %{
  git commit
}

define-command git-amend %{
  git commit --amend
}
