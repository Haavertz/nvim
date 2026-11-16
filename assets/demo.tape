Output "nvim-demo.gif"

Set Shell "bash"
Set FontFamily "Iosevka, JetBrainsMono Nerd Font"
Set FontSize 18
Set Width 1400
Set Height 820
Set Padding 24
Set Framerate 24
Set TypingSpeed 90ms
Set CursorBlink false
Set WindowBar Colorful
Set BorderRadius 10
Set Margin 0
Set Theme { "name": "wal", "background": "#090707", "foreground": "#d2d1da", "cursor": "#d2d1da", "selection": "#2a2830", "black": "#090707", "brightBlack": "#939298", "red": "#86726F", "brightRed": "#86726F", "green": "#6F7689", "brightGreen": "#6F7689", "yellow": "#897C84", "brightYellow": "#897C84", "blue": "#7A8597", "brightBlue": "#7A8597", "magenta": "#8D8791", "brightMagenta": "#8D8791", "cyan": "#9B9BAE", "brightCyan": "#9B9BAE", "white": "#d2d1da", "brightWhite": "#d2d1da" }

# --- start nvim off-camera -------------------------------------------------
Hide
Type "export PS1='' && clear && nvim"
Enter
Sleep 2.5s
Show

# --- dashboard (alpha) -----------------------------------------------------
Sleep 3s

# --- telescope: find file --------------------------------------------------
Type "f"
Sleep 1.2s
Type "lsp"
Sleep 1.5s
Enter
Sleep 2.5s

# --- scroll through the file -----------------------------------------------
Ctrl+D
Sleep 1s
Ctrl+D
Sleep 1.2s

# --- flash.nvim jump -------------------------------------------------------
Type "slsp"
Sleep 1.8s
Escape
Sleep 0.5s

# --- LSP completion (blink.cmp) --------------------------------------------
Type "gg"
Sleep 0.4s
Type "O"
Type@120ms "vim.api.nvim_buf_set"
Sleep 2.5s
Escape
Escape
Type "u"
Sleep 0.8s

# --- file explorer (fyler) -------------------------------------------------
Type " fe"
Sleep 1.5s
Down 3
Sleep 1.5s
Type " fe"
Sleep 0.8s

# --- live grep -------------------------------------------------------------
Type " fg"
Sleep 1s
Type "vim.keymap.set"
Sleep 2.5s
Escape
Escape
Sleep 0.6s

# --- splits ----------------------------------------------------------------
Type " sv"
Sleep 0.6s
Type " ff"
Sleep 0.8s
Type "keymaps"
Sleep 1s
Enter
Sleep 2.5s

# --- zen mode --------------------------------------------------------------
Type " zz"
Sleep 2.5s
Type " zz"
Sleep 1s

# --- back to the dashboard and quit ----------------------------------------
Type " sc"
Sleep 0.8s
Type "  "
Sleep 2s
Hide
Type ":qa!"
Enter
