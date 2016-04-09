if exists('g:bwells_sessions')
  finish
endif

let g:bwells_sessions = 1

let g:sessions_root = '~/.vim/sessions'

function! GetDefaultName()
	return s:getNameFromCWD()
endfunction

function! s:getNameFromCWD()
	return tolower(fnamemodify(getcwd(), ':t'))
endfunction

function! s:getSessionName(session_name)
	if !strlen(a:session_name)
		" defualt to last part of getcwd
		return GetDefaultName()
	else
		return a:session_name
	endif
endfunction

function! s:OpenSession(session_name)
	let session_name = s:getSessionName(a:session_name)
	let filepath = g:sessions_root . '/' . session_name . '.vim'
	let filepath = fnamemodify(filepath, ':p')
	if filereadable(filepath)
		execute 'source ' . filepath
		let g:session_name = session_name
		let g:session_file = filepath
	else
		echo "Session not found: " . filepath
	endif
endfunction

function! s:SaveSession(session_name)
	if !exists('g:session_file')
		let session_name = s:getSessionName(a:session_name)
		let filepath = g:sessions_root . '/' . session_name . '.vim'
		let g:session_file = filepath
	endif
	" echom "Saving session to " . g:session_file
	execute 'mksession! ' . fnameescape(g:session_file)
endfunction

function! s:persistSession()
	if exists('g:session_file')
		call s:SaveSession('')
	endif
endfunction

function! s:SessionList(ArgLead, Cmdline, Cursor)
	if !empty(a:ArgLead)
		let pattern = g:sessions_root . '/' . a:ArgLead . '*.vim'
	else
		let pattern = g:sessions_root . '/' . '*.vim'
	endif

	let filelist = glob(pattern, 0, 1)
	let filelist = map(filelist, "fnamemodify(v:val, ':t:r')")
	return filelist
endfunction

command! -bar -nargs=? -complete=customlist,s:SessionList OpenSession call s:OpenSession(<q-args>)

command! -bar -nargs=? SaveSession call s:SaveSession(<q-args>)

augroup bwells_sessions
  autocmd!
  autocmd BufEnter,VimLeavePre * exe s:persistSession()
  " autocmd User Flags call Hoist('global', 'ObsessionStatus')
augroup END
