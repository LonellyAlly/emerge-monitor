# Emerge Monitor - Quick Start Guide

## Installation (3 Steps)

### 1. Install genlop (Required)
```bash
sudo emerge app-portage/genlop
```

### 2. Make script executable
```bash
chmod +x emerge-monitor.sh
```

### 3. Run it!
```bash
./emerge-monitor.sh
```

## Optional: Install Screensavers

```bash
# Install all screensavers at once
sudo emerge app-misc/pipes app-misc/cmatrix app-misc/hollywood games-misc/asciiquarium
```

Or install individually:
```bash
sudo emerge app-misc/pipes        # Animated pipes
sudo emerge app-misc/cmatrix      # Matrix effect
sudo emerge app-misc/hollywood    # Hacker terminal
sudo emerge games-misc/asciiquarium  # ASCII aquarium
```

## Quick Controls Reference

| Key | Action |
|-----|--------|
| **s** | Toggle screensaver (cycles through all) |
| **r** | Refresh / Exit screensaver |
| **a** | Toggle auto-refresh on/off |
| **+** | Increase refresh interval |
| **-** | Decrease refresh interval |
| **q** | Quit |

## Optional: Skip Password Prompt

To avoid entering sudo password each time:

```bash
sudo visudo
```

Add this line (replace `yourusername`):
```
yourusername ALL=(ALL) NOPASSWD: /usr/bin/genlop
```

Save and exit (ESC, :wq in vi/vim)

## Usage Examples

### Basic monitoring:
```bash
# Terminal 1
sudo emerge --update @world

# Terminal 2
./emerge-monitor.sh
```

### With system-wide install:
```bash
# Install to PATH
sudo cp emerge-monitor.sh /usr/local/bin/emerge-monitor

# Run from anywhere
emerge-monitor
```

## Troubleshooting Quick Fixes

**"genlop not found"** → `sudo emerge app-portage/genlop`

**"No emerge running"** → Start an emerge in another terminal

**Screensaver not working** → Press 's' to cycle to next one, or install missing screensaver

**Screen not refreshing** → Press 'a' to toggle auto-refresh

## Need More Help?

Read the full documentation:
- README.md - Complete feature guide
- index.html - Web-based documentation with examples

Enjoy monitoring your emerges! 🚀
