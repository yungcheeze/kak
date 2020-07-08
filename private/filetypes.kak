hook global BufCreate .*(zshenv|zprofile|zshrc|direnvrc|envrc|\benv) %{
    set-option buffer filetype sh
}

