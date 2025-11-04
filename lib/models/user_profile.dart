class UserProfile {
  final String name;
  final double height;
  final double weight;
  final int age;
  final String gender;
  final String goal;
  final String activityLevel;
  final int waterGoal;
  final DateTime lastUpdated;

  UserProfile({
    required this.name,
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.goal,
    required this.activityLevel,
    required this.waterGoal,
    required this.lastUpdated,
  });

  double get bmi {
    if (height == 0) return 0;
    return weight /
        ((height / 100) * (height / 100));
  }

  String get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue < 18.5) return 'Thiếu cân';
    if (bmiValue < 25) return 'Bình thường';
    if (bmiValue < 30) return 'Thừa cân';
    return 'Béo phì';
  }

  double get bmr {
    final base =
        10 * weight + 6.25 * height - 5 * age;
    return gender == 'male'
        ? base + 5
        : base - 161;
  }

  double get tdee {
    final activityMultipliers = {
      'sedentary': 1.2,
      'light': 1.375,
      'moderate': 1.55,
      'very': 1.725,
      'extra': 1.9,
    };

    return bmr *
        (activityMultipliers[activityLevel] ??
            1.2);
  }

  int get dailyCalorieGoal {
    switch (goal) {
      case 'lose':
        return (tdee - 500).round();
      case 'gain':
        return (tdee + 500).round();
      case 'maintain':
      default:
        return tdee.round();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
      'goal': goal,
      'activityLevel': activityLevel,
      'waterGoal': waterGoal,
      'lastUpdated': lastUpdated
          .toIso8601String(),
    };
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserProfile(
      name: json['name'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      age: json['age'] ?? 25,
      gender: json['gender'] ?? 'male',
      goal: json['goal'] ?? 'maintain',
      activityLevel:
          json['activityLevel'] ?? 'sedentary',
      waterGoal: json['waterGoal'],
      lastUpdated: DateTime.parse(
        json['lastUpdated'],
      ),
    );
  }

  UserProfile copyWith({
    String? name,
    double? height,
    double? weight,
    int? age,
    String? gender,
    String? goal,
    String? activityLevel,
    int? waterGoal,
    DateTime? lastUpdated,
  }) {
    return UserProfile(
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      goal: goal ?? this.goal,
      activityLevel:
          activityLevel ?? this.activityLevel,
      waterGoal: waterGoal ?? this.waterGoal,
      lastUpdated:
          lastUpdated ?? this.lastUpdated,
    );
  }
}
