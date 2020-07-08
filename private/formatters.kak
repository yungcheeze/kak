hook global WinSetOption filetype=json %{
    set-option window formatcmd 'prettier --parser=json'
}
