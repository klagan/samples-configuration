apt update
apt -y upgrade
apt -y install vim lynx curl glances apt-listbugs
apt autoremove

# install pi apps appstore
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash

# set up swap space (if not already configured)
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# optimize system settings
sysctl -w vm.swappiness=10
sysctl -w vm.vfs_cache_pressure=50

# verify installations
systemctl list-units --type=service --state=running

# set up defaults
echo "alias df='df -aTh'" > ~/.zshrc
echo "alias ls='ls -l --color=auto'" >> ~/.zshrc

cat > ~/.zshrc << EOF
alias df='df -aTh
alias ls='ls -l --color=auto
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
