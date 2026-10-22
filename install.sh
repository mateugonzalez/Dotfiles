cat << 'EOF' > install.sh
#!/bin/bash
# Obtener la ruta donde se ha descargado el repositorio
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copiar .vimrc
if [ -f "$DOTFILES_DIR/.vimrc" ]; then
    cp "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
    echo "✓ .vimrc instalado"
fi

# Configurar la shell (Bash o Zsh según lo que esté corriendo)
if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "*/zsh" ]; then
    [ -f "$DOTFILES_DIR/.zshrc" ] && cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    echo "✓ .zshrc instalado"
else
    # Si la máquina corre Bash, inyectamos tus alias o copiamos tu configuración
    if [ -f "$DOTFILES_DIR/.bashrc" ]; then
        cp "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
    elif [ -f "$DOTFILES_DIR/.zshrc" ]; then
        # Compatibilidad básica: enlazar alias comunes si solo tienes zshrc
        cp "$DOTFILES_DIR/.zshrc" "$HOME/.bashrc"
    fi
    echo "✓ Configuración de terminal aplicada a Bash"
fi
EOF
chmod +x install.sh
