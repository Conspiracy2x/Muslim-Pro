import 'package:flutter/material.dart';

class GradientTheme extends ThemeExtension<GradientTheme> {
  final LinearGradient cardGradient;

  GradientTheme({required this.cardGradient});

  @override
  GradientTheme copyWith({LinearGradient? cardGradient}) {
    return GradientTheme(
      cardGradient: cardGradient ?? this.cardGradient,
    );
  }

  @override
  GradientTheme lerp(ThemeExtension<GradientTheme>? other, double t) {
    if (other is! GradientTheme) return this;
    return GradientTheme(
      cardGradient: LinearGradient.lerp(cardGradient, other.cardGradient, t)!,
    );
  }

  static final light = GradientTheme(
    cardGradient: LinearGradient(
      colors: [Colors.greenAccent.shade200, Colors.green],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static final dark = GradientTheme(
    cardGradient: LinearGradient(
      colors: [Colors.green.shade900, Colors.black87],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}
