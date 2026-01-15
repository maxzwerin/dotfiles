I'm in too deep...
---
Main goals:
- [x] Fast
- [x] Easy to maintain
- [x] Minimized bloat
- [x] Actually usable

---

#### Editor -- `neovim`
*pretty minimal setup, only a few plugins needed. there are many many binds, these are a few great ones:*

**Elevated Binds**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| <leader>w       | Write               |
| <leader>q       | Quit                |
| <leader>Q       | Write + quit        |
| <leader>e       | File browser        |
| <C-u> / <C-d>   | Centered up / down  |
| n / N           | Centered find       |
| <leader>n       | NORMMMM             |
+-----------------+---------------------+
```

**Search**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| <leader>f       | Telescope           |
| <leader>g       | Live Grep           |
| <leader>/       | Mash                |
+-----------------+---------------------+
```

**Tabs** *- tmux compatible*
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| <leader>t       | New tab             |
| <leader>x       | Close tab           |
| Ctrl + h/j/k/l  | Navigate panes      |
+-----------------+---------------------+
```

---

#### **Shell --** `zsh`
*it just works. nothing too fancy*

**Some Aliasing**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| ..              | cd ..               |
| ta              | tmux attach         |
| v               | nvim                |
| blink           | Run blink.sh script |
+-----------------+---------------------+
```

---

#### Terminal -- `wezterm / kitty`
*Almost identical, kitty works better with hyprland*

**Good Kitty Bind**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| Ctrl Shift =/-  | +/- font size       |
+-----------------+---------------------+
```
---

#### Terminal Muliplexer -- `tmux`
*hella customized to play nice with neovim. no plugins needed*

**Pane Navigation**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| Alt + h         | Split vertically    |
| Alt + v         | Split horizontally  |
| Alt + x         | Kill current pane   |
| Ctrl + h/j/k/l  | Navigate panes      |
+-----------------+---------------------+
```

**Window Management**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| prefix + c      | Create new window   |
| Alt + 1-9       | Jump to window 1-9  |
+-----------------+---------------------+
```

**Copy Mode**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| prefix + [      | Enter copy mode     |
| Shift + v       | Start selection     |
| y               | Copy selection      |
| q               | Exit copy mode      |
+-----------------+---------------------+
```

---

#### **Window Manager --** Hyprland

*I'm tempted to try Niri but want to hold out a little longer.*

**Main Binds**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| mod + RETURN    | Open terminal       |
| mod + SPACE     | Open Wofi           |
| mod + B         | Open browser        |
| mod + C         | Kill current app    |
+-----------------+---------------------+
```
**Window Management**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| mod + h/j/k/l   | Move focus          |
| mod ALT h/j/k/l | Move window         |
+-----------------+---------------------+
```

**Workspace Management**
```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| mod + 1-9       | Switch workspaces   |
| mod SHIFT 1-9   | Window to workspace |
+-----------------+---------------------+
```
**Other QOL Fixes**
```
input  {
    repeat_rate = 35
    repeat_delay = 200
}
```

---

#### App Launcher -- `Wofi`

*lightweight app launcher used with hyprland*

```
+-----------------+---------------------+
| Bind            | Action              |
+-----------------+---------------------+
| Ctrl + j/k      | Vim-esq search      |
+-----------------+---------------------+
```
---
