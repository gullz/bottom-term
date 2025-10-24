# bottom-term

A simple Vim plugin for toggling a terminal window at the bottom of your editor.

## Features

- Toggle terminal with a single keypress (F2) or command (`:ToggleBottomTerm`)
- Single terminal instance - only one terminal exists at any time, no duplicates
- Session persistence - closing the terminal keeps your shell session alive; reopening returns to the same session
- Smart terminal detection - reuses existing terminal buffer
- Automatic state synchronization - handles manual terminal closure
- No confirmation prompts - terminal closes immediately without asking
- Safe window operations with error handling
- Terminal stays at the bottom with 15 lines height
- Auto-cleanup on exit - terminal doesn't block `:qa` or `:q` commands

## Installation

Using [Pathogen](https://github.com/tpope/vim-pathogen):
```bash
cd ~/.vim/bundle
git clone https://github.com/pulbhaba/bottom-term.git
```

Using [Vundle](https://github.com/VundleVim/Vundle.vim), add to your `.vimrc`:
```vim
Plugin 'pulbhaba/bottom-term'
```

## Usage

- Press `F2` to toggle the terminal on/off
- Or use `:ToggleBottomTerm` command
- Use `:RunBottomTerm` to explicitly open the terminal
- Use `:CloseBottomTerm` to explicitly close the terminal

## Configuration

### Auto-open on startup

Add this to your `.vimrc` to automatically open the terminal when Vim starts:

```vim
let g:bottom_term_auto_open = 1
```

## Requirements

- Vim 8.1+ with terminal support, or Neovim

## Documentation

Run `:help bottom-term` for detailed documentation.
