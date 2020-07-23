hook global WinSetOption filetype=json %{
    set-option window formatcmd 'prettier --parser=json'
}
hook global WinSetOption filetype=python %{
    set-option window formatcmd 'isort - | black --line-length=80 -'
}
