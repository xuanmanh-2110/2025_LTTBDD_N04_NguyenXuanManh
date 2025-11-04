import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_entry.dart';
import '../models/water_entry.dart';
import '../models/user_profile.dart';

class StorageService {
  static const String _foodEntriesKey =
      'food_entries';
  static const String _waterEntriesKey =
      'water_entries';
  static const String _userProfileKey =
      'user_profile';

  // Món ăn đã nhập
  Future<List<FoodEntry>> getFoodEntries() async {
    final prefs =
        await SharedPreferences.getInstance();
    final entriesJson =
        prefs.getStringList(_foodEntriesKey) ??
        [];

    return entriesJson
        .map(
          (json) => FoodEntry.fromJson(
            jsonDecode(json),
          ),
        )
        .toList();
  }

  Future<void> saveFoodEntry(
    FoodEntry entry,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();
    final entries = await getFoodEntries();
    entries.add(entry);

    final entriesJson = entries
        .map((e) => jsonEncode(e.toJson()))
        .toList();
    await prefs.setStringList(
      _foodEntriesKey,
      entriesJson,
    );
  }

  Future<void> deleteFoodEntry(String id) async {
    final prefs =
        await SharedPreferences.getInstance();
    final entries = await getFoodEntries();
    entries.removeWhere(
      (entry) => entry.id == id,
    );

    final entriesJson = entries
        .map((e) => jsonEncode(e.toJson()))
        .toList();
    await prefs.setStringList(
      _foodEntriesKey,
      entriesJson,
    );
  }

  // Nước đã uống
  Future<List<WaterEntry>>
  getWaterEntries() async {
    final prefs =
        await SharedPreferences.getInstance();
    final entriesJson =
        prefs.getStringList(_waterEntriesKey) ??
        [];

    return entriesJson
        .map(
          (json) => WaterEntry.fromJson(
            jsonDecode(json),
          ),
        )
        .toList();
  }

  Future<void> saveWaterEntry(
    WaterEntry entry,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();
    final entries = await getWaterEntries();
    entries.add(entry);

    final entriesJson = entries
        .map((e) => jsonEncode(e.toJson()))
        .toList();
    await prefs.setStringList(
      _waterEntriesKey,
      entriesJson,
    );
  }

  Future<void> deleteWaterEntry(String id) async {
    final prefs =
        await SharedPreferences.getInstance();
    final entries = await getWaterEntries();
    entries.removeWhere(
      (entry) => entry.id == id,
    );

    final entriesJson = entries
        .map((e) => jsonEncode(e.toJson()))
        .toList();
    await prefs.setStringList(
      _waterEntriesKey,
      entriesJson,
    );
  }

  // Hồ sơ người dùng
  Future<UserProfile?> getUserProfile() async {
    final prefs =
        await SharedPreferences.getInstance();
    final profileJson = prefs.getString(
      _userProfileKey,
    );

    if (profileJson == null) return null;

    return UserProfile.fromJson(
      jsonDecode(profileJson),
    );
  }

  Future<void> saveUserProfile(
    UserProfile profile,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();
    await prefs.setString(
      _userProfileKey,
      jsonEncode(profile.toJson()),
    );
  }

  // Lấy dữ liệu hôm nay
  Future<List<FoodEntry>>
  getTodayFoodEntries() async {
    final entries = await getFoodEntries();
    final now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final tomorrow = today.add(
      const Duration(days: 1),
    );

    return entries.where((entry) {
      return entry.timestamp.isAfter(today) &&
          entry.timestamp.isBefore(tomorrow);
    }).toList();
  }

  Future<List<FoodEntry>>
  getTodayFoodEntriesByMealType(
    String mealType,
  ) async {
    final entries = await getTodayFoodEntries();
    return entries
        .where(
          (entry) => entry.mealType == mealType,
        )
        .toList();
  }

  Future<List<WaterEntry>>
  getTodayWaterEntries() async {
    final entries = await getWaterEntries();
    final now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final tomorrow = today.add(
      const Duration(days: 1),
    );

    return entries.where((entry) {
      return entry.timestamp.isAfter(today) &&
          entry.timestamp.isBefore(tomorrow);
    }).toList();
  }

  Future<int> getTodayWaterIntake() async {
    final entries = await getTodayWaterEntries();
    return entries.fold<int>(
      0,
      (sum, entry) => sum + entry.amount,
    );
  }

  Future<int> getTodayCalorieIntake() async {
    final entries = await getTodayFoodEntries();
    return entries.fold<int>(
      0,
      (sum, entry) => sum + entry.calories,
    );
  }

  Future<Map<String, double>>
  getTodayMacros() async {
    final entries = await getTodayFoodEntries();
    final macros = {
      'carbs': 0.0,
      'protein': 0.0,
      'fat': 0.0,
    };

    for (final entry in entries) {
      macros['carbs'] =
          macros['carbs']! + entry.carbs;
      macros['protein'] =
          macros['protein']! + entry.protein;
      macros['fat'] = macros['fat']! + entry.fat;
    }

    return macros;
  }
}
