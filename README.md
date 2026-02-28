# dotfiles

![dotfiles Banner](banner.svg)

> Your terminal should feel like yours.

Personal shell config for macOS. Nothing fancy — just aliases, colors, and PATH exports that make the terminal less annoying to live in.

---

## What's in here

### `.bash_profile`

**Prompt** — colored, shows user, host, and current directory at a glance:
```
15:32-vectorious@links-Mac-mini:~$
```

**Aliases**
```bash
ll          # ls with details, colors, human sizes
ae          # activate python venv (source venv/bin/activate)
cl          # clear
eip         # show your public IP
ip          # show local IP
hd          # hexdump
jvless      # pipe JSON through jq with color into less
md5sum      # openssl md5
sha1        # openssl sha1
histogram   # sort | uniq -c | sort -nr
```

**PATH exports**
```bash
/opt/homebrew/bin       # Homebrew
/opt/homebrew/opt/postgresql@17/bin
$GOPATH/bin             # Go binaries
```

---

## Install

```bash
git clone https://github.com/linkvectorized/dotfiles.git ~/dotfiles
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
source ~/.bash_profile
```

Or just use the [mac-mini-setup-claude](https://github.com/linkvectorized/mac-mini-setup-claude) script which does it automatically.

---

*Stay curious. Question narratives. Build cool things.*
