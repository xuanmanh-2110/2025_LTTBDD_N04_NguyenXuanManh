import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() =>
      _JournalScreenState();
}

class _JournalScreenState
    extends State<JournalScreen> {
  final StorageService _storageService =
      StorageService();

  int _todayCalories = 0;
  Map<String, double> _todayMacros = {
    'carbs': 0,
    'protein': 0,
    'fat': 0,
  };
  int _dailyCalorieGoal = 2000; // mặc định

  @override
  void initState() {
    super.initState();
    _loadTodayData();
  }

  Future<void> _loadTodayData() async {
    final calories = await _storageService
        .getTodayCalorieIntake();
    final macros = await _storageService
        .getTodayMacros();

    final profile = await _storageService
        .getUserProfile();

    setState(() {
      _todayCalories = calories;
      _todayMacros = macros;
      if (profile != null) {
        _dailyCalorieGoal =
            profile.dailyCalorieGoal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFF5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // Tiêu đề + ngày
                Text(
                  l10n.todayJournal,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(
                      0xFF2E7D32,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Card tổng calo
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
                        BorderRadius.circular(16),
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
                      Text(
                        l10n.totalCaloriesNeeded,
                        style:
                            GoogleFonts.poppins(
                              fontSize: 16,
                              color: const Color(
                                0xFF2E7D32,
                              ),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_dailyCalorieGoal kcal',
                        style:
                            GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight:
                                  FontWeight.bold,
                              color: const Color(
                                0xFF2E7D32,
                              ),
                            ),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value:
                            (_dailyCalorieGoal ==
                                0)
                            ? 0
                            : (_todayCalories /
                                      _dailyCalorieGoal)
                                  .clamp(0, 1),
                        backgroundColor:
                            Colors.white,
                        valueColor:
                            const AlwaysStoppedAnimation<
                              Color
                            >(Color(0xFF4CAF50)),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${l10n.consumed}: $_todayCalories kcal',
                        style:
                            GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(
                                0xFF2E7D32,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Card Macros
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16),
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
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.macroNutrients,
                        style:
                            GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                              color: const Color(
                                0xFF2E7D32,
                              ),
                            ),
                      ),
                      const SizedBox(height: 16),
                      _buildMacroBar(
                        'Carbs',
                        _todayMacros['carbs']!,
                        250,
                        Colors.orange,
                      ),
                      const SizedBox(height: 12),
                      _buildMacroBar(
                        'Protein',
                        _todayMacros['protein']!,
                        150,
                        Colors.red,
                      ),
                      const SizedBox(height: 12),
                      _buildMacroBar(
                        'Fat',
                        _todayMacros['fat']!,
                        65,
                        Colors.yellow,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMacroBar(
    String name,
    double current,
    double goal,
    Color color,
  ) {
    final percentage = (current / goal).clamp(
      0.0,
      1.0,
    );
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${current.toStringAsFixed(0)}g / ${goal.toStringAsFixed(0)}g',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[200],
          valueColor:
              AlwaysStoppedAnimation<Color>(
                color,
              ),
          minHeight: 6,
        ),
      ],
    );
  }
}
