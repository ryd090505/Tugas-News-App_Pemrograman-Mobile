import 'package:flutter/material.dart';

/// Kelas untuk menyimpan konstanta warna aplikasi
class AppColors {
  static const Color primary = Color(0xFF00B5D8);      
  static const Color background = Color(0xFF121212);   
  static const Color surface = Color(0xFF1E1E1E);     
  static const Color card = Color(0xFF222222);         
  static const Color textPrimary = Color(0xFFEDEDED);  
  static const Color textSecondary = Color(0xFF9A9A9A); 
  static const Color error = Color(0xFFEF476F);

  static List<BoxShadow> neumorphismOuter({
    double blur = 14,
    double offset = 8,
    double opacityDark = 0.55,
    double opacityLight = 0.06,
  }) {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(opacityDark),
        offset: Offset(offset, offset),
        blurRadius: blur,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Colors.white.withOpacity(opacityLight),
        offset: Offset(-offset / 2, -offset / 2),
        blurRadius: blur / 1.5,
        spreadRadius: 0,
      ),
    ];
  }

  static List<BoxShadow> neumorphismAccentGlow({double blur = 18}) {
    return [
      BoxShadow(
        color: primary.withOpacity(0.12),
        offset: Offset(0, 6),
        blurRadius: blur,
      ),
    ];
  }
}
