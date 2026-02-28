#!/usr/bin/env bash
# brian_script.sh — initialize a fresh Mac with core dev environment

set -e

echo "==> Starting setup..."

# ── 1. Xcode Command Line Tools ───────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "==> Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "    Waiting for Xcode CLT install to finish (click Install in the dialog)..."
  until xcode-select -p &>/dev/null; do sleep 5; done
else
  echo "==> Xcode CLT already installed"
fi

# ── 2. Homebrew ───────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "==> Homebrew already installed"
  eval "$(brew shellenv)"
fi

# ── 3. Brew packages ──────────────────────────────────────────────────────────
BREW_PACKAGES=(
  gh
  node
  go
  jq
  git
)

echo "==> Installing brew packages: ${BREW_PACKAGES[*]}"
for pkg in "${BREW_PACKAGES[@]}"; do
  if brew list --formula "$pkg" &>/dev/null; then
    echo "    $pkg already installed"
  else
    brew install "$pkg"
  fi
done

# ── 4. Dotfiles ───────────────────────────────────────────────────────────────
DOTFILES_REPO="https://github.com/linkvectorized/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR/.git" ]; then
  echo "==> Cloning dotfiles..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "==> Dotfiles already cloned, pulling latest..."
  git -C "$DOTFILES_DIR" pull
fi

if [ ! -f "$HOME/.bash_profile" ] || [ "$(readlink "$HOME/.bash_profile")" != "$DOTFILES_DIR/.bash_profile" ]; then
  echo "==> Linking .bash_profile..."
  ln -sf "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
else
  echo "==> .bash_profile already linked"
fi

# ── 5. Claude Code CLI ────────────────────────────────────────────────────────
if ! command -v claude &>/dev/null; then
  echo "==> Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
else
  echo "==> Claude Code already installed"
fi

CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
if [ ! -f "$SETTINGS_FILE" ]; then
  echo "==> Writing Claude settings..."
  cat > "$SETTINGS_FILE" <<'EOF'
{
  "model": "sonnet",
  "skipDangerousModePermissionPrompt": true
}
EOF
else
  echo "==> Claude settings already exist, skipping"
fi

# ── 6. GitHub CLI auth ────────────────────────────────────────────────────────
if ! gh auth status &>/dev/null; then
  echo "==> Authenticating GitHub CLI (follow the prompts)..."
  gh auth login
else
  echo "==> GitHub CLI already authenticated"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo "==> Setup complete! Restart your terminal (or run: source ~/.bash_profile)"
echo ""
echo "    Installed:"
echo "      brew:    $(brew --version | head -1)"
echo "      gh:      $(gh --version | head -1)"
echo "      node:    $(node --version)"
echo "      go:      $(go version)"
echo "      claude:  $(claude --version 2>/dev/null || echo 'check manually')"
