# Preamble
require-module plug

# Let plug.kak manage itself.
plug plug https://github.com/alexherbo2/plug.kak %{
  # Upgrade plugins
  # Install plugins and build them.
  define-command plug-upgrade -docstring 'plug-upgrade' %{
    plug-install
    # plug-execute connect make install
    # plug-execute lsp cargo build --release
  }
}

plug-core %{
    colorscheme nord
    set-option global grepcmd 'rg --column --with-filename'
    set-option global autoreload yes
    plug-autoload commands

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

}



plug-autoload bindings
plug-autoload filetypes
plug-autoload formatters
plug-autoload misc

plug kakboard https://github.com/yungcheeze/kakboard %{
    # hook global WinCreate .* %{ kakboard-enable }
    hook global WinSetOption kakboard_enabled=true %{
        map global insert '<c-y>'           '<esc>:kakboard-with-pull-clipboard P<ret>i'      -docstring "paste before the cursor"
    }
    hook global WinSetOption kakboard_enabled=false %{
        map global insert '<c-y>'           '<esc>Pi'      -docstring "paste before the cursor"
    }
}

plug-old lsp https://github.com/kak-lsp/kak-lsp %{
    hook global WinSetOption filetype=(python|c|cpp|sh|haskell) %{
        lsp-enable-window
        map global spacekak l ':enter-user-mode<space>lsp<ret>' -docstring "lsp"
    }
}

plug-old text-objects https://github.com/Delapouite/kakoune-text-objects

plug prelude https://github.com/alexherbo2/prelude.kak

plug auto-pairs https://github.com/alexherbo2/auto-pairs.kak %{
  auto-pairs-enable
    hook global WinSetOption filetype=(kak|html) %{
        set-option -add window auto_pairs < >
    }
}

plug-old smarttab https://github.com/andreyorst/smarttab.kak %{
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

plug split-object https://github.com/alexherbo2/split-object.kak %{
    map -docstring "split object" global normal '<a-I>' ': enter-user-mode split-object<ret>'
}

plug-old active-window https://github.com/greenfork/active-window.kak.git

plug-old phantom-selection https://github.com/occivink/kakoune-phantom-selection

plug objectify https://github.com/alexherbo2/objectify.kak

plug-old find https://github.com/occivink/kakoune-find

#TODO alexherbo snippets.kak (seems promising)

plug replace-mode https://github.com/alexherbo2/replace-mode.kak %{
      map -docstring 'Replace' global user r ': enter-replace-mode<ret>'
}

plug-old mirror https://github.com/delapouite/kakoune-mirror %{
    map global mirror <space> 'a<space><esc>i<space><esc>H<a-;>'  -docstring '·surround·'
}

plug-old auto-percent https://github.com/delapouite/kakoune-auto-percent

plug-old surround https://github.com/h-youhei/kakoune-surround

plug-old local-kakrc https://github.com/dgmulf/local-kakrc.git %{
    set-option global source_local_kakrc true
}

plug-old sudo-write https://github.com/occivink/kakoune-sudo-write

plug-old livedown https://github.com/Delapouite/kakoune-livedown.git

plug-old extra-filetypes https://github.com/kakoune-editor/kakoune-extra-filetypes

plug-old kak-tree https://github.com/ul/kak-tree %{
    set-option global tree_cmd 'kak-tree -vvv'
}

plug parinfer https://github.com/eraserhd/parinfer-rust %{
    hook global WinSetOption filetype=(clojure|lisp|scheme|racket) %{
        parinfer-enable-window -smart
    }
}

plug-old kak-crosshairs https://github.com/insipx/kak-crosshairs

plug-old kakoune-toggle-map https://github.com/krornus/kakoune-toggle-map

plug-old ansi https://github.com/eraserhd/kak-ansi

plug-old easymotion https://github.com/danr/kakoune-easymotion %{
    set-option global em_jumpchars asdfghjkl
    face global EasyMotionBackground rgb:aaaaaa
    face global EasyMotionForeground rgb:ad1f15+bf
    face global EasyMotionSelected rgb:f5de14+bf
}
