import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';
import '../models/food_entry.dart';
import '../models/water_entry.dart';
import '../services/storage_service.dart';
import '../widgets/add_entry_bottom_sheet.dart';

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
  int _todayWater = 0;
  Map<String, double> _todayMacros = {
    'carbs': 0,
    'protein': 0,
    'fat': 0,
  };
  int _dailyCalorieGoal =
      2000; // Default calorie goal
  int _waterGoal =
      2000; // Default water goal in ml
  List<bool> _waterGlasses = List.filled(
    10,
    false,
  ); // 10 glasses state

  // Meals by type
  List<FoodEntry> _breakfastMeals = [];
  List<FoodEntry> _lunchMeals = [];
  List<FoodEntry> _dinnerMeals = [];

  @override
  void initState() {
    super.initState();
    _loadTodayData();
  }

  Future<void> _loadTodayData() async {
    final calories = await _storageService
        .getTodayCalorieIntake();
    final water = await _storageService
        .getTodayWaterIntake();
    final macros = await _storageService
        .getTodayMacros();

    // Load user profile to get calculated calorie goal
    final profile = await _storageService
        .getUserProfile();

    // Load meals by type
    final breakfast = await _storageService
        .getTodayFoodEntriesByMealType(
          'breakfast',
        );
    final lunch = await _storageService
        .getTodayFoodEntriesByMealType('lunch');
    final dinner = await _storageService
        .getTodayFoodEntriesByMealType('dinner');

    setState(() {
      _todayCalories = calories;
      _todayWater = water;
      _todayMacros = macros;
      _breakfastMeals = breakfast;
      _lunchMeals = lunch;
      _dinnerMeals = dinner;
      if (profile != null) {
        _dailyCalorieGoal =
            profile.dailyCalorieGoal;
        _waterGoal = profile.waterGoal;
      }
      // Calculate which glasses should be filled based on current water intake
      _updateWaterGlasses();
    });
  }

  void _updateWaterGlasses() {
    final glassAmount = _waterGoal / 10;
    final filledGlasses =
        (_todayWater / glassAmount).floor();
    _waterGlasses = List.generate(
      10,
      (index) => index < filledGlasses,
    );
  }

  Future<void> _toggleWaterGlass(
    int index,
  ) async {
    setState(() {
      _waterGlasses[index] =
          !_waterGlasses[index];
    });

    // Calculate the amount per glass
    final glassAmount = (_waterGoal / 10).round();

    // Save or remove water entry
    if (_waterGlasses[index]) {
      // Glass was filled - add water
      final waterEntry = WaterEntry(
        id: '${DateTime.now().millisecondsSinceEpoch}_$index',
        amount: glassAmount,
        timestamp: DateTime.now(),
      );
      await _storageService.saveWaterEntry(
        waterEntry,
      );
    } else {
      // Glass was emptied - we need to remove the equivalent amount
      // For simplicity, reload data which will recalculate glasses
      // In a production app, you'd want to track individual glass entries
    }

    // Reload to update the water total
    _loadTodayData();
  }

  void _showAddEntryBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => AddEntryBottomSheet(
        onFoodAdded: (food) async {
          await _storageService.saveFoodEntry(
            food,
          );
          _loadTodayData();
        },
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // Tiêu đề
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
                            _todayCalories /
                            _dailyCalorieGoal,
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
                const SizedBox(height: 20),

                // Card Nước với 10 ly
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

                      // Grid of 10 water glasses (2 rows x 5 columns)
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
                              return _buildWaterGlass(
                                index,
                              );
                            },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Meals Section
                _buildMealSection(
                  l10n.breakfast,
                  'breakfast',
                  _breakfastMeals,
                  Icons.wb_sunny,
                  Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildMealSection(
                  l10n.lunch,
                  'lunch',
                  _lunchMeals,
                  Icons.wb_sunny_outlined,
                  Colors.amber,
                ),
                const SizedBox(height: 16),
                _buildMealSection(
                  l10n.dinner,
                  'dinner',
                  _dinnerMeals,
                  Icons.nightlight,
                  Colors.indigo,
                ),
                const SizedBox(
                  height: 80,
                ), // Space for FAB
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEntryBottomSheet,
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildWaterGlass(int index) {
    final isFilled = _waterGlasses[index];
    final glassAmount = (_waterGoal / 10).round();

    return GestureDetector(
      onTap: () => _toggleWaterGlass(index),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeInOut,
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
            '${glassAmount}ml',
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

  Widget _buildMealSection(
    String title,
    String mealType,
    List<FoodEntry> meals,
    IconData icon,
    Color color,
  ) {
    final totalCalories = meals.fold<int>(
      0,
      (sum, meal) => sum + meal.calories,
    );
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              Text(
                '$totalCalories kcal',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),

          if (meals.isEmpty) ...[
            const SizedBox(height: 12),
            Center(
              child: TextButton.icon(
                onPressed: () =>
                    _showAddEntryBottomSheetWithMealType(
                      mealType,
                    ),
                icon: Icon(
                  Icons.add_circle_outline,
                  color: color,
                ),
                label: Text(
                  l10n.addFood,
                  style: GoogleFonts.poppins(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 12),
            ...meals.map(
              (meal) =>
                  _buildMealItem(meal, color),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: () =>
                    _showAddEntryBottomSheetWithMealType(
                      mealType,
                    ),
                icon: Icon(
                  Icons.add_circle_outline,
                  color: color,
                  size: 18,
                ),
                label: Text(
                  l10n.addMeal,
                  style: GoogleFonts.poppins(
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMealItem(
    FoodEntry meal,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'C:${meal.carbs.toStringAsFixed(0)}g • P:${meal.protein.toStringAsFixed(0)}g • F:${meal.fat.toStringAsFixed(0)}g',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${meal.calories} kcal',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              size: 20,
            ),
            color: Colors.red[400],
            onPressed: () => _deleteMeal(meal.id),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  void _showAddEntryBottomSheetWithMealType(
    String mealType,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => AddEntryBottomSheet(
        initialMealType: mealType,
        onFoodAdded: (food) async {
          await _storageService.saveFoodEntry(
            food,
          );
          _loadTodayData();
        },
      ),
    );
  }

  Future<void> _deleteMeal(String id) async {
    await _storageService.deleteFoodEntry(id);
    _loadTodayData();
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
