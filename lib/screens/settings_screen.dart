import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  final _authService = AuthService();
  String _currentLanguage = 'vi';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final language = await _authService
        .getCurrentLanguage();
    if (mounted) {
      setState(() {
        _currentLanguage = language;
      });
    }
  }

  Future<void> _changeLanguage(
    String languageCode,
  ) async {
    await _authService.setLanguage(languageCode);
    if (mounted) {
      setState(() {
        _currentLanguage = languageCode;
      });
      WidgetsBinding.instance
          .addPostFrameCallback((_) {
            if (mounted) {
              MyApp.of(
                context,
              )?.setLocale(Locale(languageCode));
            }
          });
    }
  }

  Future<void> _logout() async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(true),
            child: Text(
              l10n.logout,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _authService.logout();
      if (mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFF5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF2D2D2D),
          ),
          onPressed: () =>
              Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.settings,
          style: const TextStyle(
            color: Color(0xFF2D2D2D),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Text(
                    l10n.language,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () =>
                          _changeLanguage('vi'),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.language,
                              color: Color(
                                0xFF4CAF50,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Text(
                                l10n.vietnamese,
                              ),
                            ),
                            if (_currentLanguage ==
                                'vi')
                              const Icon(
                                Icons
                                    .check_circle,
                                color: Color(
                                  0xFF4CAF50,
                                ),
                              )
                            else
                              Icon(
                                Icons
                                    .circle_outlined,
                                color: Colors
                                    .grey[400],
                              ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    InkWell(
                      onTap: () =>
                          _changeLanguage('en'),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.language,
                              color: Color(
                                0xFF4CAF50,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Text(
                                l10n.english,
                              ),
                            ),
                            if (_currentLanguage ==
                                'en')
                              const Icon(
                                Icons
                                    .check_circle,
                                color: Color(
                                  0xFF4CAF50,
                                ),
                              )
                            else
                              Icon(
                                Icons
                                    .circle_outlined,
                                color: Colors
                                    .grey[400],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Text(
                    l10n.account,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: Text(
                    l10n.logout,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: _logout,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
