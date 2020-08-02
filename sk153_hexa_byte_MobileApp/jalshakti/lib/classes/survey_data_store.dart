import 'dart:convert';

//class to store survey data
class SurveyDataStore {
  static double latitude = 0.0;
  static double longitude = 0.0;
  static String imageURL = "";
}

// To parse this JSON data, do
//
//     final surveyData = surveyDataFromJson(jsonString);

SurveyData surveyDataFromJson(String str) =>
    SurveyData.fromJson(json.decode(str));

String surveyDataToJson(SurveyData data) => json.encode(data.toJson());

class SurveyData {
  SurveyData({
    this.surveyer,
    this.state,
    this.district,
    this.imageUrl,
    this.location,
    this.surveyStatus,
    this.surveyData,
  });

  String surveyer;
  String state;
  String district;
  String imageUrl;
  Location location;
  String surveyStatus;
  SurveyDataClass surveyData;

  factory SurveyData.fromJson(Map<dynamic, dynamic> json) => SurveyData(
        surveyer: json["surveyer"],
        state: json["state"],
        district: json["district"],
        imageUrl: json["image-url"],
        location: Location.fromJson(json["location"]),
        surveyStatus: json["survey-status"],
        surveyData: SurveyDataClass.fromJson(json["survey-data"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "surveyer": surveyer,
        "state": state,
        "district": district,
        "image-url": imageUrl,
        "location": location.toJson(),
        "survey-status": surveyStatus,
        "survey-data": surveyData.toJson(),
      };
}

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Location.fromJson(Map<dynamic, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<dynamic, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class SurveyDataClass {
  SurveyDataClass({
    this.detailed,
    this.general,
  });

  Detailed detailed;
  Map<dynamic, dynamic> general;

  factory SurveyDataClass.fromJson(Map<dynamic, dynamic> json) =>
      SurveyDataClass(
        detailed: Detailed.fromJson(json["detailed"]),
        general: Map.from(json["general"])
            .map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
      );

  Map<dynamic, dynamic> toJson() => {
        "detailed": detailed.toJson(),
        "general":
            Map.from(general).map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
      };
}

class Detailed {
  Detailed({
    this.multipleChoice,
    this.slider,
  });

  MultipleChoice multipleChoice;
  Map<dynamic, dynamic> slider;

  factory Detailed.fromJson(Map<dynamic, dynamic> json) => Detailed(
        multipleChoice: MultipleChoice.fromJson(json["multiple-choice"]),
        slider: Map.from(json["slider"])
            .map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
      );

  Map<dynamic, dynamic> toJson() => {
        "multiple-choice": multipleChoice.toJson(),
        "slider":
            Map.from(slider).map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
      };
}

class MultipleChoice {
  MultipleChoice({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the5,
    this.the6,
    this.the4,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the5;
  String the6;
  String the4;

  factory MultipleChoice.fromJson(Map<dynamic, dynamic> json) => MultipleChoice(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the5: json["5"],
        the6: json["6"],
        the4: json[" 4"],
      );

  Map<dynamic, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "5": the5,
        "6": the6,
        " 4": the4,
      };
}

// class SliderData {
//   var data = {};
//   SliderData(this.data);
//   Map toJson() => {'1': this.data};
// }
