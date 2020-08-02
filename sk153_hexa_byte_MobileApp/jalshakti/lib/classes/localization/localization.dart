import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      //for home page
      'appName': 'Jal Shakti',
      'start_survey': 'Start Survey',

      //for admin drawer
      'survey': 'Survey',
      'approve_surveys': 'Approve Surveys',
      'report_problem': 'Report problem',
      'about': 'About',
      'sign_out': 'Sign Out',

      //for survey approval page
      'surveyer_name': 'Name',
      'survey_date': 'Survey Date',
      'check': 'Check',
      'approved': 'Approved',

      //for survey details page
      'surveyer': 'Survey from',

      'survey_approval_warning':
          'Before approving the survey data, ensure that it is correct and relevant to river embankments as per your knowledge',
      'deny': 'Deny',
      'approve': 'Approve',
      'see_on_map': 'See on map',
      'image_location': 'Image Location',
    },
    'hi': {
      //for home page
      'appName': 'जल शक्ती',
      'start_survey': 'सर्वेक्षण करें',

      //for admin drawer
      'survey': 'सर्वेक्षण',
      'approve_surveys': 'सर्वेक्षण अनुमोदन',
      'report_problem': 'समस्या की चेतावनी',
      'about': 'अधिक जानकारी',
      'sign_out': 'साइन आउट',

      //for survey approval page
      'surveyer_name': 'नाम',
      'survey_date': 'सर्वेक्षण की तारीख',
      'check': 'जाँच करे',
      'approved': 'अनुमोदित',

      //for survey details page
      'surveyer': 'सर्वेक्षक',
      'image_location': 'फोटो का स्थान',
      'see_on_map': 'नक्क्षे पर देखें',
      'survey_approval_warning':
          'सर्वेक्षण के आंकड़ों को अनुमोदित करने से पहले, सुनिश्चित करें कि यह आपके ज्ञान के अनुसार नदी तटबंधों के लिए सही और प्रासंगिक है।',
      'deny': 'मना करे',
      'approve': 'अनुमोदित करे',
    },
  };

//for home page
  String get appName {
    return _localizedValues[locale.languageCode]['appName'];
  }

  String get startSurvey {
    return _localizedValues[locale.languageCode]['start_survey'];
  }

//for admin drawer
  String get survey {
    return _localizedValues[locale.languageCode]['survey'];
  }

  String get approveSurveys {
    return _localizedValues[locale.languageCode]['approve_surveys'];
  }

  String get reportProblem {
    return _localizedValues[locale.languageCode]['report_problem'];
  }

  String get about {
    return _localizedValues[locale.languageCode]['about'];
  }

  String get signOut {
    return _localizedValues[locale.languageCode]['sign_out'];
  }

  //for survey approval page
  String get surveyerName {
    return _localizedValues[locale.languageCode]['surveyer_name'];
  }

  String get surveyDate {
    return _localizedValues[locale.languageCode]['survey_date'];
  }

  String get check {
    return _localizedValues[locale.languageCode]['check'];
  }

  String get approved {
    return _localizedValues[locale.languageCode]['approved'];
  }

  //for survey details page
  String get surveyer {
    return _localizedValues[locale.languageCode]['surveyer'];
  }

  String get imageLocation {
    return _localizedValues[locale.languageCode]['image_location'];
  }

  String get seeOnMap {
    return _localizedValues[locale.languageCode]['see_on_map'];
  }

  String get surveyApprovalWarning {
    return _localizedValues[locale.languageCode]['survey_approval_warning'];
  }

  String get deny {
    return _localizedValues[locale.languageCode]['deny'];
  }

  String get approve {
    return _localizedValues[locale.languageCode]['approve'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
