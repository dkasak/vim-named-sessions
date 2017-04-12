# vim-named-sessions
Session management via names rather than paths and files

## Inspired by vim-session and vim-obsession

My workflow before switching to vim full time came from Textmate and
SublimeText's concepts of projects. I wanted a solution that restored open
files and their equivalent of CWD. I also wanted to be able to easily switch
between my projects within the same vim instance. This is where vim's
`:mksession` really falls down.

Tim Pope's obession.vim does a great job of fixing most of Vim's default
session management, but stores its session files within each project. This is
adversarial to easy searching of available sessions to switch between. The
provided command also doesn't allow for easy in place switching of the active
session.

vim-session does a great job of providing convenient commands based on session
names, but has some show stopper annoying behaviors in my opinion and it seems
to be a dead project.

vim-named-sessions provides

* Session management based on a name rather than a filename or path
* In place session switching with tab completion of names
* Automatically saves sessions once a session is activated
* Automatically restores a CWD's matching session if vim is started with no
  arguments
* If inside a tmux session, uses the name of the tmux session as the default
  session name
* Never prompts you or bothers you about anything

## Installation
---------------
#### Vundle
```
Plugin 'bwells/vim-named-sessions'
```

#### vim-plug
```
Plug 'bwells/vim-named-sessions'
```

I strongly suggest adding `set sessionoptions-=options` in your vimrc.
`options` are known to interact badly with session restoration. See `:help
sessionoptions` for all available options.

## Commands
-----------

`:SaveSession`

Saves the existing session or creates a new one. If no session name is provided
then the output of `GetDefaultName()` is used. The default for this is the name
of the current working directory. All session names are converted to lowercase
for ease of tab completion typing. Session files are saved to `g:sessions_root`

`:OpenSession`

Opens a session of the provided name. Tab completion of available session names
is provided.

`:StopSession`

Stops session tracking. The session will still be auto resumed the next time
vim started with no arguments in the session's CWD.

## Options
----------

`g:sessions_root`

Location session files will be saved. Defaults to `~/.vim/sessions`

`GetDefaultName()`

Default implementation uses the name of vim's current working directory to pick
a session name.  Override to use any naming scheme you'd like. Perhaps the git
repo name?
