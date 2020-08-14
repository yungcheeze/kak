hook global BufCreate .*(zshenv|zprofile|zshrc|direnvrc|envrc|\benv|lfrc) %{
    set-option buffer filetype sh
}

hook global BufCreate .*(Jenkinsfile) %{
    set-option buffer comment_line '//'
}
