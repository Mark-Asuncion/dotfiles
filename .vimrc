let mapleader=" "
noremap <A-a> <Esc>
inoremap <A-a> <Esc>
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>y "+y
noremap <leader>Y "+Y
nnoremap <leader>ay :%y+
" vnoremap p "0p
" vnoremap P "0P
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz
set nohlsearch
set scrolloff=50
set ignorecase
set smartcase
nnoremap Y y$

" ** For Visual Studio VsVim **
" nnoremap <leader>cr :vsc Refactor.Rename<CR>
" nnoremap gcc :vsc Edit.ToggleLineComment<CR>
" vnoremap gc :vsc Edit.ToggleLineComment<CR>
" nnoremap gr :vsc Edit.FindAllReferences<CR>
" nnoremap L :vsc Window.NextTab<CR>
" nnoremap H :vsc Window.PreviousTab<CR>
" " nnoremap gd :vsc Edit.GoToDefinition<CR>
" nnoremap <leader>w :vsc Window.Close<CR>
" nnoremap <leader>W :vsc Window.CloseAllDocuments<CR>
" nnoremap <leader>ff :vsc Edit.GoToFile<CR>
" noremap <leader>/ :vsc Edit.Find<CR>
" nnoremap ]e :vsc Edit.GoToNextIssueinFile<CR>
" nnoremap [e :vsc Edit.GoToPreviousIssueinFile<CR>
