class FoodEntry {
  final String id;
  final String name;
  final int calories;
  final double carbs;
  final double protein;
  final double fat;
  final DateTime timestamp;
  final String
  mealType; // 'breakfast', 'lunch', 'dinner'

  FoodEntry({
    required this.id,
    required this.name,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.timestamp,
    required this.mealType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'timestamp': timestamp.toIso8601String(),
      'mealType': mealType,
    };
  }

  factory FoodEntry.fromJson(
    Map<String, dynamic> json,
  ) {
    return FoodEntry(
      id: json['id'],
      name: json['name'],
      calories: json['calories'],
      carbs: json['carbs'].toDouble(),
      protein: json['protein'].toDouble(),
      fat: json['fat'].toDouble(),
      timestamp: DateTime.parse(
        json['timestamp'],
      ),
      mealType: json['mealType'] ?? 'breakfast',
    );
  }
}
