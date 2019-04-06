export TERM=xterm-256color

# PATH ALTERATIONS
## Node
PATH="/usr/local/bin:$PATH:./node_modules/.bin";
export EDITOR="code --wait"

export NVM_DIR=$HOME/.nvm
source /usr/local/opt/nvm/nvm.sh
nvm use

#COLORS
RED=$(tput setaf 1);
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
BLUE=$(tput setaf 4);
PINK=$(tput setaf 5);
TEAL=$(tput setaf 6);
WHITE=$(tput setaf 7);

# adds git autocomplete to bash
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

# history size
HISTSIZE=5000
HISTFILESIZE=10000

# alias hub as git (allows for extra fun commands)
eval "$(hub alias -s)"

# alias
# long format with additional seetings
### F = adds special character to indicate useage
### G for color
### l = long list format,
### A = skips `.` & `..`
### h = use M/K/G for size
alias ll='ls -FGlAh'
alias mkdir='mkdir -pv' # p = create dirs missing in path, v=list as they are created
alias cp='cp -iv' # i = interatice, v = verbose
alias ~="cd ~" # go home
alias path='echo -e ${PATH//:/\\n}' #list path with, each directory new lined

# make then cd into directory
mkcd() {
        if [ $# != 1 ]; then
                echo "Usage: mkcd <dir>"
        else
                mkdir -p $1 && cd $1
        fi
}

init_repo() {
  mkcd $1
  git init
  npm init -y
  npx license mit > LICENSE
  npx gitignore node
  npx covgen kwelch0626@gmail.com
}


function git_branch {
  # Shows the current branch if in a git repository
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \(\1\)/';
}
rand() {
  printf $((  $1 *  RANDOM  / 32767   ))
}
rand_element () {
  local -a th=("$@")
  unset th[0]
  printf $'%s\n' "${th[$(($(rand "${#th[*]}")+1))]}"
}

#Default Prompt
PS1="${BLUE}\w${GREEN}\$(git_branch)${WHITE}\n\D{%T} $(rand_element 🔥 🚀 🍕 👻 🐙 )  $ ";
