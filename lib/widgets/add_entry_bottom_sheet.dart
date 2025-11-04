import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food_entry.dart';
import '../utils/sample_foods.dart';

class AddEntryBottomSheet extends StatefulWidget {
  final Function(FoodEntry) onFoodAdded;
  final String?
  initialMealType; // Optional initial meal type

  const AddEntryBottomSheet({
    super.key,
    required this.onFoodAdded,
    this.initialMealType,
  });

  @override
  State<AddEntryBottomSheet> createState() =>
      _AddEntryBottomSheetState();
}

class _AddEntryBottomSheetState
    extends State<AddEntryBottomSheet> {
  late String _selectedMealType;

  @override
  void initState() {
    super.initState();
    _selectedMealType =
        widget.initialMealType ?? 'breakfast';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height *
          0.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Thanh kéo
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                2,
              ),
            ),
          ),

          // Tiêu đề
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              'Thêm món ăn',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E7D32),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Meal type selector
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildMealTypeButton(
                    'Sáng',
                    'breakfast',
                    Icons.wb_sunny,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMealTypeButton(
                    'Trưa',
                    'lunch',
                    Icons.wb_sunny_outlined,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMealTypeButton(
                    'Tối',
                    'dinner',
                    Icons.nightlight,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Food list
          Expanded(child: _buildFoodTab()),
        ],
      ),
    );
  }

  Widget _buildMealTypeButton(
    String label,
    String mealType,
    IconData icon,
  ) {
    final isSelected =
        _selectedMealType == mealType;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedMealType = mealType;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? const Color(0xFF4CAF50)
            : Colors.grey[200],
        foregroundColor: isSelected
            ? Colors.white
            : Colors.grey[700],
        elevation: isSelected ? 4 : 0,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Chọn món ăn',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: SampleFoods.foods.length,
              itemBuilder: (context, index) {
                final food =
                    SampleFoods.foods[index];
                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      food['name'],
                      style: GoogleFonts.poppins(
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '${food['calories']} kcal | C:${food['carbs']}g P:${food['protein']}g F:${food['fat']}g',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF4CAF50),
                    ),
                    onTap: () {
                      final foodEntry =
                          SampleFoods.createFoodEntry(
                            food['name'],
                            _selectedMealType,
                          );
                      widget.onFoodAdded(
                        foodEntry,
                      );
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
