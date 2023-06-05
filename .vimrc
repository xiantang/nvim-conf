" leader
" local leader
let mapleader = " "
let maplocalleader = " "

set nu
set rnu
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
set guicursor+=i:ver1
set guicursor+=a:blinkon1
set mouse=a
set clipboard=unnamedplus

" modifiable
set modifiable
set smartcase

set autoread
set splitright
set encoding=utf-8
set termguicolors

" no swap files
set noswapfile
syntax on


set hlsearch
set autoindent
set smartindent
set equalalways
set ignorecase
set sessionoptions="blank"
set hidden
set autoindent


" Pick a different highlighting group by adding this in your vimrc:
"
"   highlight link fuzzyMatch <group>
"
" The "default" only makes the link if it's not already set.
"
highlight default link fuzzyMatch Search

" The components of the command definition:
"
" - complete=dir: tab-completes directories
" - nargs=*:      zero or more arguments (though more than 1 will error out)
" - <q-mods>:     modifiers before the command like `:vertical` or `:tab`, quoted
" - <f-args>:     the space-separated arguments, formatted for a function invocation
"
command! -complete=dir -nargs=* Fuzzy call s:Fuzzy(<q-mods>, <f-args>)

function! s:Fuzzy(mods, dir = '.') abort
  " Open a new buffer, maintaining the given modifiers. So, `:vertical Fuzzy`
  " will get translated to `:vertical new` and `:tab Fuzzy` will trigger
  " `:tab new`. If no modifiers are given, it'll simply be an empty string.
  "
  exe a:mods .. ' new'

  " The glob() function collects all files recursively. Is it too slow?
  " Install ripgrep and replace it with:
  "
  "   systemlist('rg --files ' .. a:dir)
  "
  " Is that too slow? Read up on `:help job_start()`, and the contents can be
  " fetched in an async way.
  "
  let b:all_paths = glob(simplify(a:dir .. '/**/*'), v:false, v:true)

  " A "prompt" buffer is one that only allows editing the final line, turning
  " the buffer into a REPL of sorts. Pressing enter triggers the callback
  " installed with `prompt_setcallback`. The prompt's prefix character is set
  " by `prompt_setprompt`.
  "
  set buftype=prompt
  call prompt_setcallback(bufnr(), function('s:TextEntered'))
  call prompt_setprompt(bufnr(), "> ")

  " We could also update this in `s:UpdateBuffer`. Removing the limit would
  " allow us to see how many results we've got and if we use `job_start` to
  " load the files in an async way, we could add a loading indicator.
  "
  let &l:statusline = "[Fuzzy: " .. a:dir .. " ("..len(b:all_paths).." files)]"

  startinsert

  " Every time the user types in insert mode, the buffer is updated with the
  " contents filtered by the final line.
  "
  autocmd TextChangedI,TextChangedP <buffer> call s:UpdateBuffer()
endfunction

function! s:TextEntered(_text) abort
  if line('$') <= 2
    " The line at the end of the buffer is the second one if there's only one
    " match + the prompt line. Lower than that and we don't have a match
    quit
  else
    " Line 1 is the top line, the highest-scoring match
    exe 'edit ' .. getline(1)
  endif
endfunc

function! s:UpdateBuffer() abort
  " Clear out the entire buffer (except for the last line) and all of its
  " syntax highlighting
  "
  if line('$') > 1
    1,$-1delete _
  endif
  syn clear

  " The final line starts with the prompt we set, `> `, let's remove it and
  " all spaces, just so I can type "tag auto util" instead of "tagautoutil"
  "
  let query = matchstr(getline('$'), '^> \zs.*')
  let query = substitute(query, '\s\+', '', 'g')

  let results = []

  " The `matchfuzzypos` function returns three lists containing:
  "
  " - the matches, sorted by score
  " - the character indices of the matches
  " - the scores of the matches, unused here
  "
  " The 'limit' option can be removed or replaced with a large constant to
  " improve the quality of matches. You can then loop through the first
  " screen-size results:
  "
  "   for i in range(min([len(paths), winheight(0) - 1]))
  "
  " But if you get a full buffer of results, maybe it makes sense to keep
  " typing?
  "
  let [paths, char_positions, _scores] =
        \ matchfuzzypos(b:all_paths, query, { 'limit': winheight(0) - 1, 'matchseq': v:true })

  for i in range(len(paths))
    let path = paths[i]

    " Append this path just before the final line of the buffer
    call append(line('$') - 1, path)

    for char_position in char_positions[i]
      " The regex /\%l42\%c13./ means:
      "
      " - any character ('.')
      " - on line 42 ('\%l')
      " - on column 13 ('\%c')
      "
      exe 'syn match fuzzyMatch /\%' .. (line('$') - 1) .. 'l\%' .. char_position .. 'c./'
    endfor
  endfor

  " As we're typing, the buffer will become "modified", but since it's just
  " used for UI, we don't want it to be shown:
  "
  set nomodified

  " After every change, jump back to the last line and scroll so that the last
  " line is the last visible line.
  "
  normal! Gzb

  " Always append after updating. We could be smarter here to support editing
  " in the middle of the query, but that seems to me to be a rare case.
  "
  startinsert!
endfunction
