# C4 Level 1 — System Context

> Who uses the system and what does it interact with?

```mermaid
C4Context
    title System Context — Flutter Casino Platform

    Person(player, "Player", "A casino app user who plays games, manages their profile, and tracks history on their device.")

    System(app, "Flutter Casino App", "Cross-platform mobile application (iOS / Android). Runs entirely on-device — no backend required.")

    SystemDb(isar, "Local Storage (Isar DB)", "Embedded NoSQL database stored on the device. Persists user accounts, game data, banners, and session history.")

    Rel(player, app, "Opens app, logs in, browses games, plays, views profile")
    Rel(app, isar, "Reads & writes", "Isar Flutter SDK (FFI)")

    UpdateElementStyle(player, $bgColor="#1168BD", $fontColor="#ffffff")
    UpdateElementStyle(app, $bgColor="#1168BD", $fontColor="#ffffff")
    UpdateElementStyle(isar, $bgColor="#999999", $fontColor="#ffffff")
```

## Notes

- **No network dependency** — the app is fully self-contained; all data lives in Isar DB on the device.
- **Single actor** — only the human Player interacts with the system.
- Future iterations may add a remote backend (REST / WebSocket) for real-money flows, but that is out of scope for the current version.
