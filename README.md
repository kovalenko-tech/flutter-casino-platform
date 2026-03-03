# Flutter Casino Platform

[![CI](https://github.com/kovalenko-tech/flutter-casino-platform/actions/workflows/ci.yml/badge.svg)](https://github.com/kovalenko-tech/flutter-casino-platform/actions/workflows/ci.yml)

A local-first Flutter casino platform showcasing clean architecture, a custom design system ("Velvet & Gold"), and BLoC-based state management — with zero external back-end dependencies.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
- [Design System — Velvet & Gold](#design-system--velvet--gold)
- [Localization](#localization)
- [Mock Repository Strategy](#mock-repository-strategy)
- [Testing](#testing)
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
| **Theming** | Dual dark/light theme; all tokens in `core/theme/` — no hardcoded colours or sizes |
| **L10n** | Full English + Ukrainian localization via ARB files and generated `AppLocalizations` |

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
│  (Isar, crypto, mock data)      │
└─────────────────────────────────┘
```

The domain layer has **no Flutter imports** — only pure Dart. This makes use cases and entities independently testable without a widget environment.

### Data flow

```
Screen → BLoC Event → BLoC → UseCase → Repository (interface)
                                              ↓
                                    MockXxxRepository   ← swap for RealXxxRepository
                                    (data/repositories)     in DI with zero other changes
```

---

## Folder Structure

```
lib/
├── app.dart                          # Root CasinoApp widget (theme + l10n + router)
├── main.dart                         # Entry point — init DI, open Isar, runApp
│
├── core/
│   ├── constants/app_constants.dart  # Route paths, DB name, app name
│   ├── di/injection_container.dart   # get_it — all registrations in one place
│   ├── errors/failures.dart          # Failure hierarchy (Auth, Storage, NotFound, Validation)
│   ├── types/either.dart             # Lightweight Either<L,R> (no dartz dependency)
│   ├── l10n/
│   │   ├── app_localizations.dart    # Generated — do not edit manually
│   │   └── l10n_extension.dart       # context.l10n shortcut
│   ├── mock/
│   │   ├── mock_games.dart           # 16 static games across 4 categories
│   │   └── mock_banners.dart         # 3 promo banners
│   ├── router/app_router.dart        # go_router with auth redirect guard
│   └── theme/
│       ├── theme.dart                # Barrel — single import for all tokens
│       ├── app_colors.dart           # Color tokens (dark + light ColorScheme)
│       ├── app_typography.dart       # Poppins + Inter text styles + numeric styles
│       ├── app_spacing.dart          # Spacing scale (xs=4 → xxl=48)
│       ├── app_sizes.dart            # Component sizes (buttons, avatars, cards, images)
│       ├── app_radius.dart           # Border-radius tokens + pre-built BorderRadius
│       ├── app_shadows.dart          # BoxShadow presets (card, modal, glow)
│       ├── app_icon_size.dart        # Icon size tokens (xs=12 → xxl=48)
│       └── app_theme.dart            # ThemeData assembly from tokens
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/auth_local_datasource.dart
│   │   │   ├── models/user_model.dart          # @collection — Isar schema
│   │   │   └── repositories/auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/user.dart
│   │   │   ├── repositories/auth_repository.dart   # abstract interface
│   │   │   └── usecases/{login,register}_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/auth_{bloc,event,state}.dart
│   │       └── screens/{login,register}_screen.dart
│   │
│   ├── home/
│   │   ├── data/repositories/mock_home_repository.dart
│   │   ├── domain/
│   │   │   ├── entities/{game_category,game_summary,promo_banner}.dart
│   │   │   ├── repositories/home_repository.dart   # abstract interface
│   │   │   └── usecases/{get_banners,get_games}_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/home_{bloc,event,state}.dart
│   │       ├── screens/home_screen.dart
│   │       └── widgets/{hero_carousel,category_filter_chips,game_grid,game_card}.dart
│   │
│   ├── games/
│   │   ├── data/repositories/mock_games_repository.dart
│   │   ├── domain/
│   │   │   ├── entities/game_detail.dart
│   │   │   ├── repositories/games_repository.dart  # abstract interface
│   │   │   └── usecases/get_game_detail_usecase.dart
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
│   └── shell/main_shell.dart         # StatefulShellRoute + bottom nav bar
│
├── l10n/
│   ├── app_en.arb                    # English strings (60+ keys)
│   └── app_uk.arb                    # Ukrainian strings
│
└── shared/
    ├── extensions/
    │   ├── game_category_l10n.dart   # category.label(l10n)
    │   └── volatility_l10n.dart      # volatility.label(l10n)
    └── widgets/
        ├── app_button.dart           # Primary / secondary / ghost variants
        ├── shimmer_loader.dart        # Loading skeleton
        └── category_badge.dart        # Coloured category chip

test/
├── helpers/
│   ├── test_helpers.dart             # buildTestWidget(), shared fixtures
│   └── mock_classes.dart             # Central mock hub (mocktail)
└── features/
    ├── auth/                         # Entity, use case, BLoC, screen tests
    ├── home/                         # Entity, repository, use case, BLoC, widget tests
    ├── games/                        # Repository, use case, BLoC, screen tests
    └── profile/                      # BLoC tests
```

---

## Design System — Velvet & Gold

All visual tokens live in `lib/core/theme/`. Import once via the barrel:

```dart
import 'package:flutter_casino_platform/core/theme/theme.dart';
```

**Never hardcode** colours, sizes, or spacing — always use tokens:

```dart
// ✅ Correct
padding: EdgeInsets.all(AppSpacing.md)
color: AppColors.darkPrimary
style: AppTypography.titleLarge(colors.onSurface)
borderRadius: BorderRadius.circular(AppRadius.card)
height: AppSizes.gameCardHeight

// ❌ Wrong
padding: EdgeInsets.all(16)
color: Color(0xFFF0B429)
```

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

### Typography

- **Headings** — Poppins (weight 600–700): `displayLarge` → `titleSmall`
- **Body / Labels** — Inter (weight 400–600): `bodyLarge` → `labelSmall`
- **Numeric** — Inter tabular figures: `numericLarge/Medium/Small` — for RTP, balances, stats (digits stay fixed-width as values update)
- **Mono** — Roboto Mono: `monoSmall` — for account IDs, codes

### Spacing & Sizes

```
Spacing:  xs=4  sm=8  md=16  lg=24  xl=32  xxl=48
Radius:   sm=8  md=12  lg=16  xl=24  full=999
Icons:    xs=12  sm=16  md=20  lg=24  xl=32  xxl=48
```

---

## Localization

The app uses Flutter's built-in `flutter_localizations` with ARB files.

**Supported locales:** English (`en`), Ukrainian (`uk`)

```
lib/l10n/
├── app_en.arb    # 60+ string keys — English
└── app_uk.arb    # Full Ukrainian translation
```

### Usage in widgets

```dart
import 'package:flutter_casino_platform/core/l10n/l10n_extension.dart';

// Instead of AppLocalizations.of(context).authSignIn:
Text(context.l10n.authSignIn)
Text(context.l10n.validationPasswordMinLength(8))

// Enum labels via presentation-layer extensions:
Text(game.category.label(context.l10n))   // GameCategoryL10n
Text(game.volatility.label(context.l10n)) // VolatilityL10n
```

Domain entities (`GameCategory`, `Volatility`) contain **no display strings** — presentation extensions handle translation, keeping the domain layer framework-independent.

### Generate after adding new strings

```bash
flutter gen-l10n
```

---

## Mock Repository Strategy

There is no back-end. All game and banner data is served by in-memory mock implementations of the repository interfaces:

```
HomeRepository (abstract interface)
  └── MockHomeRepository   ← registered in DI today
  └── RealHomeRepository   ← replace in DI when API is ready

GamesRepository (abstract interface)
  └── MockGamesRepository  ← registered in DI today
  └── RealGamesRepository  ← replace in DI when API is ready
```

To switch to a real implementation, change **one line** in `injection_container.dart`:

```dart
// Before (mock):
sl.registerLazySingleton<HomeRepository>(() => const MockHomeRepository());

// After (real):
sl.registerLazySingleton<HomeRepository>(() => RealHomeRepository(sl<ApiClient>()));
```

BLoCs, use cases, and screens require **zero changes**.

---

## Testing

```bash
flutter test                        # run all tests
flutter test --coverage             # with lcov coverage report
flutter test test/features/auth/    # specific feature only
```

### Test structure

| Layer | Tool | Files |
|-------|------|-------|
| Domain entities | `flutter_test` | `*_test.dart` in `test/features/*/domain/` |
| Mock repositories | `flutter_test` | `test/features/*/data/repositories/` |
| Use cases | `flutter_test` + `mocktail` | `test/features/*/domain/usecases/` |
| BLoCs | `bloc_test` + `mocktail` | `test/features/*/presentation/bloc/` |
| Widgets & screens | `flutter_test` + `mocktail` | `test/features/*/presentation/` + `test/shared/` |

### Helpers

`test/helpers/test_helpers.dart` — shared fixtures and `buildTestWidget()`:

```dart
Widget buildTestWidget(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  theme: AppTheme.dark,
  home: child,
);

// Ready-to-use fixtures:
final testUser    = User(...);
final testGame    = GameDetail(...);
final testSummary = GameSummary(...);
final testBanner  = PromoBanner(...);
```

`test/helpers/mock_classes.dart` — central mock hub (all `MockBloc` and `Mock` classes in one place).

---

## Packages

| Package | Version | Why |
|---------|---------|-----|
| `flutter_bloc` | ^8.1.5 | Predictable, testable state management |
| `equatable` | ^2.0.5 | Value equality for BLoC events/states |
| `get_it` | ^7.7.0 | Lightweight service locator for DI |
| `go_router` | ^14.2.0 | Declarative routing with auth redirect guard |
| `isar` | ^3.1.0 | Fast, Dart-native local DB |
| `isar_flutter_libs` | ^3.1.0 | Isar native binaries (iOS + Android) |
| `path_provider` | ^2.1.3 | DB path resolution per platform |
| `flutter_localizations` | SDK | Localization delegates |
| `intl` | ^0.19.0 | ARB-based string generation |
| `crypto` | ^3.0.3 | SHA-256 password hashing |
| `uuid` | ^4.4.0 | UUID v4 for user IDs |
| `cached_network_image` | ^3.3.1 | Image caching with error placeholders |
| `google_fonts` | ^6.2.1 | Poppins + Inter fonts |
| `shimmer` | ^3.0.0 | Loading skeleton animations |
| `flutter_svg` | ^2.0.10+1 | SVG asset rendering |
| **dev** `bloc_test` | ^9.1.7 | BLoC unit testing DSL |
| **dev** `mocktail` | ^1.0.4 | Type-safe mocking without code generation |

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

### 2. Generate code

```bash
# Isar schemas + localization files
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

### 3. Run

```bash
flutter run
```

### 4. Test

```bash
flutter test --coverage
```

---

## Key Decisions

### Local-first with Isar
All player data lives in an Isar database on-device. Isar was chosen over Hive for its type-safe query API and better performance on large collections. In production, Isar would act as the cache layer and sync with a remote API on connectivity changes.

### Repository interfaces at the DI boundary
Every data source is hidden behind an `abstract interface class`. The DI container (`injection_container.dart`) is the only place that knows about concrete implementations. This makes swapping mock ↔ real implementations a one-line change with zero impact on the domain or presentation layers.

### Lightweight Either without dartz
`Either<L, R>` is implemented as a Dart record in `core/types/either.dart`. This avoids pulling in the full `dartz` package (and its learning curve) while still making error paths explicit and type-safe at every layer boundary.

### BLoC over Riverpod/Provider
BLoC gives explicit, auditable state transitions — particularly valuable in a gambling context where every state change has clear meaning. Events are named commands (`LoginRequested`) and states are named outcomes (`Authenticated`), making flows easy to trace and test.

### Design tokens as abstract final classes
All colours, spacing, and typography are `abstract final class` constants rather than Flutter `ThemeExtension` objects. This keeps token usage IDE-friendly (autocomplete, find usages, rename refactoring) without the `Theme.of(context).extension<T>()` boilerplate. The barrel file (`theme.dart`) provides a single import for all token classes.

### Localization in the presentation layer only
Domain enums (`GameCategory`, `Volatility`) contain no display strings. Localized labels live in presentation-layer extensions (`GameCategoryL10n`, `VolatilityL10n`). This keeps the domain layer framework-independent and testable without a `BuildContext`.

### SHA-256 + random salt
Passwords are never stored in plain text. A 16-byte cryptographically random salt is generated at registration; the stored value is `SHA-256(password + salt)`. Comparison uses a constant-time XOR loop to resist timing attacks.
