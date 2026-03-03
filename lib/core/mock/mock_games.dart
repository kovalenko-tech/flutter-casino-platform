import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';

/// Static mock catalogue — 16 games across 5 categories.
///
/// In production these would be fetched from a remote API and cached locally.
/// picsum.photos IDs are fixed so the same image is always returned for
/// a given game, making screenshots deterministic.
abstract final class MockGames {
  static const List<GameDetail> all = [
    // ── Slots ────────────────────────────────────────────────────────────────
    GameDetail(
      id: 'book-of-dead',
      name: 'Book of Dead',
      category: GameCategory.slots,
      provider: "Play'n GO",
      description:
          "Join Rich Wilde on his quest through ancient Egypt in this iconic 5-reel, 10-payline slot. "
          "A wild Egyptian book acts as both wild and scatter, triggering free spins with expanding symbols.",
      rtp: 96.21,
      volatility: Volatility.high,
      imageUrl: 'https://picsum.photos/seed/bookdead/400/300',
      isNew: false,
      isHot: true,
    ),
    GameDetail(
      id: 'gates-of-olympus',
      name: 'Gates of Olympus',
      category: GameCategory.slots,
      provider: 'Pragmatic Play',
      description:
          "Spin the reels in the realm of the gods and chase the all-powerful Zeus. "
          "6×5 tumbling reels with a buy-bonus feature and multiplier wilds up to 500×.",
      rtp: 96.50,
      volatility: Volatility.high,
      imageUrl: 'https://picsum.photos/seed/olympus/400/300',
      isNew: false,
      isHot: true,
    ),
    GameDetail(
      id: 'sweet-bonanza',
      name: 'Sweet Bonanza',
      category: GameCategory.slots,
      provider: 'Pragmatic Play',
      description:
          "A candy-themed pay-anywhere slot featuring tumble mechanics and bomb multipliers "
          "that can land anywhere on the 6×5 grid during free spins.",
      rtp: 96.48,
      volatility: Volatility.high,
      imageUrl: 'https://picsum.photos/seed/sweetbon/400/300',
      isNew: false,
      isHot: false,
    ),
    GameDetail(
      id: 'starburst',
      name: 'Starburst',
      category: GameCategory.slots,
      provider: 'NetEnt',
      description:
          "An all-time classic with its iconic jewel symbols and expanding wilds. "
          "5 reels, 10 paylines, both-ways-pay mechanic and re-spins on every wild.",
      rtp: 96.09,
      volatility: Volatility.low,
      imageUrl: 'https://picsum.photos/seed/starburst/400/300',
      isNew: false,
      isHot: false,
    ),
    GameDetail(
      id: 'wolf-gold',
      name: 'Wolf Gold',
      category: GameCategory.slots,
      provider: 'Pragmatic Play',
      description:
          "Howl under the moonlit desert sky in this 5-reel, 25-payline slot. "
          "Money respin feature and three progressive jackpots up for grabs.",
      rtp: 96.01,
      volatility: Volatility.medium,
      imageUrl: 'https://picsum.photos/seed/wolfgold/400/300',
      isNew: false,
      isHot: false,
    ),
    GameDetail(
      id: 'fire-joker',
      name: 'Fire Joker',
      category: GameCategory.slots,
      provider: "Play'n GO",
      description:
          "Classic three-reel, three-payline retro slot with a fiery twist. "
          "The Wheel of Multipliers can award multipliers up to 10× on any win.",
      rtp: 96.15,
      volatility: Volatility.medium,
      imageUrl: 'https://picsum.photos/seed/firejoker/400/300',
      isNew: true,
      isHot: false,
    ),

    // ── Live Casino ──────────────────────────────────────────────────────────
    GameDetail(
      id: 'lightning-roulette',
      name: 'Lightning Roulette',
      category: GameCategory.live,
      provider: 'Evolution',
      description:
          "European roulette supercharged with RNG Lucky Numbers struck by lightning. "
          "Up to 5 lucky numbers per round pay multiplied wins of 50×–500×.",
      rtp: 97.30,
      volatility: Volatility.medium,
      imageUrl: 'https://picsum.photos/seed/lightroul/400/300',
      isNew: false,
      isHot: true,
    ),
    GameDetail(
      id: 'crazy-time',
      name: 'Crazy Time',
      category: GameCategory.live,
      provider: 'Evolution',
      description:
          "A live money wheel with four thrilling bonus games: Coin Flip, Pachinko, "
          "Cash Hunt, and the show-stopping Crazy Time wheel itself.",
      rtp: 96.08,
      volatility: Volatility.high,
      imageUrl: 'https://picsum.photos/seed/crazytime/400/300',
      isNew: false,
      isHot: true,
    ),
    GameDetail(
      id: 'mega-ball',
      name: 'Mega Ball',
      category: GameCategory.live,
      provider: 'Evolution',
      description:
          "Lottery-style live game where up to 400 cards can win simultaneously. "
          "Mega Ball multipliers up to 1000× turn any winning card into a fortune.",
      rtp: 95.40,
      volatility: Volatility.high,
      imageUrl: 'https://picsum.photos/seed/megaball/400/300',
      isNew: true,
      isHot: false,
    ),
    GameDetail(
      id: 'deal-or-no-deal',
      name: 'Deal or No Deal',
      category: GameCategory.live,
      provider: 'Evolution',
      description:
          "Based on the iconic TV show — qualify in the top screen, open briefcases, "
          "and decide whether to accept the Banker's offer or play on for bigger wins.",
      rtp: 95.42,
      volatility: Volatility.medium,
      imageUrl: 'https://picsum.photos/seed/donddeal/400/300',
      isNew: false,
      isHot: false,
    ),

    // ── Table Games ──────────────────────────────────────────────────────────
    GameDetail(
      id: 'blackjack-classic',
      name: 'Blackjack Classic',
      category: GameCategory.table,
      provider: 'Evolution',
      description:
          "The casino staple — beat the dealer to 21 without going bust. "
          "Classic Vegas rules with split, double down, and insurance options.",
      rtp: 99.28,
      volatility: Volatility.low,
      imageUrl: 'https://picsum.photos/seed/blackjack/400/300',
      isNew: false,
      isHot: false,
    ),
    GameDetail(
      id: 'baccarat-pro',
      name: 'Baccarat Pro',
      category: GameCategory.table,
      provider: 'Evolution',
      description:
          "Elegant high-speed baccarat with Player, Banker, and Tie betting options. "
          "Squeeze feature available — feel the tension on every card reveal.",
      rtp: 98.76,
      volatility: Volatility.low,
      imageUrl: 'https://picsum.photos/seed/baccarat/400/300',
      isNew: false,
      isHot: false,
    ),
    GameDetail(
      id: 'texas-holdem',
      name: "Texas Hold'em",
      category: GameCategory.table,
      provider: 'Evolution',
      description:
          "The world's most popular poker variant. Two hole cards, five community cards, "
          "and the best five-card hand wins. Available in cash and tournament modes.",
      rtp: 98.50,
      volatility: Volatility.medium,
      imageUrl: 'https://picsum.photos/seed/holdem/400/300',
      isNew: false,
      isHot: false,
    ),
    GameDetail(
      id: 'casino-holdem',
      name: "Casino Hold'em",
      category: GameCategory.table,
      provider: 'Evolution',
      description:
          "Play Texas Hold'em against the house rather than other players. "
          "AA Bonus side bet awards up to 100× for a Royal Flush.",
      rtp: 98.40,
      volatility: Volatility.medium,
      imageUrl: 'https://picsum.photos/seed/casinohold/400/300',
      isNew: true,
      isHot: false,
    ),

    // ── Jackpot ──────────────────────────────────────────────────────────────
    GameDetail(
      id: 'mega-moolah',
      name: 'Mega Moolah',
      category: GameCategory.jackpot,
      provider: 'Pragmatic Play',
      description:
          "The legendary progressive jackpot slot — holder of multiple Guinness World Records "
          "for largest online slot payouts. Four jackpots: Mini, Minor, Major, and the Mega.",
      rtp: 88.12,
      volatility: Volatility.medium,
      imageUrl: 'https://picsum.photos/seed/megamoolah/400/300',
      isNew: false,
      isHot: true,
    ),
    GameDetail(
      id: 'divine-fortune',
      name: 'Divine Fortune',
      category: GameCategory.jackpot,
      provider: 'NetEnt',
      description:
          "Greek mythology meets life-changing jackpots. Three progressive jackpots, "
          "falling wilds, and a wild on wild feature make every spin thrilling.",
      rtp: 96.59,
      volatility: Volatility.medium,
      imageUrl: 'https://picsum.photos/seed/divinefort/400/300',
      isNew: true,
      isHot: false,
    ),
  ];

  /// Converts the full catalogue to lightweight [GameSummary] objects.
  static List<GameSummary> get summaries =>
      all.map((g) => g.toSummary()).toList();

  /// Finds a game by ID. Throws [StateError] if not found (dev-time safety).
  static GameDetail findById(String id) =>
      all.firstWhere((g) => g.id == id, orElse: () => throw StateError('Game not found: $id'));
}
