import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/welcome_login_page.dart';

void main() {
  runApp(const BiyoKaabApp());
}

class BiyoKaabApp extends StatefulWidget {
  const BiyoKaabApp({super.key});

  @override
  State<BiyoKaabApp> createState() => BiyoKaabAppState();

  // Static access to toggle theme from anywhere
  static BiyoKaabAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<BiyoKaabAppState>();
}

class BiyoKaabAppState extends State<BiyoKaabApp> {
  bool _isDarkMode = true;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  bool get isDarkMode => _isDarkMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BiyoKaab',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // LIGHT THEME
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F0EB),
        primaryColor: const Color(0xFF00695C),
        cardColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF00695C)),
        textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
            .apply(
              bodyColor: const Color(0xFF2D3436),
              displayColor: const Color(0xFF2D3436),
            ),
      ),

      // DARK THEME
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1015),
        primaryColor: const Color(0xFF00E5FF),
        cardColor: const Color(0xFF151F28),
        iconTheme: const IconThemeData(color: Color(0xFF00E5FF)),
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: const Color(0xFFE0E0E0), displayColor: Colors.white),
      ),

      home: const WelcomeLoginPage(),
    );
  }
}
