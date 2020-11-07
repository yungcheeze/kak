provide-module filetypes %{

hook global BufCreate .*(zshenv|zprofile|zshrc|direnvrc|envrc|\benv|lfrc) %{
    set-option buffer filetype sh
}

hook global BufCreate .*(flake8|pylintrc) %{
    set-option buffer filetype ini
}

hook global BufCreate .*(Jenkinsfile|qml) %{
    set-option buffer comment_line '//'
}

}
