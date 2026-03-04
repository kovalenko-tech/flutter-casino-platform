# C4 Level 1 — System Context

> Who uses the system and what does it interact with?

```mermaid
C4Context
    title System Context — Flutter Casino Platform

    Person(player, "Player", "A casino app user who plays games, manages their profile, and tracks history on their device.")

    System(app, "Flutter Casino App", "Cross-platform mobile application (iOS / Android). Runs entirely on-device — no backend required.")

    SystemDb(sqlite, "Local Storage (SQLite)", "Embedded relational database stored on the device via sqflite. Persists user accounts and session data.")

    Rel(player, app, "Opens app, logs in, browses games, plays, views profile")
    Rel(app, sqlite, "Reads & writes", "sqflite")

    UpdateElementStyle(player, $bgColor="#1168BD", $fontColor="#ffffff")
    UpdateElementStyle(app, $bgColor="#1168BD", $fontColor="#ffffff")
    UpdateElementStyle(sqlite, $bgColor="#999999", $fontColor="#ffffff")
```

## Notes

- **No network dependency** — the app is fully self-contained; all data lives in SQLite on the device.
- **Single actor** — only the human Player interacts with the system.
- Future iterations may add a remote backend (REST / WebSocket) for real-money flows, but that is out of scope for the current version.
