# zapret (optional Discord workaround)

## Overview

This folder contains **zapret**, an **optional** DPI circumvention tool.

It is included **only as a fallback** for Discord connectivity issues and is **not required** for normal operation of this project.

zapret is **disabled by default**.

---

## Why zapret is included

Some users experience problems with **Discord Desktop**, such as:

- `RTC Connecting`
- `No Route`
- Endless voice reconnects
- Voice works in browser but not in the desktop app

These issues are usually caused by:

- Deep Packet Inspection (DPI)
- TLS / SNI interference
- Discord Desktop’s native UDP / WebRTC stack

They are **not caused by this project itself**.

zapret exists here only as a **workaround** for these edge cases.

---

## Important limitation

⚠️ **zapret works reliably ONLY with browser-based Discord**

### Discord Desktop is NOT supported

This is a **technical limitation**, not a configuration issue.

Discord Desktop:

- Uses Electron with native networking
- Relies heavily on UDP + STUN/TURN
- Does not fully respect TCP/TLS interception

zapret operates at the **TCP/TLS level**, which means:

- ✅ Works well for browser traffic
- ❌ Does NOT reliably fix Discord Desktop voice

**Result:** Browser Discord works, Desktop Discord may remain broken.  
This is expected behavior.

---

## When to use zapret

Use zapret **only if**:

- Discord works in a browser
- Discord Desktop voice does NOT connect
- VPN / split routing is already configured correctly
- You understand this is a workaround

If Discord works without zapret — **do not use it**.

---

## When NOT to use zapret

Do NOT use zapret if:

- You only use browser Discord
- Voice works correctly without it
- You expect full Discord Desktop support

zapret is **optional**, not a core component.

---

## Recommended setup

### ✅ Recommended

- VPN / WireGuard enabled
- Split routing configured
- **Discord in browser**
- zapret → optional (only if needed)

### ❌ Not recommended

- Expecting zapret to fully fix Discord Desktop voice
- Using zapret as a permanent VPN replacement

---

## Technical summary

| Component | Purpose |
|---|---|
| VPN / WireGuard | Traffic routing |
| Split routing | Domain-based VPN control |
| zapret | DPI / TLS interference mitigation |
| Browser Discord | Stable WebRTC via Chromium |

---

## Final notes

zapret is included for **practical reasons**, not because it is ideal.

If browser-based Discord works — **that is the intended and supported solution**.

---

## Status

- zapret: **optional**
- Discord Desktop: **not supported**
- Browser Discord: **supported and recommended**

---

If you want a **simpler setup**:  
👉 Use browser Discord and **do not use zapret at all**.
