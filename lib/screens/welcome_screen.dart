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
  String _selectedGoal = 'maintain';
  String _selectedActivity = 'sedentary';

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _demoOnly() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${l10n.welcome}: UI demo only, no save.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
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

              // Logo & title
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

              // Personal info (TextField UI-only, KHÔNG validator)
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

              // Gender
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

              const SizedBox(height: 24),

              // Goal
              _buildSectionTitle(l10n.yourGoal),
              const SizedBox(height: 12),
              _buildGoalCard(
                title: l10n.loseWeight,
                subtitle: l10n.loseWeightDesc,
                icon: Icons.trending_down,
                value: 'lose',
                color: Colors.orange,
              ),
              const SizedBox(height: 12),
              _buildGoalCard(
                title: l10n.maintainWeight,
                subtitle: l10n.maintainWeightDesc,
                icon: Icons.horizontal_rule,
                value: 'maintain',
                color: Colors.blue,
              ),
              const SizedBox(height: 12),
              _buildGoalCard(
                title: l10n.gainWeight,
                subtitle: l10n.gainWeightDesc,
                icon: Icons.trending_up,
                value: 'gain',
                color: Colors.green,
              ),

              const SizedBox(height: 24),

              // Activity
              _buildSectionTitle(
                l10n.activityLevel,
              ),
              const SizedBox(height: 12),
              _buildActivityDropdown(l10n),

              const SizedBox(height: 32),

              // Start Button — UI-only
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // CHỌN 1: disable hẳn (UI thuần & không bấm được):
                  // onPressed: null,

                  // CHỌN 2: cho bấm để hiện SnackBar demo:
                  onPressed: _demoOnly,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF4CAF50,
                    ),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                            12,
                          ),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    l10n.getStarted,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
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

  Widget _buildGoalCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required Color color,
  }) {
    final isSelected = _selectedGoal == value;
    return InkWell(
      onTap: () =>
          setState(() => _selectedGoal = value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4CAF50)
                : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: 0.1,
                ),
                borderRadius:
                    BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF4CAF50),
                size: 28,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityDropdown(
    AppLocalizations l10n,
  ) {
    final activities = [
      {
        'value': 'sedentary',
        'label': l10n.sedentary,
        'desc': l10n.sedentaryDesc,
      },
      {
        'value': 'light',
        'label': l10n.lightlyActive,
        'desc': l10n.lightlyActiveDesc,
      },
      {
        'value': 'moderate',
        'label': l10n.moderatelyActive,
        'desc': l10n.moderatelyActiveDesc,
      },
      {
        'value': 'very',
        'label': l10n.veryActive,
        'desc': l10n.veryActiveDesc,
      },
      {
        'value': 'extra',
        'label': l10n.extraActive,
        'desc': l10n.extraActiveDesc,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedActivity,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[800],
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(
                () =>
                    _selectedActivity = newValue,
              );
            }
          },
          items: activities.map((activity) {
            return DropdownMenuItem<String>(
              value: activity['value'],
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    activity['label']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    activity['desc']!,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
