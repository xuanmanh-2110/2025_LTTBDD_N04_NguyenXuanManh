import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'l10n/app_localizations.dart';
import 'screens/intro_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      debugShowCheckedModeBanner: false,

      localeResolutionCallback:
          (deviceLocale, supported) {
            if (deviceLocale == null)
              return const Locale('en');
            final lang =
                deviceLocale.languageCode;
            if (supported.any(
              (l) => l.languageCode == lang,
            )) {
              return Locale(lang);
            }
            return const Locale('vi');
          },

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
      },
    );
  }
}
