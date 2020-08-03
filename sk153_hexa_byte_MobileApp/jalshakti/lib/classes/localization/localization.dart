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
      'introduction':
          'Central Water Commission is a premier Technical Organization of India in the field of Water Resources and is presently functioning as an attached office of the Ministry of Jal Shakti, Department of Water Resources, River Development and Ganga Rejuvenation, Government of India. The Commission is entrusted with the general responsibilities of initiating, coordinating and furthering in consultation of the State Governments concerned, schemes for control, conservation and utilization of water resources throughout the country, for purpose of Flood Control, Irrigation, Navigation, Drinking Water Supply and Water Power Development.',

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

      //for survey page
      'step1_info':
          'Before taking the survey, it is necessary that you actually visit a nearby river embankment and then answer all the questions.The first step of the survey insits on click an image of the embankment.It is necessary to have it as a proof.',
      'step1_click_picture': 'Click a picture',
      'step1_re-take': 'Re-take',
      'step1_confirm': 'Confirm',
      'step1_captured_photo': 'Captured photo',
      'step2_location': 'Location',
      'step2_no_address': 'No address',
      'step3_continue_survey': 'Continue to the survey...',
      'step3_continue': 'Continue',

      //for before general card
      'before_general_info':
          'Let us first understand some general information about river embankments. River embankments are water retaining structures that safeguard river surroundings.',

      //for detailed general card
      'before_detailed_info':
          'Let us have a detailed survey. Please observe every details of the embankment you are near to. Taking into consideration all the knowledge that you have regarding embankments, please provide genuine answers to following questions.',

      //for both card
      'both_card': 'Please click on the button below to continue...',
      'continue': 'Continue',
      'next': 'Next',

      //user detailed screen
      'user_detail_info':
          'Now a few last steps to help us understand and categorize the survey data.Please fill in the details below.',
      'name': 'Name',
      'state': 'Choose a state',
      'district': 'Choose a district',
      'submit': 'Submit',
    },
    'hi': {
      //for home page
      'appName': 'जल शक्ती',
      'start_survey': 'सर्वेक्षण करें',
      'introduction':
          'केंद्रीय जल आयोग का एक प्रमुख तकनीकी संगठन है जल संसाधन के क्षेत्र में भारत और वर्तमान में कार्य कर रहा है जल शक्ति मंत्रालय, विभाग के संलग्न कार्यालय के रूप में का जल संसाधन, नदी विकास और गंगा कायाकल्प, भारत सरकार। आयोग को सौंपा गया है शुरू करने, समन्वय और आगे बढ़ाने की सामान्य जिम्मेदारियाँ संबंधित राज्य सरकारों के परामर्श, योजनाओं के लिए जल संसाधनों का नियंत्रण, संरक्षण और उपयोग बाढ़ नियंत्रण के उद्देश्य से पूरे देश में सिंचाई,पथ प्रदर्शन,पेयजल आपूर्ति और जल विद्युत विकास।',

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

      //for survey page
      'step1_info':
          'सर्वेक्षण करने से पहले, यह आवश्यक है कि आप वास्तव में एक नजदीकी नदी तटबंध पर जाएँ और फिर सभी प्रश्नों के उत्तर दें। सर्वेक्षण का पहला चरण तटबंध की एक फोटो क्लिक करें। इसे प्रमाण के रूप में रखना आवश्यक है।',
      'step1_click_picture': 'फोटो क्लिक करें',
      'step1_re-take': 'पुन: ले',
      'step1_confirm': 'पुष्टि करें',
      'step1_captured_photo': 'खींची फोटो',
      'step2_location': 'स्थान',
      'step2_no_address': 'स्थान अनुपलब्ध है',
      'step3_continue_survey': 'सर्वेक्षण जारी रखें ...',
      'step3_continue': 'जारी रखें',

      //for before general card
      'before_general_info':
          'आइए हम पहले नदी तटबंधों के बारे में कुछ सामान्य जानकारी को समझें। नदी के तटबंध पानी को बनाए रखने वाली संरचनाएं हैं जो नदी के आसपास की सुरक्षा करती हैं।',

      //for detailed general card
      'before_detailed_info':
          'हमें एक विस्तृत सर्वेक्षण करना है। कृपया उस तटबंध के हर विवरण का अवलोकन करें, जिसके पास आप हैं। तटबंधों के संबंध में आपके पास सभी ज्ञान को ध्यान में रखते हुए, कृपया निम्नलिखित प्रश्नों के वास्तविक उत्तर प्रदान करें।',

      //for both card
      'both_card': 'कृपया जारी रखने के लिए नीचे दिए गए बटन पर क्लिक करें ...',
      'continue': 'जारी रखें',
      'next': 'आगे',

      //user detailed screen
      'user_detail_info':
          'अब सर्वेक्षण डेटा को समझने और श्रेणीबद्ध करने में हमारी मदद करने के लिए कुछ अंतिम चरण हैं। कृपया नीचे दिए गए विवरण भरें।',
      'name': 'नाम',
      'state': 'एक राज्य चुनें',
      'district': 'एक जिला चुनें',
      'submit': 'प्रस्तुत',
    },
  };

//for home page
  String get appName {
    return _localizedValues[locale.languageCode]['appName'];
  }

  String get introduction {
    return _localizedValues[locale.languageCode]['introduction'];
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

  //for survey page

  String get step1info {
    return _localizedValues[locale.languageCode]['step1_info'];
  }

  String get step1clickpicture {
    return _localizedValues[locale.languageCode]['step1_click_picture'];
  }

  String get step1capturedPhoto {
    return _localizedValues[locale.languageCode]['step1_captured_photo'];
  }

  String get step1retake {
    return _localizedValues[locale.languageCode]['step1_re-take'];
  }

  String get step1confirm {
    return _localizedValues[locale.languageCode]['step1_confirm'];
  }

  String get step2location {
    return _localizedValues[locale.languageCode]['step2_location'];
  }

  String get step2noaddress {
    return _localizedValues[locale.languageCode]['step2_no_address'];
  }

  String get step3continuesurvey {
    return _localizedValues[locale.languageCode]['step3_continue_survey'];
  }

  String get step3continue {
    return _localizedValues[locale.languageCode]['step3_continue'];
  }

  //for before general card
  String get beforeGeneralInfo {
    return _localizedValues[locale.languageCode]['before_general_info'];
  }

  String get next {
    return _localizedValues[locale.languageCode]['next'];
  }

  //for detailed general card
  String get beforeDetailedInfo {
    return _localizedValues[locale.languageCode]['before_detailed_info'];
  }
  //for both card

  //user detailed screen
  String get userDetailInfo {
    return _localizedValues[locale.languageCode]['user_detail_info'];
  }

  String get userName {
    return _localizedValues[locale.languageCode]['name'];
  }

  String get userState {
    return _localizedValues[locale.languageCode]['state'];
  }

  String get userDistrict {
    return _localizedValues[locale.languageCode]['district'];
  }

  String get submit {
    return _localizedValues[locale.languageCode]['submit'];
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
