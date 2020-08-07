source "%val{config}/plugins/plug.kak/rc/plug.kak"


plug "delapouite/kakoune-text-objects"

plug "ul/kak-lsp" do %{
        cargo install --locked --force --path .
} subset %{
} config %{
    eval %sh{~/.cargo/bin/kak-lsp --kakoune -s $kak_session}
    hook global WinSetOption filetype=(python|c|cpp|sh) %{
            lsp-enable-window
            map global spacekak <a-l> ':enter-user-mode<space>lsp<ret>'
    }
}

plug "alexherbo2/auto-pairs.kak" commit "3e529e8002fe07e952c3a895f50dc749eb2b40de"

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

plug "occivink/kakoune-vertical-selection"

plug "alexherbo2/split-object.kak" config %{
      map -docstring "split object" global normal '<a-I>' ': enter-user-mode split-object<ret>'
}

plug "danr/kakoune-easymotion" config %{
    set-option global em_jumpchars asdfghjkl
}

plug "greenfork/active-window.kak"

plug "occivink/kakoune-phantom-selection"

plug "alexherbo2/objectify.kak"

plug "occivink/kakoune-find"

plug "andreyorst/kakoune-snippet-collection"

plug "occivink/kakoune-snippets" config %{
    set-option -add global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
    set-option global snippets_auto_expand false
    map global insert '<a-/>' '<a-;>: expand-or-jump<ret>'

    define-command expand-or-jump %{
        try %{
            snippets-select-next-placeholders
        } catch %{
            snippets-expand-trigger %{
                set-register / "%opt{snippets_triggers_regex}\z"
                execute-keys 'hGhs<ret>'
            }
        } catch %{
            nop
        }
    }
}

plug "delapouite/kakoune-mirror" config %{
    map global mirror <space> 'a<space><esc>i<space><esc>H<a-;>'  -docstring '·surround·'
}

plug "lePerdu/kakboard" config %{
    hook global WinCreate .* %{ kakboard-enable }
    hook global WinSetOption kakboard_enabled=true %{
        map global insert '<c-y>'           '<esc>:kakboard-with-pull-clipboard P<ret>i'      -docstring "paste before the cursor"
    }
    hook global WinSetOption kakboard_enabled=false %{
        map global insert '<c-y>'           '<esc>Pi'      -docstring "paste before the cursor"
    }
}

plug "andreyorst/tagbar.kak" defer "tagbar" %{
    set-option global tagbar_sort false
    set-option global tagbar_size 40
    set-option global tagbar_display_anon false
} config %{
    # if you have wrap highlighter enamled in you configuration
    # files it's better to turn it off for tagbar, using this hook:
    hook global WinSetOption filetype=tagbar %{
        remove-highlighter window/wrap
        # you can also disable rendering whitespaces here, line numbers, and
        # matching characters
    }
}

plug "dgmulf/local-kakrc.git" config %{
    set-option global source_local_kakrc true
}

plug "jbomanson/search-doc.kak" config %{
    require-module search-doc
}

plug "occivink/kakoune-sudo-write"
