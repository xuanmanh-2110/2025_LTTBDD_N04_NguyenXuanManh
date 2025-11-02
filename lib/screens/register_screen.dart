import 'package:flutter/material.dart';
import '../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController =
      TextEditingController();
  final _passwordController =
      TextEditingController();
  final _confirmController =
      TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
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
        title: Text(
          isVietnamese ? 'Đăng ký' : 'Register',
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  onTap: () => MyApp.of(context)
                      ?.setLocale(
                        const Locale('vi'),
                      ),
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
                  onTap: () => MyApp.of(context)
                      ?.setLocale(
                        const Locale('en'),
                      ),
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
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              // Logo/Icon
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

              // Title & subtitle
              Text(
                isVietnamese
                    ? 'Tạo tài khoản'
                    : 'Create account',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                isVietnamese
                    ? 'Điền thông tin để tiếp tục'
                    : 'Fill in your details to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Form
              TextField(
                controller: _nameController,
                textInputAction:
                    TextInputAction.next,
                decoration: InputDecoration(
                  labelText: isVietnamese
                      ? 'Họ và tên'
                      : 'Full name',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType:
                    TextInputType.emailAddress,
                textInputAction:
                    TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _obscure1,
                textInputAction:
                    TextInputAction.next,
                decoration: InputDecoration(
                  labelText: isVietnamese
                      ? 'Mật khẩu'
                      : 'Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    tooltip: isVietnamese
                        ? 'Hiện/ẩn mật khẩu'
                        : 'Show/hide password',
                    icon: Icon(
                      _obscure1
                          ? Icons
                                .visibility_outlined
                          : Icons
                                .visibility_off_outlined,
                    ),
                    onPressed: () => setState(
                      () =>
                          _obscure1 = !_obscure1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmController,
                obscureText: _obscure2,
                textInputAction:
                    TextInputAction.done,
                decoration: InputDecoration(
                  labelText: isVietnamese
                      ? 'Xác nhận mật khẩu'
                      : 'Confirm password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    tooltip: isVietnamese
                        ? 'Hiện/ẩn mật khẩu'
                        : 'Show/hide password',
                    icon: Icon(
                      _obscure2
                          ? Icons
                                .visibility_outlined
                          : Icons
                                .visibility_off_outlined,
                    ),
                    onPressed: () => setState(
                      () =>
                          _obscure2 = !_obscure2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF4CAF50,
                    ),
                    foregroundColor: Colors.white,
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
                        ? 'Đăng ký'
                        : 'Register',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
