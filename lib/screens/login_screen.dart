import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final _emailController =
      TextEditingController();
  final _passwordController =
      TextEditingController();
  bool _obscurePassword =
      true; // Ẩn/hiện mật khẩu

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isVietnamese =
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
              const SizedBox(height: 24),
              // Logo
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

              // Form đăng nhập
              Column(
                children: [
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType
                        .emailAddress,
                    textInputAction:
                        TextInputAction.next,
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
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller:
                        _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction:
                        TextInputAction.done,
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
                  ),
                  const SizedBox(height: 24),

                  // Nút đăng nhập
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: null,
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
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
