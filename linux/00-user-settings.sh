rename_if_exists() {
    local FILE_TO_CHECK="$1"

    # Check if the file exists and is a regular file (-f flag).
    if [ -f "$FILE_TO_CHECK" ]; then
        local DATETIME=$(date +"%Y-%m-%d_%H-%M-%S")

        mv "$FILE_TO_CHECK" "${FILE_TO_CHECK}-${DATETIME}.old"
        echo "File '$FILE_TO_CHECK' found and renamed to '${FILE_TO_CHECK}-${DATETIME}.old'."

    else
        # File does not exist.
        echo "File '$FILE_TO_CHECK' not found. No action taken."
    fi
}

echo "--- backup .bash_aliases ---"
rename_if_exists ~/.bash_aliases
touch ~/.bash_aliases
echo ""

echo "--- backup .zshrc ---"
rename_if_exists ~/.zshrc
touch ~/.zshrc
echo ""

echo "--- backup .vimrc ---"
rename_if_exists ~/.vimrc
touch ~/.vimrc
echo ""

cat > ~/.zshrc << EOF
alias df='df -aTh'
alias ls='ls -hlpG --color=auto'
EOF

cat > ~/.bash_aliases << EOF
alias df='df -aTh'
alias ls='ls -hlpG --color=auto'
# raspberry pi specific
# alias pihealth='vcgencmd measure_volts core && vcgencmd get_throttled && vcgencmd measure_temp'
# alias pimodel='cat /proc/device-tree/model'
EOF

cat > ~/.vimrc << EOF
" Add numbers to each line on the left-hand side.
set number

" Turn syntax highlighting on.
syntax on

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10
" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000
EOF

function bigfolders() {
    local target_dir=${1:-/}
    local num_lines=${2:-10}
    sudo du -sh "$target_dir"/* | sort -rh | head -n "$num_lines"
}

function kctx () {
    kubectl config set-context --current --namespace=${1:-default}
	echo "Current namespace --> $(kubectl config get-contexts | grep "*" | awk '{print $NF}')"
}

function kns () {
  if [ -z "$1" ]; then
    echo "Error: Missing parameter. Please provide a namespace name."
    return 1
  fi
  kubectl create namespace ${1} --dry-run=client -o yaml > ${1}.yaml
}

  function kdep () {
      if [ -z "$1" ]; then
          echo "Error: Missing parameter. Please provide a deployment name: kdep <deployment name> <image name>"
          return 1
      fi
 
      if [ -z "$2" ]; then
          echo "Error: Missing parameter. Please provide an image name: kdep <deployment name> <image name>"
          return 1
      fi
 
      kubectl create deployment ${1} \
          --image=${2} \
          --dry-run=client -o yaml > ${1}.yaml
  }

function kpods() {
    if [ -z "$1" ]; then
        echo "Error: Missing parameter. Please provide a node name."
        return 1
    fi

    kubectl get pods --all-namespaces --field-selector spec.nodeName=${1}
}

source ~/.bashrc
