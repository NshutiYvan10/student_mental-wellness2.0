// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AppTheme {
//   // Design tokens aligned with previous project (todo_app)
//   static const Color primaryColor = Color(0xFF6366F1); // Indigo 500
//   static const Color secondaryColor = Color(0xFF8B5CF6); // Purple 500
//   static const Color accentColor = Color(0xFF06B6D4); // Cyan 500
//   static const Color successColor = Color(0xFF10B981); // Emerald 500
//   static const Color warningColor = Color(0xFFF59E0B); // Amber 500
//   static const Color errorColor = Color(0xFFEF4444); // Red 500
//
//   // Subtle, calm scaffold background
//   static const Color softBg = Color(0xFFF8FAFC);
//
//   static ThemeData get lightTheme {
//     final base = ThemeData.light(useMaterial3: true);
//     const colorScheme = ColorScheme.light(
//       primary: primaryColor,
//       secondary: secondaryColor,
//       tertiary: accentColor,
//       surface: Colors.white,
//       error: errorColor,
//     );
//     return base.copyWith(
//       colorScheme: colorScheme,
//       scaffoldBackgroundColor: softBg,
//       textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
//         displayLarge: GoogleFonts.poppins(fontWeight: FontWeight.w700),
//         displayMedium: GoogleFonts.poppins(fontWeight: FontWeight.w700),
//         displaySmall: GoogleFonts.poppins(fontWeight: FontWeight.w700),
//         headlineLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         headlineMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         headlineSmall: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         bodyLarge: GoogleFonts.inter(),
//         bodyMedium: GoogleFonts.inter(),
//         bodySmall: GoogleFonts.inter(),
//         labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w600),
//         labelMedium: GoogleFonts.inter(fontWeight: FontWeight.w600),
//         labelSmall: GoogleFonts.inter(fontWeight: FontWeight.w600),
//       ),
//       appBarTheme: base.appBarTheme.copyWith(
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black87,
//       ),
//       cardTheme: CardThemeData(
//         elevation: 2,
//         clipBehavior: Clip.antiAlias,
//         margin: EdgeInsets.zero,
//         surfaceTintColor: Colors.white,
//         shadowColor: Colors.black12,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         color: Colors.white,
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Colors.grey[50],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: primaryColor, width: 2),
//         ),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           elevation: 0,
//           backgroundColor: primaryColor,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//       filledButtonTheme: FilledButtonThemeData(
//         style: FilledButton.styleFrom(
//           backgroundColor: secondaryColor,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//       chipTheme: base.chipTheme.copyWith(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       ),
//     );
//   }
//
//   static ThemeData get darkTheme {
//     final base = ThemeData.dark(useMaterial3: true);
//     const colorScheme = ColorScheme.dark(
//       primary: primaryColor,
//       secondary: secondaryColor,
//       tertiary: accentColor,
//       surface: Color(0xFF1E293B),
//       error: errorColor,
//     );
//     return base.copyWith(
//       colorScheme: colorScheme,
//       textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
//       scaffoldBackgroundColor: const Color(0xFF0F172A),
//       cardTheme: CardThemeData(
//         elevation: 2,
//         surfaceTintColor: const Color(0xFF1E293B),
//         shadowColor: Colors.black54,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         color: const Color(0xFF1E293B),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: const Color(0xFF334155),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF475569)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF475569)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: primaryColor, width: 2),
//         ),
//       ),
//     );
//   }
// }
//
//









// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AppTheme {
//   // New Professional Color Palette
//   static const Color primaryColor = Color(0xFF005B60); // Deep Teal
//   static const Color secondaryColor = Color(0xFF439A86); // Lighter Teal for Gradients
//   static const Color accentColor = Color(0xFFFFAB76); // Warm Peach
//   static const Color backgroundColor = Color(0xFFF8F7F4); // Cream White
//   static const Color surfaceColor = Color(0xFFFFFFFF);
//   static const Color textPrimaryColor = Color(0xFF1C1C1E); // Off-Black
//   static const Color textSecondaryColor = Color(0xFF6D6D72); // Grey
//   static const Color errorColor = Color(0xFFD9534F);
//
//   // New Typography using a single font family for consistency
//   static final TextTheme _textTheme = GoogleFonts.soraTextTheme().copyWith(
//     displaySmall: GoogleFonts.sora(
//         fontWeight: FontWeight.bold, fontSize: 34, color: textPrimaryColor),
//     headlineMedium: GoogleFonts.sora(
//         fontWeight: FontWeight.bold, fontSize: 28, color: textPrimaryColor),
//     titleLarge: GoogleFonts.sora(
//         fontWeight: FontWeight.w600, fontSize: 22, color: textPrimaryColor),
//     titleMedium: GoogleFonts.sora(
//         fontWeight: FontWeight.w600, fontSize: 16, color: textPrimaryColor),
//     bodyLarge: GoogleFonts.sora(
//         fontSize: 16, color: textSecondaryColor, height: 1.5),
//     bodyMedium: GoogleFonts.sora(fontSize: 14, color: textSecondaryColor),
//     labelLarge: GoogleFonts.sora(
//         fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
//   );
//
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       primaryColor: primaryColor,
//       scaffoldBackgroundColor: backgroundColor,
//       colorScheme: const ColorScheme.light(
//         primary: primaryColor,
//         secondary: secondaryColor,
//         tertiary: accentColor,
//         surface: surfaceColor,
//         background: backgroundColor,
//         error: errorColor,
//         onPrimary: Colors.white,
//         onSecondary: Colors.white,
//         onSurface: textPrimaryColor,
//         onBackground: textPrimaryColor,
//         onError: Colors.white,
//       ),
//       textTheme: _textTheme,
//       appBarTheme: AppBarTheme(
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: textPrimaryColor),
//         titleTextStyle: _textTheme.titleLarge,
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: const Color(0xFFF0F0F0),
//         contentPadding:
//         const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: primaryColor, width: 2),
//         ),
//         labelStyle: _textTheme.bodyLarge?.copyWith(color: textSecondaryColor),
//         prefixIconColor: textSecondaryColor,
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: accentColor,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(vertical: 18),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: _textTheme.labelLarge,
//           elevation: 2,
//           shadowColor: accentColor.withOpacity(0.3),
//         ),
//       ),
//     );
//   }
//
//   // A consistent dark theme can be defined here later
//   static ThemeData get darkTheme => lightTheme; // For now, defaulting to light
// }


















import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A professional, calming, and modern design system for the app.
class AppTheme {
  // 1. Color Palette
  static const Color primaryColor = Color(0xFF005B60); // Deep Teal
  static const Color secondaryColor = Color(0xFF439A86); // Lighter Teal
  static const Color accentColor = Color(0xFFFFAB76); // Warm Peach
  static const Color backgroundColor = Color(0xFFF8F7F4); // Cream White
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textPrimaryColor = Color(0xFF1C1C1E); // Off-Black
  static const Color textSecondaryColor = Color(0xFF6D6D72); // Grey
  static const Color errorColor = Color(0xFFD9534F);

  // 2. Typography (using a single, versatile font family)
  static final TextTheme _textTheme = GoogleFonts.soraTextTheme().copyWith(
    displaySmall: GoogleFonts.sora(
        fontWeight: FontWeight.bold, fontSize: 34, color: textPrimaryColor, height: 1.2),
    headlineMedium: GoogleFonts.sora(
        fontWeight: FontWeight.bold, fontSize: 28, color: textPrimaryColor),
    titleLarge: GoogleFonts.sora(
        fontWeight: FontWeight.w600, fontSize: 22, color: textPrimaryColor),
    titleMedium: GoogleFonts.sora(
        fontWeight: FontWeight.w600, fontSize: 16, color: textPrimaryColor),
    bodyLarge: GoogleFonts.sora(
        fontSize: 16, color: textSecondaryColor, height: 1.5),
    bodyMedium: GoogleFonts.sora(fontSize: 14, color: textSecondaryColor),
    labelLarge: GoogleFonts.sora(
        fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
  );

  // 3. Light Theme Definition
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryColor,
        onBackground: textPrimaryColor,
        onError: Colors.white,
      ),
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: textPrimaryColor),
        titleTextStyle: _textTheme.titleLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        labelStyle: _textTheme.bodyLarge?.copyWith(color: textSecondaryColor),
        prefixIconColor: textSecondaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: _textTheme.labelLarge,
          elevation: 4,
          shadowColor: accentColor.withOpacity(0.4),
        ),
      ),
    );
  }

  // A consistent dark theme can be defined here later
  static ThemeData get darkTheme => lightTheme; // For now, defaulting to light
}
























