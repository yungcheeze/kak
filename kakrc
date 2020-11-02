# Preamble
require-module plug

# Let plug.kak manage itself.
plug plug https://github.com/alexherbo2/plug.kak %{
  # Upgrade plugins
  # Install plugins and build them.
  define-command plug-upgrade -docstring 'plug-upgrade' %{
    plug-install
    plug-execute connect make install
    plug-execute lsp cargo build --release
  }
}

plug-core %{
  colorscheme nord
  set-option global grepcmd 'rg --column --with-filename --no-ignore-global --hidden'
  set-option global autoreload yes
}
