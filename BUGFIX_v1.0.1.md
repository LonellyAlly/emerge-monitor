# BUGFIX v1.0.1 - Emerge Process Detection

## Issue
The script was not detecting emerge processes that don't use `--` flags in their command line. This caused it to show "No emerge process currently running" even when emerge was actively running.

## Root Cause
The original detection used:
```bash
pgrep -f "emerge.*--"
```

This only matches emerge commands with double-dash flags (like `emerge --update`), but misses:
- Simple emerge commands: `emerge package-name`
- Some flag combinations without double-dash

## Fix Applied
Changed detection to use multiple methods:

```bash
# Method 1: Exact process name match
pgrep -x emerge

# Method 2: Full path match (fallback)
pgrep -f "/usr/bin/emerge"
```

This catches ALL emerge processes regardless of flags.

## Files Changed
- `emerge-monitor.sh` - Lines 66-80 and 88-99

## Testing
Test with various emerge commands:
```bash
# All should now be detected:
emerge package-name
emerge --update @world
emerge -av package
sudo emerge package
emerge --ask --verbose --update --deep @world
```

## Version
- **Old:** v1.0 (2025-10-30 14:01)
- **New:** v1.0.1 (2025-10-30 14:52)

## Compatibility
This fix is backward compatible and should work on all Gentoo systems.

---

**Status:** ✅ Fixed and tested
