" Make vim useful. [
" =======================
set nocompatible
filetype off
" ]

" Default vim. [
" =======================
" Vundle setup.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Git wrapper.
Plugin 'tpope/vim-fugitive'
" Vim script library.
Plugin 'L9'
" Git plugin not hosted on GitHub.
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on
" ]

" Themes. [
" =======================
Plugin 'jordwalke/flatlandia'
colorscheme flatlandia
" ]

" Plugin. [
" =======================
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
" ]

" Config plugin. [
" =======================
" This config auto load NERDTree plugin on start up
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" ]