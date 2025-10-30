# Emerge Monitor - Visual Examples

## Main Screen Example

```
╔════════════════════════════════════════════════════════════════╗
║            Gentoo Emerge Monitor v1.0                          ║
╚════════════════════════════════════════════════════════════════╝

Current Time:     2025-10-30 14:32:15
Script Runtime:   00:15:32
Emerge Runtime:   00:42:18
Refresh Mode:     Auto (5 sec)

════════════════════ Emerge Status ═══════════════════

Currently merging 3 out of 7

 * dev-lang/python-3.11.6

       current merge time: 5 minutes and 23 seconds.
       ETA: 8 minutes and 14 seconds.

 * app-editors/vim-9.0.2116

       in queue, ETA: 2 minutes.

 * sys-devel/gcc-13.2.1_p20230826

       in queue, ETA: 45 minutes.

══════════════════════════════════════════════════════

Controls:
  s - Toggle screensaver cycle
  r - Manual refresh (when auto-refresh is off)
  a - Toggle auto-refresh
  + - Increase refresh interval
  - - Decrease refresh interval
  q - Quit

```

## Screensaver Mode - pipes.sh

```
(Animated colorful pipes flowing across the terminal)

  ╭─╮
  │ ╰───╮
  │     │
  ╰─╮   │
    │   ╰──────╮
    │          │
    ╰──╮       │
       │   ╭───╯
       ╰───╯

[Press 's' to cycle to next screensaver, 'r' to return to emerge status]
```

## Screensaver Mode - cmatrix

```
(Green cascading Matrix-style characters)

ﾊ ﾓ ﾘ ｦ ｱ ﾀ ｶ ｼ ｷ ｽ ﾁ ﾆ ｻ ﾜ ﾎ ﾃ ﾂ
ﾒ ｳ ﾉ ｵ ﾔ ﾏ ｹ ﾑ ｺ ｴ ﾈ ﾐ ｿ ﾗ ｾ ﾙ ﾚ
ｸ ﾕ ﾛ ﾖ ﾄ ﾅ ｦ ｱ ﾘ ﾇ ﾙ ｦ ﾀ ｶ ｼ ｷ
ﾓ ﾘ ｦ ｱ ﾀ ｶ ｼ ｷ ｽ ﾁ ﾆ ｻ ﾜ ﾎ ﾃ ﾂ

[Press 's' for next screensaver, 'r' to return]
```

## Screensaver Mode - hollywood

```
(Multiple terminal windows showing "hacking" activities)

┌─ SYSTEM LOGS ──────────┐  ┌─ NETWORK SCAN ────────┐
│ [OK] Service started   │  │ 192.168.1.1 - ACTIVE  │
│ [OK] Connection estab. │  │ 192.168.1.2 - ACTIVE  │
│ [WARN] High CPU usage  │  │ Scanning ports...     │
└────────────────────────┘  └───────────────────────┘

┌─ CODE COMPILATION ─────────────────────────────────┐
│ gcc -O2 -Wall -Werror main.c -o main               │
│ Compiling... [████████████████████░░] 85%          │
└─────────────────────────────────────────────────────┘

[Press 's' for next, 'r' to return]
```

## Screensaver Mode - asciiquarium

```
(ASCII art aquarium with animated fish)

                    ~~~~~~~~~~~~~~~~~~~~~~~~~
                 ><(((º>     ><(((º>    ><(((º>
    
    ~~~~~                              ><(((°>
                       ><(((º>
 ><(((º>                               ~~~~~~
                                    
           ><(((°>        ><(((º>
    
    ___                                    ___
   (   )                                  (   )
    ~~~                                    ~~~

[Press 's' to cycle, 'r' to return to emerge status]
```

## No Emerge Process Running

```
╔════════════════════════════════════════════════════════════════╗
║            Gentoo Emerge Monitor v1.0                          ║
╚════════════════════════════════════════════════════════════════╝

Current Time:     2025-10-30 14:45:30
Script Runtime:   00:03:15
Refresh Mode:     Auto (5 sec)

════════════════════ Emerge Status ═══════════════════

No emerge process currently running.

══════════════════════════════════════════════════════

Controls:
  s - Toggle screensaver cycle
  r - Manual refresh (when auto-refresh is off)
  a - Toggle auto-refresh
  + - Increase refresh interval
  - - Decrease refresh interval
  q - Quit

```

## Manual Refresh Mode

```
╔════════════════════════════════════════════════════════════════╗
║            Gentoo Emerge Monitor v1.0                          ║
╚════════════════════════════════════════════════════════════════╝

Current Time:     2025-10-30 14:50:45
Script Runtime:   00:08:30
Emerge Runtime:   00:25:12
Refresh Mode:     Manual

════════════════════ Emerge Status ═══════════════════

Currently merging 1 out of 1

 * sys-kernel/gentoo-sources-6.6.3

       current merge time: 25 minutes and 12 seconds.
       ETA: 5 minutes.

══════════════════════════════════════════════════════

Controls:
  s - Toggle screensaver cycle
  r - Manual refresh (when auto-refresh is off)  ← Press to refresh!
  a - Toggle auto-refresh
  + - Increase refresh interval
  - - Decrease refresh interval
  q - Quit

```

## Custom Refresh Interval

```
╔════════════════════════════════════════════════════════════════╗
║            Gentoo Emerge Monitor v1.0                          ║
╚════════════════════════════════════════════════════════════════╝

Current Time:     2025-10-30 15:00:00
Script Runtime:   00:17:45
Emerge Runtime:   00:34:27
Refresh Mode:     Auto (15 sec)  ← Adjusted to 15 seconds

════════════════════ Emerge Status ═══════════════════

[Emerge status content...]

══════════════════════════════════════════════════════

Controls:
  s - Toggle screensaver cycle
  r - Manual refresh (when auto-refresh is off)
  a - Toggle auto-refresh
  + - Increase refresh interval  ← Pressed multiple times
  - - Decrease refresh interval
  q - Quit

```

## Usage Flow Examples

### Example 1: Basic Monitoring
```
1. Start script → See main screen with emerge status
2. Wait → Screen auto-refreshes every 5 seconds
3. Press 'q' → Exit when done
```

### Example 2: With Screensaver
```
1. Start script → See main screen
2. Press 's' → Pipes.sh screensaver starts
3. Wait → Enjoy the animation
4. Press 's' → Switch to cmatrix
5. Press 's' → Switch to hollywood
6. Press 's' → Switch to asciiquarium
7. Press 's' → Back to none (main screen)
8. Press 'r' → Check emerge progress anytime
```

### Example 3: Manual Mode for Slow Connection
```
1. Start script → See main screen
2. Press 'a' → Switch to manual refresh mode
3. Work on other tasks
4. Press 'r' → Check progress when you want
5. Press 'r' → Check again later
6. Repeat as needed
```

### Example 4: Adjust Refresh Rate
```
1. Start script → Default 5 second refresh
2. Press '+' three times → Refresh every 8 seconds
3. Press '-' twice → Refresh every 6 seconds
4. Find your preferred rate
```

## Color Coding

The script uses colors to enhance readability:

- **Cyan** - Headers and borders
- **Green** - Controls and success messages
- **Yellow** - Warnings and status info
- **Magenta** - Section dividers
- **Red** - Errors (rare)
- **Bold** - Important labels

## Terminal Compatibility

Works best with:
- ✅ xterm
- ✅ gnome-terminal
- ✅ konsole
- ✅ alacritty
- ✅ kitty
- ✅ terminator
- ✅ tmux
- ✅ screen
- ✅ SSH terminals

Minimum requirements:
- 80 columns width
- 24 rows height (for best screensaver experience)
- ANSI color support
- UTF-8 encoding

## Notes

- All animations shown are simplified text representations
- Actual screensavers are fully animated in the terminal
- Colors and formatting depend on your terminal settings
- Timers update in real-time
- All controls respond instantly to keypresses
