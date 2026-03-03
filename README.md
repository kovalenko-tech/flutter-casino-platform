# Flutter Casino Platform

A local-first Flutter casino platform showcasing clean architecture, a custom design system ("Velvet & Gold"), and BLoC-based state management — with zero external back-end dependencies.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
- [Design System — Velvet & Gold](#design-system--velvet--gold)
- [Packages](#packages)
- [Getting Started](#getting-started)
- [Key Decisions](#key-decisions)

---

## Overview

| Feature | Description |
|---------|-------------|
| **Auth** | Local registration + login, SHA-256 password hashing with random salt, stored in Isar |
| **Home** | Hero banner carousel (auto-scroll), category filter chips, 4-column game grid |
| **Games** | Full game catalogue with search, detail screen with RTP / volatility indicators |
| **Profile** | User avatar (initials), stats, settings list, logout |
| **Theming** | Dual dark/light theme; all tokens in `core/theme/` — no hardcoded colours |

---

## Architecture

Clean Architecture with three layers per feature:

```
┌─────────────────────────────────┐
│         Presentation            │  ← Widgets, BLoCs, Screens
│  (Flutter widgets + BLoC)       │
├─────────────────────────────────┤
│           Domain                │  ← Entities, Use Cases, Repository contracts
│  (pure Dart, zero dependencies) │
├─────────────────────────────────┤
│            Data                 │  ← Isar models, datasources, repo implementations
│  (Isar, crypto, network)        │
└─────────────────────────────────┘
```

### C4 Level 1 — System Context

```
[Player] ──uses──► [Casino Platform App]
                         │
                         └──stores data──► [Isar (local DB)]
```

### C4 Level 2 — Containers

```
Casino Platform App
├── Flutter UI (Material 3, go_router)
├── BLoC Layer (flutter_bloc)
├── Domain Layer (use cases, entities)
└── Data Layer (Isar, crypto)
```

---

## Folder Structure

```
lib/
├── app.dart                      # Root CasinoApp widget
├── main.dart                     # Entry point — init DI, run app
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart    # Route paths, DB name, magic strings
│   ├── di/
│   │   └── injection_container.dart  # get_it registrations
│   ├── errors/
│   │   └── failures.dart         # Failure hierarchy
│   ├── mock/
│   │   ├── mock_games.dart       # 16 mock games
│   │   └── mock_banners.dart     # 3 promo banners
│   ├── router/
│   │   └── app_router.dart       # go_router + auth guard
│   └── theme/
│       ├── app_colors.dart       # Color tokens (dark + light)
│       ├── app_typography.dart   # Poppins + Inter text styles
│       ├── app_spacing.dart      # Spacing scale (xs → xxl)
│       ├── app_radius.dart       # Border-radius tokens
│       ├── app_shadows.dart      # BoxShadow presets
│       ├── app_icon_size.dart    # Icon size tokens
│       └── app_theme.dart        # ThemeData assembly
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/auth_local_datasource.dart
│   │   │   ├── models/user_model.dart        # Isar collection
│   │   │   └── repositories/auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/user.dart
│   │   │   ├── repositories/auth_repository.dart
│   │   │   └── usecases/{login,register}_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/auth_{bloc,event,state}.dart
│   │       └── screens/{login,register}_screen.dart
│   │
│   ├── home/
│   │   ├── domain/entities/{game_category,game_summary}.dart
│   │   └── presentation/
│   │       ├── bloc/home_{bloc,event,state}.dart
│   │       ├── screens/home_screen.dart
│   │       └── widgets/{hero_carousel,category_filter_chips,game_grid,game_card}.dart
│   │
│   ├── games/
│   │   ├── domain/entities/game_detail.dart
│   │   └── presentation/
│   │       ├── bloc/game_detail_{bloc,event,state}.dart
│   │       └── screens/{game_detail,games}_screen.dart
│   │
│   ├── profile/
│   │   ├── domain/entities/profile.dart
│   │   └── presentation/
│   │       ├── bloc/profile_{bloc,event,state}.dart
│   │       └── screens/profile_screen.dart
│   │
│   └── shell/
│       └── main_shell.dart       # StatefulShellRoute + bottom nav
│
└── shared/
    └── widgets/
        ├── app_button.dart       # Primary / secondary / ghost variants
        ├── shimmer_loader.dart   # Shimmer placeholders
        └── category_badge.dart   # Coloured category chip
```

---

## Design System — Velvet & Gold

All visual tokens live in `lib/core/theme/`. **Never hardcode** colours, sizes, or spacing directly in widgets.

### Colour Palette

| Token | Dark | Light |
|-------|------|-------|
| Background | `#080B14` | `#F5F4EF` |
| Surface | `#111827` | `#FFFFFF` |
| Card | `#1C2333` | `#FAF9F6` |
| Primary (Gold) | `#F0B429` | `#D97706` |
| Accent (Purple) | `#8B5CF6` | `#7C3AED` |
| Success | `#10B981` | `#10B981` |
| Error | `#EF4444` | `#EF4444` |
| Text Primary | `#F9FAFB` | `#0F172A` |
| Text Secondary | `#9CA3AF` | `#64748B` |

### Typography

- **Headings** — Poppins (weight 600–700, tracking −0.5 to 0)
- **Body / Labels** — Inter (weight 400–600, small letter-spacing)

### Spacing Scale

`xs=4` · `sm=8` · `md=16` · `lg=24` · `xl=32` · `xxl=48`

---

## Packages

| Package | Version | Why |
|---------|---------|-----|
| `flutter_bloc` | ^8.1.5 | Predictable, testable state management |
| `equatable` | ^2.0.5 | Value equality for BLoC events/states |
| `get_it` | ^7.7.0 | Lightweight service locator for DI |
| `go_router` | ^14.2.0 | Declarative routing with auth guard |
| `isar` | ^3.1.0 | Fast, Dart-native local DB (replaces Hive) |
| `isar_flutter_libs` | ^3.1.0 | Isar native binaries for iOS & Android |
| `path_provider` | ^2.1.3 | DB path resolution on each platform |
| `crypto` | ^3.0.3 | SHA-256 password hashing |
| `uuid` | ^4.4.0 | UUID v4 generation for user IDs |
| `cached_network_image` | ^3.3.1 | Image caching with error placeholders |
| `google_fonts` | ^6.2.1 | Poppins + Inter font loading |
| `shimmer` | ^3.0.0 | Loading skeleton animations |
| `flutter_svg` | ^2.0.10+1 | SVG asset rendering |

---

## Getting Started

### Prerequisites

- Flutter ≥ 3.19.0
- Dart ≥ 3.3.0

### 1. Clone & install

```bash
git clone https://github.com/kovalenko-tech/flutter-casino-platform
cd flutter-casino-platform
flutter pub get
```

### 2. Generate Isar schemas

Isar requires code generation for its `@collection` models:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates `lib/features/auth/data/models/user_model.g.dart`.

### 3. Run

```bash
flutter run
```

---

## Key Decisions

### Local-first with Isar
Rather than hitting a remote API, all player data lives in an Isar database on-device. This makes the app fully functional offline and removes the need for a back-end during development. In production, Isar would act as the cache layer and sync with a remote API on connectivity changes.

### No `dartz` / functional Either
Instead of pulling in `dartz` for `Either<L, R>`, a minimal record-based implementation is defined in `auth_repository.dart`. This keeps the dependency tree lean and avoids the learning curve of the full `dartz` API for contributors unfamiliar with functional Dart.

### BLoC over Riverpod/Provider
BLoC gives explicit, auditable state transitions — particularly valuable in a gambling context where every state change has clear meaning. Events are named commands (`LoginRequested`) and states are named outcomes (`Authenticated`), making the flow easy to trace and test.

### Design tokens over theme extensions
All colours, spacing, and typography are defined as `abstract final class` constants rather than Flutter `ThemeExtension` objects. This keeps token usage IDE-friendly (autocomplete, find usages) without requiring `Theme.of(context).extension<...>()` boilerplate.

### SHA-256 + random salt for passwords
Passwords are never stored in plain text. A 16-byte cryptographically random salt is generated at registration, and the stored value is `SHA-256(password + salt)`. Comparison uses a constant-time XOR loop to resist timing attacks.
