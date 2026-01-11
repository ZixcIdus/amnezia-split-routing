# Amnezia Split Routing (Windows)

This project provides a simple split-routing setup for Windows using **AmneziaWG** and optional **zapret** DPI bypass.

The goal is to route only selected services (Discord, Telegram, VRChat, Roblox, etc.) through VPN, while keeping the rest of traffic direct.

## Features

- Split routing via Windows routes
- Works with AmneziaWG (WireGuard-based)
- Optional zapret integration
- No Python required for end users
- One-click start / stop

## Requirements

- Windows 10 / 11
- AmneziaWG installed
- Administrator privileges (once, for setup)

## Quick start (users)

1. Install AmneziaWG and import your tunnel
2. Download this repository
3. Edit paths if needed
4. Run `start-split.bat` or `start-nosplit.bat`

## Files

- `start-split.bat` — VPN + split routing
- `start-nosplit.bat` — VPN without split
- `stop-all.bat` — stop everything
- `domains.txt` — list of routed domains

## Disclaimer

This project does not provide VPN servers, credentials, or bypass guarantees.
It is an educational and technical routing setup.
