# Emerge Monitor 🚀

A feature-rich, interactive monitoring tool for Gentoo Linux's `emerge` package manager. Monitor your package installations with style, featuring real-time ETA tracking, customizable screensavers, and an intuitive terminal interface.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Bash](https://img.shields.io/badge/bash-5.0%2B-green.svg)
![Platform](https://img.shields.io/badge/platform-Gentoo%20Linux-purple.svg)

## ✨ Features

- **📊 Real-time Emerge Monitoring**: Track your emerge progress with ETA estimates using `genlop`
- **🎨 Multiple Screensavers**: Cycle through various CLI screensavers (pipes.sh, cmatrix, hollywood, asciiquarium)
- **⏰ Time Tracking**: Monitor script runtime and emerge process duration
- **🔄 Auto/Manual Refresh**: Choose between automatic or manual screen updates
- **⚙️ Configurable Refresh Rate**: Adjust refresh intervals on-the-fly
- **🎯 Simple Controls**: Easy-to-use keyboard shortcuts
- **🎭 Beautiful Interface**: Color-coded terminal UI with clean formatting

## 📋 Prerequisites

### Required Dependencies

- **Gentoo Linux** (obviously!)
- **bash** (version 5.0 or higher)
- **genlop** - For emerge progress tracking
  ```bash
  sudo emerge app-portage/genlop
  ```
- **sudo** - Script requires sudo access to run genlop

### Optional Dependencies (Screensavers)

Install any or all of these for the full screensaver experience:

```bash
# pipes.sh - Animated pipes
sudo emerge app-misc/pipes

# cmatrix - Matrix-style falling characters
sudo emerge app-misc/cmatrix

# hollywood - Hollywood-style hacker terminal
sudo emerge app-misc/hollywood

# asciiquarium - ASCII aquarium
sudo emerge games-misc/asciiquarium
```

**Note**: The script will work without these screensavers, but you'll only have the "none" option available.

## 🚀 Installation

1. **Download the script**:
   ```bash
   wget https://raw.githubusercontent.com/yourusername/emerge-monitor/main/emerge-monitor.sh
   ```

2. **Make it executable**:
   ```bash
   chmod +x emerge-monitor.sh
   ```

3. **Optional: Move to a system path**:
   ```bash
   sudo mv emerge-monitor.sh /usr/local/bin/emerge-monitor
   ```

## 💻 Usage

### Basic Usage

Simply run the script while an emerge process is active:

```bash
./emerge-monitor.sh
```

Or if installed system-wide:

```bash
emerge-monitor
```

### Running Without Emerge

You can run the script even without an active emerge process. It will display "No emerge process currently running" but all other features will work.

## ⌨️ Keyboard Controls

| Key | Action | Description |
|-----|--------|-------------|
| **s** | Toggle Screensaver | Cycles through screensavers: none → pipes.sh → cmatrix → hollywood → asciiquarium → none |
| **r** | Manual Refresh | Manually refreshes the emerge status (also exits screensaver mode) |
| **a** | Toggle Auto-refresh | Switches between automatic and manual refresh modes |
| **+** or **=** | Increase Interval | Increases auto-refresh interval by 1 second |
| **-** | Decrease Interval | Decreases auto-refresh interval by 1 second (minimum: 1 second) |
| **q** | Quit | Exits the program |

## 📖 Detailed Feature Guide

### 1. Emerge ETA Monitoring

The main screen displays:
- **Current emerge progress**: Shows which package is being compiled
- **ETA (Estimated Time of Arrival)**: Time remaining for current package
- **Overall progress**: If multiple packages are being emerged
- **Compilation details**: Build time estimates based on historical data

**How it works**: The script uses `genlop -c` to query the current emerge status. This requires sudo privileges because genlop needs to read portage logs.

**Example output**:
```
Currently merging 1 out of 3

 * app-editors/vim-9.0.2116

       current merge time: 1 minute and 23 seconds.
       ETA: 2 minutes.
```

### 2. Screensaver Mode

Press **s** to cycle through different screensavers:

#### Available Screensavers:

1. **none** - Default view showing emerge status
2. **pipes.sh** - Animated colorful pipes flowing across your terminal
3. **cmatrix** - Matrix-style cascading characters
4. **hollywood** - Simulates a Hollywood hacker terminal with multiple split windows
5. **asciiquarium** - A beautiful ASCII art aquarium with swimming fish

**Usage**:
- Press **s** to activate the first screensaver
- Press **s** again to cycle to the next screensaver
- Press **r** to return to the main emerge status view

**Note**: Screensavers continue to run while emerge is working in the background. You won't miss any updates!

### 3. Real-time Clock & Timers

The header displays three time-related metrics:

```
Current Time:     2025-10-30 14:32:15
Script Runtime:   00:15:32
Emerge Runtime:   00:42:18
```

- **Current Time**: Your system's current date and time
- **Script Runtime**: How long the emerge-monitor script has been running
- **Emerge Runtime**: How long the current emerge process has been running (detected automatically)

### 4. Auto-refresh vs Manual Refresh

#### Auto-refresh Mode (Default)

- Screen updates automatically every 5 seconds (default)
- Adjust interval using **+** and **-** keys
- Shows "Auto (5 sec)" in the header

#### Manual Refresh Mode

- Screen only updates when you press **r**
- Useful if you want to read the output carefully
- Shows "Manual" in the header
- Toggle with **a** key

### 5. Configurable Refresh Interval

Fine-tune how often the screen updates:

- Press **+** or **=** to increase interval (e.g., 5 → 6 → 7 seconds)
- Press **-** to decrease interval (e.g., 5 → 4 → 3 seconds)
- Minimum interval: 1 second
- Maximum interval: unlimited (but who wants to wait that long?)

**Tip**: Increase the interval to reduce CPU usage on older systems.

## 🔧 Configuration

### Sudo Configuration for Genlop

The script requires sudo access to run `genlop`. To avoid entering your password each time, you can configure sudoers:

1. Edit sudoers file:
   ```bash
   sudo visudo
   ```

2. Add this line (replace `yourusername` with your actual username):
   ```
   yourusername ALL=(ALL) NOPASSWD: /usr/bin/genlop
   ```

3. Save and exit

**Warning**: Only do this if you understand the security implications!

### Customizing the Script

You can edit the script to customize:

- **Default refresh interval**: Change `REFRESH_INTERVAL=5` to your preferred value
- **Color scheme**: Modify the color definitions at the top of the script
- **Screensaver order**: Rearrange the `SCREENSAVERS` array

## 🐛 Troubleshooting

### "genlop is not installed"

**Solution**: Install genlop:
```bash
sudo emerge app-portage/genlop
```

### "No emerge process currently running"

This is normal if you run the script without an active emerge. The script will still work, but won't show emerge progress. Start an emerge in another terminal:
```bash
sudo emerge --ask some-package
```

### Screensaver not found

**Solution**: Install the missing screensaver (see Optional Dependencies above) or simply skip to the next one by pressing **s** again.

### Screen doesn't refresh automatically

**Possible causes**:
1. Auto-refresh is disabled - Press **a** to enable it
2. You're in screensaver mode - Press **r** to return to main view

### Terminal display issues

**Solution**: Resize your terminal window. The script works best with at least 80 columns width.

## 🎓 Examples

### Example 1: Monitor a System Update

```bash
# Terminal 1: Start system update
sudo emerge --update --deep --newuse @world

# Terminal 2: Monitor progress
./emerge-monitor.sh
```

### Example 2: Monitor with Screensaver

```bash
# Start the monitor
./emerge-monitor.sh

# Press 's' to activate pipes.sh screensaver
# Watch the pretty pipes while your packages compile
# Press 's' again to switch to cmatrix
# Press 'r' to check emerge progress
```

### Example 3: Custom Refresh Rate

```bash
# Start the monitor
./emerge-monitor.sh

# Press '+' several times to set refresh to 10 seconds
# Perfect for slow terminals or SSH connections
```

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

## 📄 License

This project is licensed under the MIT License - see below:

```
MIT License

Copyright (c) 2025 Emerge Monitor Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 🙏 Acknowledgments

- **Gentoo Linux** community for the amazing distribution
- **genlop** developers for the emerge monitoring tool
- All the screensaver developers for making terminal life more fun!

## 📞 Support

If you encounter issues:

1. Check the [Troubleshooting](#-troubleshooting) section
2. Open an issue on GitHub
3. Visit the [Gentoo Forums](https://forums.gentoo.org/)

---

**Happy emerging!** 🎉

Made with ❤️ for the Gentoo community
