import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Calorie Tracker'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start your health journey today'**
  String get welcomeSubtitle;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weight;

  /// No description provided for @heightLabel.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get heightLabel;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weightLabel;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journal;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personal;

  /// No description provided for @todayJournal.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Journal'**
  String get todayJournal;

  /// No description provided for @totalCaloriesNeeded.
  ///
  /// In en, this message translates to:
  /// **'Total Calories Needed'**
  String get totalCaloriesNeeded;

  /// No description provided for @consumed.
  ///
  /// In en, this message translates to:
  /// **'Consumed'**
  String get consumed;

  /// No description provided for @macroNutrients.
  ///
  /// In en, this message translates to:
  /// **'Macro Nutrients'**
  String get macroNutrients;

  /// No description provided for @waterIntake.
  ///
  /// In en, this message translates to:
  /// **'Water Intake'**
  String get waterIntake;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @intro1Title.
  ///
  /// In en, this message translates to:
  /// **'Track Calories Easily'**
  String get intro1Title;

  /// No description provided for @intro1Desc.
  ///
  /// In en, this message translates to:
  /// **'Record and manage your daily calories simply'**
  String get intro1Desc;

  /// No description provided for @intro2Title.
  ///
  /// In en, this message translates to:
  /// **'Reach Your Goals'**
  String get intro2Title;

  /// No description provided for @intro2Desc.
  ///
  /// In en, this message translates to:
  /// **'Monitor progress and achieve your health goals'**
  String get intro2Desc;

  /// No description provided for @intro3Title.
  ///
  /// In en, this message translates to:
  /// **'Maintain Healthy Lifestyle'**
  String get intro3Title;

  /// No description provided for @intro3Desc.
  ///
  /// In en, this message translates to:
  /// **'Track water intake and nutrition every day'**
  String get intro3Desc;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @errorEmptyName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get errorEmptyName;

  /// No description provided for @errorEmptyHeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter your height'**
  String get errorEmptyHeight;

  /// No description provided for @errorInvalidHeight.
  ///
  /// In en, this message translates to:
  /// **'Invalid height'**
  String get errorInvalidHeight;

  /// No description provided for @errorEmptyWeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter your weight'**
  String get errorEmptyWeight;

  /// No description provided for @errorInvalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Invalid weight'**
  String get errorInvalidWeight;

  /// No description provided for @errorEmptyEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get errorEmptyEmail;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get errorInvalidEmail;

  /// No description provided for @errorEmptyPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get errorEmptyPassword;

  /// No description provided for @errorPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get errorPasswordTooShort;

  /// No description provided for @errorPasswordNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordNotMatch;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @ageYears.
  ///
  /// In en, this message translates to:
  /// **'Age (years)'**
  String get ageYears;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @yourGoal.
  ///
  /// In en, this message translates to:
  /// **'Your Goal'**
  String get yourGoal;

  /// No description provided for @loseWeight.
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get loseWeight;

  /// No description provided for @loseWeightDesc.
  ///
  /// In en, this message translates to:
  /// **'Lose 0.5 kg per week'**
  String get loseWeightDesc;

  /// No description provided for @maintainWeight.
  ///
  /// In en, this message translates to:
  /// **'Maintain Weight'**
  String get maintainWeight;

  /// No description provided for @maintainWeightDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep current weight'**
  String get maintainWeightDesc;

  /// No description provided for @gainWeight.
  ///
  /// In en, this message translates to:
  /// **'Gain Weight'**
  String get gainWeight;

  /// No description provided for @gainWeightDesc.
  ///
  /// In en, this message translates to:
  /// **'Gain 0.5 kg per week'**
  String get gainWeightDesc;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity Level'**
  String get activityLevel;

  /// No description provided for @sedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get sedentary;

  /// No description provided for @sedentaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Little or no exercise'**
  String get sedentaryDesc;

  /// No description provided for @lightlyActive.
  ///
  /// In en, this message translates to:
  /// **'Lightly Active'**
  String get lightlyActive;

  /// No description provided for @lightlyActiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Light exercise 1-3 days/week'**
  String get lightlyActiveDesc;

  /// No description provided for @moderatelyActive.
  ///
  /// In en, this message translates to:
  /// **'Moderately Active'**
  String get moderatelyActive;

  /// No description provided for @moderatelyActiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Moderate exercise 3-5 days/week'**
  String get moderatelyActiveDesc;

  /// No description provided for @veryActive.
  ///
  /// In en, this message translates to:
  /// **'Very Active'**
  String get veryActive;

  /// No description provided for @veryActiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Hard exercise 6-7 days/week'**
  String get veryActiveDesc;

  /// No description provided for @extraActive.
  ///
  /// In en, this message translates to:
  /// **'Extra Active'**
  String get extraActive;

  /// No description provided for @extraActiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Very hard exercise & physical job'**
  String get extraActiveDesc;

  /// No description provided for @errorEmptyAge.
  ///
  /// In en, this message translates to:
  /// **'Please enter your age'**
  String get errorEmptyAge;

  /// No description provided for @errorInvalidAge.
  ///
  /// In en, this message translates to:
  /// **'Invalid age'**
  String get errorInvalidAge;

  /// No description provided for @errorSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select your gender'**
  String get errorSelectGender;

  /// No description provided for @errorSelectGoal.
  ///
  /// In en, this message translates to:
  /// **'Please select your goal'**
  String get errorSelectGoal;

  /// No description provided for @errorSelectActivity.
  ///
  /// In en, this message translates to:
  /// **'Please select your activity level'**
  String get errorSelectActivity;

  /// No description provided for @addFood.
  ///
  /// In en, this message translates to:
  /// **'Add Food'**
  String get addFood;

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// No description provided for @lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunch;

  /// No description provided for @dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinner;

  /// No description provided for @addMeal.
  ///
  /// In en, this message translates to:
  /// **'Add Meal'**
  String get addMeal;

  /// No description provided for @aboutProject.
  ///
  /// In en, this message translates to:
  /// **'About Project'**
  String get aboutProject;

  /// No description provided for @aboutProjectDesc.
  ///
  /// In en, this message translates to:
  /// **'Calorie Tracker is a comprehensive health management application that helps you track your daily calorie intake, water consumption, and BMI index. The app is designed with a user-friendly interface and provides personalized features to help you achieve your health goals.'**
  String get aboutProjectDesc;

  /// No description provided for @trackCalories.
  ///
  /// In en, this message translates to:
  /// **'Track Calories'**
  String get trackCalories;

  /// No description provided for @mainFeatures.
  ///
  /// In en, this message translates to:
  /// **'Main Features'**
  String get mainFeatures;

  /// No description provided for @trackCaloriesDesc.
  ///
  /// In en, this message translates to:
  /// **'Record and calculate your daily calorie intake'**
  String get trackCaloriesDesc;

  /// No description provided for @waterReminder.
  ///
  /// In en, this message translates to:
  /// **'Water Reminder'**
  String get waterReminder;

  /// No description provided for @waterReminderDesc.
  ///
  /// In en, this message translates to:
  /// **'Track your daily water intake'**
  String get waterReminderDesc;

  /// No description provided for @calculateBMI.
  ///
  /// In en, this message translates to:
  /// **'Calculate BMI'**
  String get calculateBMI;

  /// No description provided for @calculateBMIDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor your BMI and health status'**
  String get calculateBMIDesc;

  /// No description provided for @personalizedGoals.
  ///
  /// In en, this message translates to:
  /// **'Personalized Goals'**
  String get personalizedGoals;

  /// No description provided for @personalizedGoalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Set and track calorie goals based on your personal information'**
  String get personalizedGoalsDesc;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @studentId.
  ///
  /// In en, this message translates to:
  /// **'Student ID'**
  String get studentId;

  /// No description provided for @className.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get className;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @universityName.
  ///
  /// In en, this message translates to:
  /// **'Phenikaa University'**
  String get universityName;

  /// No description provided for @techStack.
  ///
  /// In en, this message translates to:
  /// **'Technology Stack'**
  String get techStack;

  /// No description provided for @localDataStorage.
  ///
  /// In en, this message translates to:
  /// **'Local Data Storage'**
  String get localDataStorage;

  /// No description provided for @typography.
  ///
  /// In en, this message translates to:
  /// **'Typography'**
  String get typography;

  /// No description provided for @uiFramework.
  ///
  /// In en, this message translates to:
  /// **'UI Framework'**
  String get uiFramework;

  /// No description provided for @madeWithLove.
  ///
  /// In en, this message translates to:
  /// **'Nguyen Xuan Manh'**
  String get madeWithLove;

  /// No description provided for @updateWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Weight'**
  String get updateWeightTitle;

  /// No description provided for @updateWaterGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Water Goal'**
  String get updateWaterGoalTitle;

  /// No description provided for @waterGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Water Goal (ml)'**
  String get waterGoalLabel;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;

  /// No description provided for @bmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get bmi;

  /// No description provided for @yourBMI.
  ///
  /// In en, this message translates to:
  /// **'Your BMI'**
  String get yourBMI;

  /// No description provided for @updateWeight.
  ///
  /// In en, this message translates to:
  /// **'Update Weight'**
  String get updateWeight;

  /// No description provided for @waterGoal.
  ///
  /// In en, this message translates to:
  /// **'Water Goal'**
  String get waterGoal;

  /// No description provided for @shouldDrinkDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily Recommendation'**
  String get shouldDrinkDaily;

  /// No description provided for @customizeGoal.
  ///
  /// In en, this message translates to:
  /// **'Customize Goal'**
  String get customizeGoal;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
