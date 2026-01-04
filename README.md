# Terminal Scripts: iPhone + Neofetch

A tiny set of Bash helpers I use to customize my macOS terminal and show iPhone connection details.

## Scripts
- [iphone_info.sh](iphone_info.sh): Detects a connected iPhone/iPad over USB, prints device details, a simple ASCII phone, and a short matrix-style binary rain, then runs neofetch (falls back to plain neofetch if no device is found).
- [iphone_info_clean.sh](iphone_info_clean.sh): Lighter version that prints the device panel plus neofetch without the matrix effect.
- [green_neofetch.sh](green_neofetch.sh): Runs neofetch with green ASCII colors.

## Prerequisites
- macOS (uses system_profiler and ioreg)
- neofetch installed (`brew install neofetch` if needed)

## Usage
1. Make the scripts executable: `chmod +x iphone_info.sh iphone_info_clean.sh green_neofetch.sh`.
2. Plug an iPhone/iPad in over USB and run `./iphone_info.sh` for the full display.
3. For a leaner panel, run `./iphone_info_clean.sh`.
4. To just show system info with the green theme, run `./green_neofetch.sh`.

## Notes
- If no device is detected, the scripts still run neofetch so you always get output.
- Battery percent comes from ioreg and may not appear on every macOS version.
