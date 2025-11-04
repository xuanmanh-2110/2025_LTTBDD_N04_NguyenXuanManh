import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController();
  final _passwordController =
      TextEditingController();
  final _authService = AuthService();
  final _storageService = StorageService();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    final success = await _authService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }

    if (success) {
      final profile = await _storageService
          .getUserProfile();

      if (mounted) {
        if (profile != null) {
          Navigator.of(
            context,
          ).pushReplacementNamed('/main');
        } else {
          Navigator.of(
            context,
          ).pushReplacementNamed('/welcome');
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              Localizations.localeOf(
                        context,
                      ).languageCode ==
                      'vi'
                  ? 'Email hoặc mật khẩu không đúng'
                  : 'Invalid email or password',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _changeLanguage(
    String languageCode,
  ) async {
    await _authService.setLanguage(languageCode);
    if (mounted) {
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

  @override
  Widget build(BuildContext context) {
    final isVietnamese =
        Localizations.localeOf(
          context,
        ).languageCode ==
        'vi';

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                            20,
                          ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(
                                alpha: 0.1,
                              ),
                          blurRadius: 8,
                          offset: const Offset(
                            0,
                            2,
                          ),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () =>
                              _changeLanguage(
                                'vi',
                              ),
                          borderRadius:
                              const BorderRadius.horizontal(
                                left:
                                    Radius.circular(
                                      20,
                                    ),
                              ),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                            decoration: BoxDecoration(
                              color: isVietnamese
                                  ? const Color(
                                      0xFF4CAF50,
                                    )
                                  : Colors
                                        .transparent,
                              borderRadius:
                                  const BorderRadius.horizontal(
                                    left:
                                        Radius.circular(
                                          20,
                                        ),
                                  ),
                            ),
                            child: Text(
                              'VI',
                              style: TextStyle(
                                color:
                                    isVietnamese
                                    ? Colors.white
                                    : Colors
                                          .grey[700],
                                fontWeight:
                                    FontWeight
                                        .w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        InkWell(
                          onTap: () =>
                              _changeLanguage(
                                'en',
                              ),
                          borderRadius:
                              const BorderRadius.horizontal(
                                right:
                                    Radius.circular(
                                      20,
                                    ),
                              ),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                            decoration: BoxDecoration(
                              color: !isVietnamese
                                  ? const Color(
                                      0xFF4CAF50,
                                    )
                                  : Colors
                                        .transparent,
                              borderRadius:
                                  const BorderRadius.horizontal(
                                    right:
                                        Radius.circular(
                                          20,
                                        ),
                                  ),
                            ),
                            child: Text(
                              'EN',
                              style: TextStyle(
                                color:
                                    !isVietnamese
                                    ? Colors.white
                                    : Colors
                                          .grey[700],
                                fontWeight:
                                    FontWeight
                                        .w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF4CAF50,
                  ).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 50,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                isVietnamese
                    ? 'Đăng Nhập'
                    : 'Login',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                isVietnamese
                    ? 'Chào mừng trở lại!'
                    : 'Welcome back!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller:
                          _emailController,
                      keyboardType: TextInputType
                          .emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: isVietnamese
                            ? 'Nhập email của bạn'
                            : 'Enter your email',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                                12,
                              ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return isVietnamese
                              ? 'Vui lòng nhập email'
                              : 'Please enter your email';
                        }
                        if (!value.contains(
                          '@',
                        )) {
                          return isVietnamese
                              ? 'Email không hợp lệ'
                              : 'Invalid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller:
                          _passwordController,
                      obscureText:
                          _obscurePassword,
                      decoration: InputDecoration(
                        labelText: isVietnamese
                            ? 'Mật khẩu'
                            : 'Password',
                        hintText: isVietnamese
                            ? 'Nhập mật khẩu'
                            : 'Enter your password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons
                                      .visibility_outlined
                                : Icons
                                      .visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                                  !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                                12,
                              ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return isVietnamese
                              ? 'Vui lòng nhập mật khẩu'
                              : 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(
                                0xFF4CAF50,
                              ),
                          foregroundColor:
                              Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                  27,
                                ),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                    CircularProgressIndicator(
                                      color: Colors
                                          .white,
                                      strokeWidth:
                                          2,
                                    ),
                              )
                            : Text(
                                isVietnamese
                                    ? 'Đăng Nhập'
                                    : 'Login',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    isVietnamese
                        ? 'Chưa có tài khoản? '
                        : "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed('/register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
