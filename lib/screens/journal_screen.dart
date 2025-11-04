import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() =>
      _JournalScreenState();
}

class _JournalScreenState
    extends State<JournalScreen> {
  final int _todayCalories = 1200;
  final int _dailyCalorieGoal = 2000;

  final Map<String, double> _todayMacros = const {
    'carbs': 130,
    'protein': 60,
    'fat': 35,
  };

  final int _todayWater = 1200;
  final int _waterGoal = 2000;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final perGlass = (_waterGoal / 10);
    final filledGlasses = (_todayWater / perGlass)
        .floor()
        .clamp(0, 10);

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
                            (_todayCalories /
                                    _dailyCalorieGoal)
                                .clamp(0.0, 1.0),
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
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
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
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          Text(
                            l10n.waterIntake,
                            style:
                                GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  color: Colors
                                      .blue[700],
                                ),
                          ),
                          Icon(
                            Icons.water_drop,
                            color:
                                Colors.blue[700],
                            size: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${(_todayWater / 1000).toStringAsFixed(1)} / ${(_waterGoal / 1000).toStringAsFixed(1)} L',
                        style:
                            GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                              color: Colors
                                  .blue[700],
                            ),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio:
                                  0.8,
                            ),
                        itemCount: 10,
                        itemBuilder:
                            (context, index) {
                              final isFilled =
                                  index <
                                  filledGlasses;
                              return _WaterGlassTile(
                                isFilled:
                                    isFilled,
                                mlPerGlass:
                                    perGlass
                                        .round(),
                              );
                            },
                      ),

                      const SizedBox(height: 12),
                      Row(
                        children: const [
                          Expanded(
                            child:
                                _DisabledOutlined(
                                  text:
                                      'Goal 1.5L',
                                ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child:
                                _DisabledOutlined(
                                  text:
                                      'Goal 2.0L',
                                ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child:
                                _DisabledOutlined(
                                  text:
                                      'Goal 2.5L',
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80),
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
    final pct = (current / goal).clamp(0.0, 1.0);
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
          value: pct,
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

class _WaterGlassTile extends StatelessWidget {
  final bool isFilled;
  final int mlPerGlass;

  const _WaterGlassTile({
    required this.isFilled,
    required this.mlPerGlass,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 0,
            ),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: isFilled
                  ? Colors.blue[700]
                  : Colors.transparent,
              border: Border.all(
                color: isFilled
                    ? Colors.blue[700]!
                    : Colors.grey[400]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            child: Icon(
              Icons.local_drink,
              color: isFilled
                  ? Colors.white
                  : Colors.grey[400],
              size: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${mlPerGlass}ml',
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DisabledOutlined extends StatelessWidget {
  final String text;
  const _DisabledOutlined({required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: null,
      child: Text(text),
    );
  }
}
