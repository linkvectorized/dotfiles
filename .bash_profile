PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# Custom prompt (includes git branch name)
dark_gray='\[\e[2;37m\]'
italic_red='\[\e[3;31m\]'
italic_purple='\[\e[3;35m\]'
dark_green='\[\e[1;32m\]'
turquoise='\[\e[0;36m\]'
profile="\[\$AWS_PROFILE\]"
ENDC='\[\e[0m\]'  # End Color

# Aliases
alias pvenv='virtualenv -p /usr/local/bin/python3 venv'
alias ae='source venv/bin/activate'
alias ll='ls -Galoh'
alias eip='curl ipecho.net/plain ; echo'
alias hd='hexdump -Cv'
alias jvless='jq -C . | less -R'
alias ls='ls -G'
alias md5sum='openssl md5'
alias sha1='openssl sha1'
alias ip='ifconfig | grep -Eo "[0-9]*\..*"'
alias histogram="sort | uniq -c | sort -nr"
alias cl="clear"
