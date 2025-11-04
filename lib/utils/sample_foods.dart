import '../models/food_entry.dart';

class SampleFoods {
  static final List<Map<String, dynamic>> foods =
      [
        {
          'name': 'Cơm trắng',
          'calories': 130,
          'carbs': 28,
          'protein': 2.7,
          'fat': 0.3,
        },
        {
          'name': 'Thịt gà luộc',
          'calories': 165,
          'carbs': 0,
          'protein': 31,
          'fat': 3.6,
        },
        {
          'name': 'Trứng luộc',
          'calories': 155,
          'carbs': 1.1,
          'protein': 13,
          'fat': 11,
        },
        {
          'name': 'Rau luộc',
          'calories': 35,
          'carbs': 7,
          'protein': 2.8,
          'fat': 0.4,
        },
        {
          'name': 'Phở bò',
          'calories': 380,
          'carbs': 45,
          'protein': 28,
          'fat': 12,
        },
        {
          'name': 'Bún chả',
          'calories': 420,
          'carbs': 52,
          'protein': 24,
          'fat': 14,
        },
        {
          'name': 'Cá kho',
          'calories': 195,
          'carbs': 0,
          'protein': 26,
          'fat': 9,
        },
        {
          'name': 'Đậu phụ',
          'calories': 76,
          'carbs': 1.9,
          'protein': 8,
          'fat': 4.8,
        },
        {
          'name': 'Chuối',
          'calories': 89,
          'carbs': 23,
          'protein': 1.1,
          'fat': 0.3,
        },
        {
          'name': 'Táo',
          'calories': 52,
          'carbs': 14,
          'protein': 0.3,
          'fat': 0.2,
        },
        {
          'name': 'Sữa tươi',
          'calories': 42,
          'carbs': 5,
          'protein': 3.4,
          'fat': 1,
        },
        {
          'name': 'Bánh mì',
          'calories': 265,
          'carbs': 49,
          'protein': 9,
          'fat': 3.2,
        },
      ];

  static FoodEntry createFoodEntry(
    String name,
    String mealType,
  ) {
    final food = foods.firstWhere(
      (f) => f['name'] == name,
    );
    return FoodEntry(
      id: DateTime.now().millisecondsSinceEpoch
          .toString(),
      name: food['name'],
      calories: food['calories'],
      carbs: food['carbs'].toDouble(),
      protein: food['protein'].toDouble(),
      fat: food['fat'].toDouble(),
      timestamp: DateTime.now(),
      mealType: mealType,
    );
  }
}
