# This script turns the shell to red when you have root access
# If id command returns zero, you’ve root access.
if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
  PS1="\\[$(tput setaf 3)\\]{MACHINE-FUNCTION}\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\] "
else # normal
  PS1="[\\u@\\h:\\w] $"
fi

