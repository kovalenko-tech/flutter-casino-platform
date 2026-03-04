part of '../profile_screen.dart';

class _Avatar extends StatelessWidget {
  final String initials;
  final ColorScheme colors;

  const _Avatar({required this.initials, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, colors.secondary],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(initials, style: AppTypography.headlineLarge(Colors.white)),
      ),
    );
  }
}
