import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';
import '../models/user_profile.dart';
import '../services/storage_service.dart';
import 'settings_screen.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() =>
      _PersonalScreenState();
}

class _PersonalScreenState
    extends State<PersonalScreen> {
  final StorageService _storageService =
      StorageService();
  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final profile = await _storageService
        .getUserProfile();
    setState(() {
      _userProfile = profile;
    });
  }

  void _showUpdateWeightDialog() {
    final l10n = AppLocalizations.of(context)!;
    final weightController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l10n.updateWeightTitle,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: weightController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: '${l10n.weightLabel} (kg)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final newWeight = double.tryParse(
                weightController.text,
              );
              if (newWeight != null &&
                  newWeight > 0) {
                final updatedProfile =
                    _userProfile?.copyWith(
                      weight: newWeight,
                      lastUpdated: DateTime.now(),
                    );

                if (updatedProfile != null) {
                  await _storageService
                      .saveUserProfile(
                        updatedProfile,
                      );
                  _loadUserProfile();
                }
              }
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                0xFF4CAF50,
              ),
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _showUpdateWaterGoalDialog() {
    final l10n = AppLocalizations.of(context)!;
    final waterController = TextEditingController(
      text: _userProfile?.waterGoal.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l10n.updateWaterGoalTitle,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: waterController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l10n.waterGoalLabel,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final newGoal = int.tryParse(
                waterController.text,
              );
              if (newGoal != null &&
                  newGoal > 0) {
                final updatedProfile =
                    _userProfile?.copyWith(
                      waterGoal: newGoal,
                    );

                if (updatedProfile != null) {
                  await _storageService
                      .saveUserProfile(
                        updatedProfile,
                      );
                  _loadUserProfile();
                }
              }
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                0xFF4CAF50,
              ),
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: Text(
          l10n.personal,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _userProfile == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Thông tin cá nhân
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                            16,
                          ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(
                                alpha: 0.1,
                              ),
                          blurRadius: 10,
                          offset: const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 80,
                          height: 80,
                          decoration:
                              BoxDecoration(
                                color:
                                    const Color(
                                      0xFF4CAF50,
                                    ),
                                shape: BoxShape
                                    .circle,
                              ),
                          child: Center(
                            child: Text(
                              _userProfile!
                                      .name
                                      .isNotEmpty
                                  ? _userProfile!
                                        .name[0]
                                        .toUpperCase()
                                  : 'U',
                              style:
                                  GoogleFonts.poppins(
                                    fontSize: 32,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    color: Colors
                                        .white,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          _userProfile!.name,
                          style:
                              GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${l10n.lastUpdated}: ${_userProfile!.lastUpdated.day}/${_userProfile!.lastUpdated.month}/${_userProfile!.lastUpdated.year}',
                          style:
                              GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors
                                    .grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Card BMI
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFA6E3B2,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                            16,
                          ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(
                                alpha: 0.1,
                              ),
                          blurRadius: 10,
                          offset: const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Text(
                              l10n.bmi,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight
                                        .bold,
                                color:
                                    const Color(
                                      0xFF2E7D32,
                                    ),
                              ),
                            ),
                            Icon(
                              Icons
                                  .monitor_weight,
                              color: const Color(
                                0xFF2E7D32,
                              ),
                              size: 24,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  l10n.heightLabel,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors
                                        .grey[700],
                                  ),
                                ),
                                Text(
                                  '${_userProfile!.height.toStringAsFixed(0)} cm',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  l10n.weightLabel,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors
                                        .grey[700],
                                  ),
                                ),
                                Text(
                                  '${_userProfile!.weight.toStringAsFixed(1)} kg',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(
                                16,
                              ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(
                                  12,
                                ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                l10n.yourBMI,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors
                                      .grey[700],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                _userProfile!.bmi
                                    .toStringAsFixed(
                                      1,
                                    ),
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  color:
                                      const Color(
                                        0xFF2E7D32,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                      horizontal:
                                          12,
                                      vertical: 4,
                                    ),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(
                                        0xFF4CAF50,
                                      ),
                                  borderRadius:
                                      BorderRadius.circular(
                                        20,
                                      ),
                                ),
                                child: Text(
                                  _userProfile!
                                      .bmiCategory,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors
                                        .white,
                                    fontWeight:
                                        FontWeight
                                            .w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed:
                                _showUpdateWeightDialog,
                            icon: const Icon(
                              Icons.edit,
                            ),
                            label: Text(
                              l10n.updateWeight,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(
                                    0xFF4CAF50,
                                  ),
                              foregroundColor:
                                  Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Card Mục tiêu nước
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius:
                          BorderRadius.circular(
                            16,
                          ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(
                                alpha: 0.1,
                              ),
                          blurRadius: 10,
                          offset: const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Text(
                              l10n.waterGoal,
                              style:
                                  GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    color: Colors
                                        .blue[700],
                                  ),
                            ),
                            Icon(
                              Icons.water_drop,
                              color: Colors
                                  .blue[700],
                              size: 24,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(
                                16,
                              ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(
                                  12,
                                ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                l10n.shouldDrinkDaily,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors
                                      .grey[700],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${(_userProfile!.waterGoal / 1000).toStringAsFixed(1)} L',
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  color: Colors
                                      .blue[700],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '(35ml × ${_userProfile!.weight.toStringAsFixed(0)}kg)',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors
                                      .grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final newGoal =
                                      (_userProfile!.waterGoal -
                                              250)
                                          .clamp(
                                            500,
                                            5000,
                                          );
                                  final updatedProfile =
                                      _userProfile!.copyWith(
                                        waterGoal:
                                            newGoal,
                                      );
                                  await _storageService
                                      .saveUserProfile(
                                        updatedProfile,
                                      );
                                  _loadUserProfile();
                                },
                                icon: const Icon(
                                  Icons.remove,
                                ),
                                label: const Text(
                                  '-250ml',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors
                                          .red[100],
                                  foregroundColor:
                                      Colors
                                          .red[700],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final newGoal =
                                      (_userProfile!.waterGoal +
                                              250)
                                          .clamp(
                                            500,
                                            5000,
                                          );
                                  final updatedProfile =
                                      _userProfile!.copyWith(
                                        waterGoal:
                                            newGoal,
                                      );
                                  await _storageService
                                      .saveUserProfile(
                                        updatedProfile,
                                      );
                                  _loadUserProfile();
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                                label: const Text(
                                  '+250ml',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors
                                          .green[100],
                                  foregroundColor:
                                      Colors
                                          .green[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed:
                                _showUpdateWaterGoalDialog,
                            icon: const Icon(
                              Icons.edit,
                            ),
                            label: Text(
                              l10n.customizeGoal,
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  Colors
                                      .blue[700],
                              side: BorderSide(
                                color: Colors
                                    .blue[700]!,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
