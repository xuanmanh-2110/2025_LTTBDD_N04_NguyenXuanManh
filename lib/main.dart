import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'l10n/app_localizations.dart';
import 'screens/intro_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  // Method để access state từ bên ngoài
  static MyAppState? of(BuildContext context) {
    return context
        .findAncestorStateOfType<MyAppState>();
  }
}

class MyAppState extends State<MyApp> {
  Locale _locale = const Locale('vi');

  // Method để đổi ngôn ngữ
  void setLocale(Locale locale) {
    if (mounted && _locale != locale) {
      setState(() {
        _locale = locale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'),
        Locale('en'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const IntroScreen(),
      routes: {
        '/intro': (context) =>
            const IntroScreen(),
        '/login': (context) =>
            const LoginScreen(),
        '/register': (context) =>
            const RegisterScreen(),
        '/welcome': (context) =>
            const WelcomeScreen(),
      },
    );
  }
}
