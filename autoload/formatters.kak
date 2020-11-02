provide-module formatters %{

hook global WinSetOption filetype=json %{
    set-option window formatcmd 'prettier --parser=json'
}
hook global WinSetOption filetype=python %{
    set-option window formatcmd 'isort - | black --line-length=80 -'
}

hook global WinSetOption filetype=markdown %{
    set-option window formatcmd 'prettier --parser=markdown --prose-wrap=always'
}

hook global BufCreate .*.txt %{
    set-option window formatcmd 'fmt --width=80'
}

}


