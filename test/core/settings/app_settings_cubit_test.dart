import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_casino_platform/core/settings/app_settings_cubit.dart';

void main() {
  group('AppSettingsCubit', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('initial state has system theme and en locale', () {
      final cubit = AppSettingsCubit();
      expect(cubit.state.themeMode, ThemeMode.system);
      expect(cubit.state.locale, const Locale('en'));
      cubit.close();
    });

    blocTest<AppSettingsCubit, AppSettingsState>(
      'load() reads saved theme and locale from SharedPreferences',
      setUp: () {
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'dark',
          'locale': 'uk',
        });
      },
      build: () => AppSettingsCubit(),
      act: (cubit) => cubit.load(),
      expect: () => [
        const AppSettingsState(
          themeMode: ThemeMode.dark,
          locale: Locale('uk'),
        ),
      ],
    );

    blocTest<AppSettingsCubit, AppSettingsState>(
      'load() defaults to system/en when prefs are empty',
      setUp: () {
        SharedPreferences.setMockInitialValues({});
      },
      build: () => AppSettingsCubit(),
      act: (cubit) => cubit.load(),
      expect: () => [
        const AppSettingsState(
          themeMode: ThemeMode.system,
          locale: Locale('en'),
        ),
      ],
    );

    blocTest<AppSettingsCubit, AppSettingsState>(
      'setThemeMode() emits new state and persists',
      setUp: () {
        SharedPreferences.setMockInitialValues({});
      },
      build: () => AppSettingsCubit(),
      act: (cubit) => cubit.setThemeMode(ThemeMode.light),
      expect: () => [
        const AppSettingsState(
          themeMode: ThemeMode.light,
          locale: Locale('en'),
        ),
      ],
      verify: (_) async {
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('theme_mode'), 'light');
      },
    );

    blocTest<AppSettingsCubit, AppSettingsState>(
      'setLocale() emits new state and persists',
      setUp: () {
        SharedPreferences.setMockInitialValues({});
      },
      build: () => AppSettingsCubit(),
      act: (cubit) => cubit.setLocale(const Locale('de')),
      expect: () => [
        const AppSettingsState(
          themeMode: ThemeMode.system,
          locale: Locale('de'),
        ),
      ],
      verify: (_) async {
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('locale'), 'de');
      },
    );

    blocTest<AppSettingsCubit, AppSettingsState>(
      'load() parses light theme mode correctly',
      setUp: () {
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'light',
          'locale': 'de',
        });
      },
      build: () => AppSettingsCubit(),
      act: (cubit) => cubit.load(),
      expect: () => [
        const AppSettingsState(
          themeMode: ThemeMode.light,
          locale: Locale('de'),
        ),
      ],
    );
  });
}
