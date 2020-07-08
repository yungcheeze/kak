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
source "%val{config}/private/filetypes.kak"
source "%val{config}/private/bindings.kak"
source "%val{config}/private/misc.kak"

colorscheme lucius
