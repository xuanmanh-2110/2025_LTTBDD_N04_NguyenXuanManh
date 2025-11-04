import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'l10n/app_localizations.dart';
import 'screens/intro_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/main_screen.dart';
import 'services/storage_service.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
  static MyAppState? of(BuildContext context) {
    return context
        .findAncestorStateOfType<MyAppState>();
  }
}

class MyAppState extends State<MyApp> {
  Locale _locale = const Locale('vi');

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final authService = AuthService();
    final languageCode = await authService
        .getCurrentLanguage();
    if (mounted) {
      setState(() {
        _locale = Locale(languageCode);
      });
    }
  }

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
      home: const AuthWrapper(),
      routes: {
        '/login': (context) =>
            const LoginScreen(),
        '/register': (context) =>
            const RegisterScreen(),
        '/intro': (context) =>
            const IntroScreen(),
        '/welcome': (context) =>
            const WelcomeScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() =>
      _AuthWrapperState();
}

class _AuthWrapperState
    extends State<AuthWrapper> {
  final StorageService _storageService =
      StorageService();
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  Widget _initialScreen = const IntroScreen();

  @override
  void initState() {
    super.initState();
    _determineInitialScreen();
  }

  Future<void> _determineInitialScreen() async {
    final isFirstLaunch = await _authService
        .isFirstLaunch();

    if (isFirstLaunch) {
      await _authService.markAsLaunched();
      if (mounted) {
        setState(() {
          _initialScreen = const IntroScreen();
          _isLoading = false;
        });
      }
      return;
    }

    final isLoggedIn = await _authService
        .isLoggedIn();

    if (!isLoggedIn) {
      if (mounted) {
        setState(() {
          _initialScreen = const LoginScreen();
          _isLoading = false;
        });
      }
      return;
    }

    final profile = await _storageService
        .getUserProfile();

    if (profile == null) {
      if (mounted) {
        setState(() {
          _initialScreen = const WelcomeScreen();
          _isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _initialScreen = const MainScreen();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF5FFF5),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF4CAF50),
          ),
        ),
      );
    }

    return _initialScreen;
  }
}
