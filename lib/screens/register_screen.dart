import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController =
      TextEditingController();
  final _passwordController =
      TextEditingController();
  final _confirmPasswordController =
      TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    final success = await _authService.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      name: _nameController.text.trim(),
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }

    if (success) {
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacementNamed('/welcome');
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
                  ? 'Email đã được sử dụng'
                  : 'Email already exists',
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF2D2D2D),
          ),
          onPressed: () =>
              Navigator.of(context).pop(),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 16,
              top: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.1,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () =>
                      _changeLanguage('vi'),
                  borderRadius:
                      const BorderRadius.horizontal(
                        left: Radius.circular(20),
                      ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                    decoration: BoxDecoration(
                      color: isVietnamese
                          ? const Color(
                              0xFF4CAF50,
                            )
                          : Colors.transparent,
                      borderRadius:
                          const BorderRadius.horizontal(
                            left: Radius.circular(
                              20,
                            ),
                          ),
                    ),
                    child: Text(
                      'VI',
                      style: TextStyle(
                        color: isVietnamese
                            ? Colors.white
                            : Colors.grey[700],
                        fontWeight:
                            FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  color: Colors.grey[300],
                ),
                InkWell(
                  onTap: () =>
                      _changeLanguage('en'),
                  borderRadius:
                      const BorderRadius.horizontal(
                        right: Radius.circular(
                          20,
                        ),
                      ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                    decoration: BoxDecoration(
                      color: !isVietnamese
                          ? const Color(
                              0xFF4CAF50,
                            )
                          : Colors.transparent,
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
                        color: !isVietnamese
                            ? Colors.white
                            : Colors.grey[700],
                        fontWeight:
                            FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
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
                  Icons.person_add_outlined,
                  size: 50,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                isVietnamese
                    ? 'Đăng Ký'
                    : 'Register',
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
                    ? 'Tạo tài khoản mới'
                    : 'Create a new account',
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: isVietnamese
                            ? 'Họ và tên'
                            : 'Full Name',
                        hintText: isVietnamese
                            ? 'Nhập họ và tên'
                            : 'Enter your full name',
                        prefixIcon: const Icon(
                          Icons.person_outline,
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
                              ? 'Vui lòng nhập họ và tên'
                              : 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                        if (value.length < 6) {
                          return isVietnamese
                              ? 'Mật khẩu phải có ít nhất 6 ký tự'
                              : 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller:
                          _confirmPasswordController,
                      obscureText:
                          _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: isVietnamese
                            ? 'Xác nhận mật khẩu'
                            : 'Confirm Password',
                        hintText: isVietnamese
                            ? 'Nhập lại mật khẩu'
                            : 'Re-enter your password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons
                                      .visibility_outlined
                                : Icons
                                      .visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
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
                              ? 'Vui lòng xác nhận mật khẩu'
                              : 'Please confirm your password';
                        }
                        if (value !=
                            _passwordController
                                .text) {
                          return isVietnamese
                              ? 'Mật khẩu không khớp'
                              : 'Passwords do not match';
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
                            : _register,
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
                                    ? 'Đăng Ký'
                                    : 'Register',
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
                        ? 'Đã có tài khoản? '
                        : 'Already have an account? ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(
                      context,
                    ).pop(),
                    child: Text(
                      isVietnamese
                          ? 'Đăng Nhập'
                          : 'Login',
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
