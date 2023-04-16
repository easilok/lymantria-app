let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/playground/syncthing/vue/lymantria-app
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +36 src/main.ts
badd +48 src/components/card/ButterflyCard.vue
badd +105 src/views/MonitoringView.vue
badd +1 src/components/monitoring/MonitoringEnvironment.vue
badd +76 src/components/monitoring/MonitoringStats.vue
badd +6 src/components/map/MapContainer.vue
badd +5 src/components/monitoring/MonitoringMap.vue
badd +5 src/components/map/MapContainer2.vue
badd +0 fugitive:///home/luis/projects/playground/syncthing/vue/lymantria-app/.git//
argglobal
%argdel
edit src/views/MonitoringView.vue
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 30 + 32) / 64)
exe 'vert 1resize ' . ((&columns * 119 + 119) / 239)
exe '2resize ' . ((&lines * 30 + 32) / 64)
exe 'vert 2resize ' . ((&columns * 119 + 119) / 239)
exe '3resize ' . ((&lines * 30 + 32) / 64)
argglobal
balt src/components/card/ButterflyCard.vue
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=200
setlocal fml=1
setlocal fdn=20
setlocal fen
1
normal! zo
7
normal! zo
18
normal! zo
19
normal! zo
48
normal! zo
63
normal! zo
67
normal! zo
67
normal! zo
68
normal! zo
75
normal! zo
75
normal! zo
77
normal! zo
85
normal! zo
86
normal! zo
86
normal! zo
90
normal! zo
100
normal! zo
104
normal! zo
let s:l = 105 - ((24 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 105
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("src/components/map/MapContainer2.vue", ":p")) | buffer src/components/map/MapContainer2.vue | else | edit src/components/map/MapContainer2.vue | endif
if &buftype ==# 'terminal'
  silent file src/components/map/MapContainer2.vue
endif
balt src/components/monitoring/MonitoringMap.vue
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=200
setlocal fml=1
setlocal fdn=20
setlocal fen
1
normal! zo
2
normal! zo
9
normal! zo
10
normal! zo
11
normal! zo
20
normal! zo
21
normal! zo
22
normal! zo
29
normal! zo
32
normal! zo
49
normal! zo
let s:l = 5 - ((4 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 023|
wincmd w
argglobal
if bufexists(fnamemodify("fugitive:///home/luis/projects/playground/syncthing/vue/lymantria-app/.git//", ":p")) | buffer fugitive:///home/luis/projects/playground/syncthing/vue/lymantria-app/.git// | else | edit fugitive:///home/luis/projects/playground/syncthing/vue/lymantria-app/.git// | endif
if &buftype ==# 'terminal'
  silent file fugitive:///home/luis/projects/playground/syncthing/vue/lymantria-app/.git//
endif
balt src/components/monitoring/MonitoringMap.vue
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=200
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 30 + 32) / 64)
exe 'vert 1resize ' . ((&columns * 119 + 119) / 239)
exe '2resize ' . ((&lines * 30 + 32) / 64)
exe 'vert 2resize ' . ((&columns * 119 + 119) / 239)
exe '3resize ' . ((&lines * 30 + 32) / 64)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
