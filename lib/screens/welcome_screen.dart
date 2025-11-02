import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() =>
      _WelcomeScreenState();
}

class _WelcomeScreenState
    extends State<WelcomeScreen> {
  final _nameController = TextEditingController();
  final _heightController =
      TextEditingController();
  final _weightController =
      TextEditingController();
  final _ageController = TextEditingController();

  String _selectedGender = 'male';

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Logo + tiêu đề
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration:
                          const BoxDecoration(
                            color: Color(
                              0xFF4CAF50,
                            ),
                            shape:
                                BoxShape.circle,
                          ),
                      child: const Icon(
                        Icons.restaurant_menu,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.welcome,
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                        color: const Color(
                          0xFF2E7D32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.welcomeSubtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Thông tin cá nhân
              _buildSectionTitle(
                l10n.personalInfo,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _nameController,
                label: l10n.fullName,
                icon: Icons.person,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _ageController,
                      label: l10n.age,
                      icon: Icons.cake,
                      keyboardType:
                          TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller:
                          _heightController,
                      label:
                          '${l10n.heightLabel} (cm)',
                      icon: Icons.height,
                      keyboardType:
                          TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _weightController,
                label: '${l10n.weightLabel} (kg)',
                icon: Icons.monitor_weight,
                keyboardType:
                    TextInputType.number,
              ),

              const SizedBox(height: 24),

              // Giới tính
              _buildSectionTitle(l10n.gender),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildGenderButton(
                      label: l10n.male,
                      icon: Icons.male,
                      value: 'male',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildGenderButton(
                      label: l10n.female,
                      icon: Icons.female,
                      value: 'female',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // —— dừng tại đây theo yêu cầu —— //
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF2E7D32),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildGenderButton({
    required String label,
    required IconData icon,
    required String value,
  }) {
    final isSelected = _selectedGender == value;
    return InkWell(
      onTap: () =>
          setState(() => _selectedGender = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4CAF50)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4CAF50)
                : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected
                  ? Colors.white
                  : Colors.grey[600],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
