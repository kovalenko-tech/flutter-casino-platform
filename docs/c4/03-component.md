# C4 Level 3 — Component Diagram

> Internal components of the Flutter Casino App, organised by feature.

```mermaid
C4Component
    title Component Diagram — Flutter Casino App

    System_Boundary(core, "Core") {
        Component(router, "AppRouter", "go_router", "Declarative routing with AuthGuard — redirects unauthenticated users to /login.")
        Component(di, "DI Container", "get_it", "Service locator. Registers all use cases, repositories, and BLoC factories.")
        Component(theme, "AppTheme", "Flutter ThemeData", "Dark casino theme, colour tokens, text styles.")
        Component(errors, "Failures", "Sealed classes", "Typed failure hierarchy: AuthFailure, StorageFailure, etc.")
    }

    System_Boundary(auth, "Auth Feature") {
        Component(auth_bloc, "AuthBloc", "flutter_bloc", "Manages authentication state machine: initial → loading → authenticated / unauthenticated / error.")
        Component(login_uc, "LoginUseCase", "Dart", "Validates credentials against hashed password stored in Isar.")
        Component(register_uc, "RegisterUseCase", "Dart", "Creates new User entity, hashes password with SHA-256 + salt, persists via AuthRepository.")
        Component(auth_repo, "AuthRepository (impl)", "Isar SDK", "Reads/writes User @Collection. Implements domain IAuthRepository interface.")
        Component(user_model, "UserModel", "Isar @Collection", "Persistent user record: id, name, email, passwordHash, salt, memberSince, accountId.")
    }

    System_Boundary(home, "Home Feature") {
        Component(home_bloc, "HomeBloc", "flutter_bloc", "Loads banners and game summaries on startup. Exposes HomeState.")
        Component(banners_uc, "GetBannersUseCase", "Dart", "Fetches promotional banner list.")
        Component(games_uc, "GetGamesUseCase", "Dart", "Returns filtered/sorted game summaries for the home grid.")
        Component(mock_home, "MockHomeDataSource", "Dart", "In-memory seed data for banners and game summaries (no network required).")
    }

    System_Boundary(games, "Games Feature") {
        Component(game_bloc, "GameDetailBloc", "flutter_bloc", "Fetches and exposes full game detail for the detail screen.")
        Component(game_uc, "GetGameDetailUseCase", "Dart", "Retrieves a single GameDetail by id.")
        Component(mock_game, "MockGameDetailSource", "Dart", "Returns hardcoded GameDetail objects.")
    }

    System_Boundary(profile, "Profile Feature") {
        Component(profile_bloc, "ProfileBloc", "flutter_bloc", "Loads current user profile data.")
        Component(profile_uc, "GetProfileUseCase", "Dart", "Reads authenticated user entity from local storage.")
        Component(local_profile, "LocalProfileDataSource", "Isar SDK", "Reads User record for the logged-in account id.")
    }

    Rel(router, auth_bloc, "Redirects based on auth state")
    Rel(di, auth_bloc, "Provides")
    Rel(di, home_bloc, "Provides")
    Rel(di, game_bloc, "Provides")
    Rel(di, profile_bloc, "Provides")

    Rel(auth_bloc, login_uc, "Calls on LoginEvent")
    Rel(auth_bloc, register_uc, "Calls on RegisterEvent")
    Rel(login_uc, auth_repo, "IAuthRepository.findByEmail()")
    Rel(register_uc, auth_repo, "IAuthRepository.save()")
    Rel(auth_repo, user_model, "Isar CRUD")

    Rel(home_bloc, banners_uc, "Calls on LoadHomeEvent")
    Rel(home_bloc, games_uc, "Calls on LoadHomeEvent")
    Rel(banners_uc, mock_home, "IHomeDataSource.getBanners()")
    Rel(games_uc, mock_home, "IHomeDataSource.getGames()")

    Rel(game_bloc, game_uc, "Calls on LoadGameEvent")
    Rel(game_uc, mock_game, "IGameDataSource.getById()")

    Rel(profile_bloc, profile_uc, "Calls on LoadProfileEvent")
    Rel(profile_uc, local_profile, "IProfileDataSource.getProfile()")

    Rel(auth_bloc, errors, "Emits typed Failure on error")
    Rel(login_uc, errors, "Returns Either<Failure, User>")
```

## Component summary

| Feature | BLoC | Use Cases | Repository / Source |
|---|---|---|---|
| **Auth** | `AuthBloc` | `LoginUseCase`, `RegisterUseCase` | `AuthRepository` → Isar `UserModel` |
| **Home** | `HomeBloc` | `GetBannersUseCase`, `GetGamesUseCase` | `MockHomeDataSource` |
| **Games** | `GameDetailBloc` | `GetGameDetailUseCase` | `MockGameDetailSource` |
| **Profile** | `ProfileBloc` | `GetProfileUseCase` | `LocalProfileDataSource` → Isar |
| **Core** | — | — | `AppRouter`, DI (`get_it`), `AppTheme`, `Failures` |
