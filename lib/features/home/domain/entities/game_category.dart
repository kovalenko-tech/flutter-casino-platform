/// Game category taxonomy used for filtering and display labels.
enum GameCategory {
  all,
  slots,
  live,
  table,
  jackpot;

  String get displayName => switch (this) {
        GameCategory.all => 'All',
        GameCategory.slots => 'Slots',
        GameCategory.live => 'Live Casino',
        GameCategory.table => 'Table Games',
        GameCategory.jackpot => 'Jackpot',
      };
}
