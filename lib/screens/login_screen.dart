import 'package:flutter/material.dart';
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
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitDemo() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final isVietnamese =
        Localizations.localeOf(
          context,
        ).languageCode ==
        'vi';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isVietnamese
              ? 'chỉ kiểm tra hợp lệ, chưa đăng nhập.'
              : 'validated only, no sign-in.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Đổi ngôn ngữ
  void _changeLanguage(String languageCode) {
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      if (mounted) {
        MyApp.of(
          context,
        )?.setLocale(Locale(languageCode));
      }
    });
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
              // Toggle VI/EN
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
                              .withOpacity(0.1),
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

              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF4CAF50,
                  ).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 50,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: 32),

              // Title
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

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller:
                          _emailController,
                      keyboardType: TextInputType
                          .emailAddress,
                      textInputAction:
                          TextInputAction.next,
                      autofillHints: const [
                        AutofillHints.username,
                        AutofillHints.email,
                      ],
                      onFieldSubmitted: (_) =>
                          FocusScope.of(
                            context,
                          ).nextFocus(),
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
                            value
                                .trim()
                                .isEmpty) {
                          return isVietnamese
                              ? 'Vui lòng nhập email'
                              : 'Please enter your email';
                        }
                        final v = value.trim();
                        final ok = RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(v);
                        if (!ok) {
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
                      textInputAction:
                          TextInputAction.done,
                      autofillHints: const [
                        AutofillHints.password,
                      ],
                      onFieldSubmitted: (_) =>
                          _submitDemo(),
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
                          tooltip: isVietnamese
                              ? 'Hiện/ẩn mật khẩu'
                              : 'Show/hide password',
                          icon: Icon(
                            _obscurePassword
                                ? Icons
                                      .visibility_outlined
                                : Icons
                                      .visibility_off_outlined,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword =
                                !_obscurePassword,
                          ),
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
                        onPressed: _submitDemo,
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
                        child: Text(
                          isVietnamese
                              ? 'Đăng Nhập'
                              : 'Login',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Register link
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
                    onTap: () => Navigator.of(
                      context,
                    ).pushNamed('/register'),
                    child: Text(
                      isVietnamese
                          ? 'Đăng ký ngay'
                          : 'Register Now',
                      style: const TextStyle(
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
