# C4 Level 4 — Key Domain Models

> Core entities, enums, and state types that drive the application.

```mermaid
classDiagram
    direction TB

    class User {
        +int id
        +String name
        +String email
        +String passwordHash
        +String salt
        +DateTime memberSince
        +String accountId
    }

    class GameDetail {
        +String id
        +String name
        +GameCategory category
        +String provider
        +String description
        +double rtp
        +Volatility volatility
        +String imageUrl
    }

    class Banner {
        +String id
        +String title
        +String ctaText
        +String imageUrl
    }

    class GameSummary {
        +String id
        +String name
        +GameCategory category
        +String provider
        +String imageUrl
    }

    class Profile {
        +String accountId
        +String name
        +String email
        +DateTime memberSince
    }

    class AuthState {
        <<union>>
        AuthInitial
        AuthLoading
        AuthAuthenticated
        AuthUnauthenticated
        AuthError
    }

    class AuthAuthenticated {
        +User user
    }

    class AuthError {
        +String message
    }

    class GameCategory {
        <<enumeration>>
        slots
        live
        table
    }

    class Volatility {
        <<enumeration>>
        low
        medium
        high
    }

    class Failure {
        <<sealed>>
        +String message
    }

    class AuthFailure {
        +String message
    }

    class StorageFailure {
        +String message
    }

    class NotFoundFailure {
        +String message
    }

    %% Relationships
    AuthState <|-- AuthAuthenticated
    AuthState <|-- AuthError

    AuthAuthenticated --> User : contains

    GameDetail --> GameCategory : category
    GameDetail --> Volatility : volatility
    GameSummary --> GameCategory : category

    User --> Profile : "maps to (read-only view)"

    Failure <|-- AuthFailure
    Failure <|-- StorageFailure
    Failure <|-- NotFoundFailure
```

## Domain model notes

| Model | Layer | Storage | Notes |
|---|---|---|---|
| `User` | Domain / Data | Isar `@Collection` | Password never stored in plain text — only SHA-256 hash + random salt |
| `GameDetail` | Domain | In-memory mock | Full detail shown on game detail screen |
| `GameSummary` | Domain | In-memory mock | Lightweight card shown in home grid |
| `Banner` | Domain | In-memory mock | Promotional banners on home screen |
| `Profile` | Domain | Derived from `User` | Read-only view model for profile screen |
| `AuthState` | Presentation | BLoC state | Sealed union; `AuthAuthenticated` carries the `User` |
| `Failure` | Domain | — | Sealed hierarchy; used in `Either<Failure, T>` return types |

### Password hashing flow

```
plainPassword + randomSalt
        │
        ▼
  SHA-256 (crypto package)
        │
        ▼
  passwordHash  ──► stored in Isar User record
```
