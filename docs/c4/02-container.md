# C4 Level 2 — Container Diagram

> What are the high-level building blocks inside the Flutter Casino App?

```mermaid
C4Container
    title Container Diagram — Flutter Casino App

    Person(player, "Player", "App user")

    System_Boundary(app, "Flutter Casino App") {
        Container(ui, "Presentation Layer", "Flutter Widgets / BLoC", "Screens, widgets, and BLoC state management. Renders UI and dispatches user events.")
        Container(app_layer, "Application Layer", "Dart / Use Cases", "Orchestrates business logic. Each use case encapsulates a single user action (login, get games, etc.).")
        Container(domain, "Domain Layer", "Dart / Pure", "Core business entities and abstract repository contracts. Has zero Flutter / framework dependencies.")
        Container(data, "Data Layer", "Dart / sqflite", "Concrete repository implementations. Bridges domain contracts to SQLite data sources and in-memory mocks.")
        ContainerDb(isar_db, "SQLite Database", "SQLite (embedded SQL)", "On-device persistent store. Holds user records, game catalogue, banners, and history.")
    }

    Rel(player, ui, "Taps / swipes")
    Rel(ui, app_layer, "Calls use cases via BLoC events")
    Rel(app_layer, domain, "Operates on domain entities")
    Rel(app_layer, data, "Invokes repository interface implementations")
    Rel(data, isar_db, "CRUD operations", "sqflite")

    UpdateElementStyle(player, $bgColor="#1168BD", $fontColor="#ffffff")
    UpdateElementStyle(ui, $bgColor="#1168BD", $fontColor="#ffffff")
    UpdateElementStyle(app_layer, $bgColor="#1168BD", $fontColor="#ffffff")
    UpdateElementStyle(domain, $bgColor="#1168BD", $fontColor="#ffffff")
    UpdateElementStyle(data, $bgColor="#1168BD", $fontColor="#ffffff")
    UpdateElementStyle(isar_db, $bgColor="#999999", $fontColor="#ffffff")
```

## Layer responsibilities

| Layer | What lives here | Key rule |
|---|---|---|
| **Presentation** | Screens, widgets, BLoC (`*Bloc`, `*State`, `*Event`) | No business logic; only UI state |
| **Application** | Use cases (`*UseCase`) | One public `execute()` / `call()` method each |
| **Domain** | Entities, repository interfaces, value objects | Pure Dart — no external packages |
| **Data** | Repository impls, SQLite models (`@Collection`), mock sources | Implements domain interfaces |
| **SQLite DB** | On-device `.isar` file | Managed entirely by SQLite runtime |
