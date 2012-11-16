This is a repository containing useful configurations for programs I use.


vim python instructions here:

http://rawpackets.com/2011/10/16/configuring-vim-as-a-python-ide/


Configuring VIM as a (Python) IDE
by Justin Heath on October 16, 2011
While this is slanted towards configuring Vim for Python development this setup minus a couple of Python specific plugins (pep8, pydoc and pyflakes) would work well for any language.

This setup was influenced by Turning Vim into a modern Python IDE.

Vim Plugins
First of all, here is the list of Vim plugins we’ll be working with …

Autoclose
AutoClose automatically (and correctly) closes brackets, parenthesis, curly braces, single and double quotes.

Color-Sampler-Pack
Color-Sampler-Pack contains the top 100 rated color schemes on vim.sf.net.

Gundo
Gundo is a visual history browser.

Lusty
Lusty includes the LustyExplorer and LustyJuggler plugins for Vim which provide easy to use file and buffer management.

pathogen
pathogen allows plugins to be installed and managed within their own private directories.

pep8
pep8 checks your Python code against some of the style conventions in PEP 8.

pydoc
pydoc integrates viewing and searching Python documentation.

pyflakes
pyflakes highlights common Python errors like misspelling a variable name on the fly. It also warns about unused imports, redefined functions, etc.

ScrollColors
ScrollColors is a colorscheme Scroller/Chooser/Browser.

snipMate
snipmate provides tab completion for often-typed text.

SuperTab
SuperTab provides a tab completion for a variety of tasks.

virtualenv
virtualenv sets Vim paths correctly when working with virtualenvs, allows for activating and deactivating within a Vim session.

Dependencies
pyflakes
The only plugin that requires an external dependency is pyflakes. Let’s take care of that first.

1
sudo yum install pyflakes
Alternatively, you could install via pip.

1
sudo pip install pyflakes
git
We are going to manage our Vim modules with git. This allows for easy updating, rollback etc. of Vim plugins. Additionally, most Vim plugins are directly avaialable via github. See the vim-scripts page at github.

1
sudo yum install git
Repo Preperation
Create plugin directories.
1
cd $HOME
2
mkdir -p .vim/{autoload,bundle}
Initialize repo.
1
cd .vim
2
git init
Install plugins as submodules to the repo.
01
git submodule add https://github.com/andrewle/vim-autoclose.git bundle/vim-autoclose
02
git submodule add https://github.com/vim-scripts/Color-Sampler-Pack.git bundle/color-sampler-pack
03
git submodule add https://github.com/sjl/gundo.vim.git bundle/gundo
04
git submodule add https://github.com/sjbach/lusty.git bundle/lusty
05
git submodule add https://github.com/cburroughs/pep8.git bundle/pep8
06
git submodule add https://github.com/vim-scripts/pydoc.vim.git bundle/pydoc
07
git submodule add https://github.com/tpope/vim-pathogen.git bundle/pathogen
08
git submodule add https://github.com/vim-scripts/ScrollColors.git bundle/scrollColors
09
git submodule add https://github.com/ervandew/supertab.git bundle/supertab
10
git submodule add https://github.com/jmcantrell/vim-virtualenv.git bundle/vim-virtualenv
11
git submodule init
12
git submodule update
13
git submodule foreach git submodule init
14
git submodule foreach git submodule update
Create symlink in order to autoload pathogen.
1
ln -s '../bundle/pathogen/autoload/pathogen.vim' autoload/pathogen.vim
2
git add autoload
Move vimrc under repo and symlink it under home.
1
mv $HOME/.vimrc .
2
ln -s './.vim/.vimrc' $HOME/.vimrc
3
git add .vimrc
Commit changes to repo.
1
git commit -m "Initial commit."
vimrc file
01
" pathogen
02
let g:pathogen_disabled = [ 'pathogen' ]    " don't load self
03
call pathogen#infect()                      " load everyhting else
04
call pathogen#helptags()                    " load plugin help files
05
 
 06
 " code folding
 07
 set foldmethod=indent
 08
 set foldlevel=2
 09
 set foldnestmax=4
 10
  
  11
  " indentation
  12
  set autoindent
  13
  set softtabstop=4 shiftwidth=4 expandtab
  14
   
   15
   " visual
   16
   highlight Normal ctermbg=black
   17
   set background=dark
   18
   set cursorline
   19
   set t_Co=256
   20
    
    21
    " syntax highlighting
    22
    syntax on
    23
    filetype on                 " enables filetype detection
    24
    filetype plugin indent on   " enables filetype specific plugins
    25
     
     26
     " colorpack
     27
     colorscheme vibrantink
     28
      
      29
      " gundo
      30
      nnoremap <F5> :GundoToggle<CR>
      31
       
       32
       " lusty
       33
       set hidden
       34
        
        35
        " pep8
        36
        let g:pep8_map='<leader>8'
        37
         
         38
         " supertab
         39
         au FileType python set omnifunc=pythoncomplete#Complete
         40
         let g:SuperTabDefaultCompletionType = "context"
         41
         set completeopt=menuone,longest,preview
         bashrc
         Additionally, I suggest making the following changes to .bashrc
         1
         export EDITOR=/usr/bin/vim
         Reference
         
         Autoclose
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/vim-autoclose/README
         bundle/vim-autoclose/plugin/autoclose.vim
         
         
         Color-Sampler-Pack
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/Color-Sampler-Pack/README
         bundle/Color-Sampler-Pack/plugin/color_sample_pack.vim
         
         
         Gundo
         Links:
         main page
         vim.org page
         github page
         
         Reference Files:
         bundle/gundo/README.markdown
         bundle/gundo/plugin/gundo.vim
         
         Help:
         :help gundo
         
         
         Lusty
         github page
         
         LustyExplorer
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/lusty/doc/explorer-vim.writeup
         bundle/lusty/plugin/lusty-explorer.vim
         
         
         LustyJuggler
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/lusty/doc/juggler-vim.writeup
         bundle/lusty/plugin/lusty-juggler.vim
         
         
         pathogen
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/pathogen/README.markdown
         autoload/pathogen.vim
         
         
         pep8
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/pep8/README.rst
         bundle/pep8/pep8.py
         
         
         pydoc
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/pydoc/README
         bundle/pydoc/ftplugin/python_pydoc.vim
         
         
         pyflakes
         Notes:
         This depends on the external pyflakes Python module. Install via yum or pip.
         
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/pyflakes-pathogen/README.rst
         bundle/pyflakes-pathogen/ftplugin/python/pyflakes.vim
         
         See Also:
         :help quickfix
         
         
         ScrollColors
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/ScrollColors/README
         bundle/ScrollColors/plugin/ScrollColor.vim
         
         
         snipMate
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/snipmate/README.markdown
         bundle/snipmate/plugin/snipMate.vim
         
         Help:
         :help snipMate
         
         
         SuperTab
         Links:
         vim.org page
         github
         
         Reference Files:
         bundle/supertab/plugin/supertab.vim
         
         Help:
         :help supertab
         
         
         virtualenv
         Links:
         vim.org page
         github page
         
         Reference Files:
         bundle/vim-virtualenv/README.mkd
         bundle/vim-virtualenv/plugin/virtualenv.vim
         
         Help:
         : help virtualenv
         
         Share this:
         "
