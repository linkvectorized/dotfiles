#!/usr/bin/env bash
# brian_check.sh — dry run check for brian_script.sh
# Prints what's installed and what's missing without changing anything

PASS="[✓]"
FAIL="[✗]"

echo ""
echo "── Checking brian_script.sh dependencies ──"
echo ""

# 1. Xcode CLT
echo "1. Xcode Command Line Tools"
if xcode-select -p &>/dev/null; then
  echo "   $PASS installed at $(xcode-select -p)"
else
  echo "   $FAIL not installed — brian_script.sh will install it"
fi

echo ""

# 2. Homebrew
echo "2. Homebrew"
if command -v brew &>/dev/null; then
  echo "   $PASS installed — $(brew --version | head -1)"
else
  echo "   $FAIL not installed — brian_script.sh will install it"
fi

echo ""

# 3. Brew packages
echo "3. Brew packages"
BREW_PACKAGES=(gh node go jq git)
for pkg in "${BREW_PACKAGES[@]}"; do
  if command -v "$pkg" &>/dev/null; then
    echo "   $PASS $pkg — $(command -v $pkg)"
  else
    echo "   $FAIL $pkg — not installed"
  fi
done

echo ""

# 4. Dotfiles
echo "4. Dotfiles"
DOTFILES_DIR="$HOME/dotfiles"
if [ -d "$DOTFILES_DIR/.git" ]; then
  echo "   $PASS dotfiles repo exists at $DOTFILES_DIR"
else
  echo "   $FAIL dotfiles repo not found — brian_script.sh will clone it"
fi

if [ -L "$HOME/.bash_profile" ] && [ "$(readlink "$HOME/.bash_profile")" = "$DOTFILES_DIR/.bash_profile" ]; then
  echo "   $PASS .bash_profile symlinked correctly"
elif [ -f "$HOME/.bash_profile" ]; then
  echo "   $FAIL .bash_profile exists but is not symlinked to dotfiles"
else
  echo "   $FAIL .bash_profile not found — brian_script.sh will link it"
fi

echo ""

# 5. Claude Code
echo "5. Claude Code"
if command -v claude &>/dev/null; then
  echo "   $PASS claude installed — $(claude --version 2>/dev/null || echo 'version unknown')"
else
  echo "   $FAIL claude not installed — brian_script.sh will install it"
fi

SETTINGS="$HOME/.claude/settings.json"
if [ -f "$SETTINGS" ]; then
  echo "   $PASS claude settings exist at $SETTINGS"
else
  echo "   $FAIL claude settings not found — brian_script.sh will create them"
fi

echo ""

# 6. GitHub CLI auth
echo "6. GitHub CLI auth"
if command -v gh &>/dev/null && gh auth status &>/dev/null; then
  echo "   $PASS gh authenticated — $(gh auth status 2>&1 | grep 'Logged in' || echo 'logged in')"
else
  echo "   $FAIL gh not authenticated — brian_script.sh will run gh auth login"
fi

echo ""

# 7. Apps
echo "7. Apps"
if [ -d "/Applications/Brave Browser.app" ]; then
  echo "   $PASS Brave Browser installed"
else
  echo "   $FAIL Brave Browser not installed — brian_script.sh will install it"
fi

if [ -d "/Applications/Cursor.app" ]; then
  echo "   $PASS Cursor installed"
else
  echo "   $FAIL Cursor not installed — brian_script.sh will install it"
fi

echo ""
echo "── Done. Run brian_script.sh to install anything marked $FAIL ──"
echo ""
