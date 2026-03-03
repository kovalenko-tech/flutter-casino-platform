import 'package:equatable/equatable.dart';

/// Promotional banner entity displayed in the home screen hero carousel.
class PromoBanner extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String ctaLabel;
  final String imageUrl;

  const PromoBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, subtitle, ctaLabel, imageUrl];
}
