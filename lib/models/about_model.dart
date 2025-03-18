// To parse this JSON data, do
//
//     final aboutModel = aboutModelFromJson(jsonString);

import 'dart:convert';

AboutModel aboutModelFromJson(var str) => AboutModel.fromJson(str);

String aboutModelToJson(AboutModel data) => json.encode(data.toJson());

class AboutModel {
  String mobileAboutPageContent;
  String mobileAboutPageContentEnglish;
  String mobileAboutPageContentFrench;
  String mobileAboutPageContentGermany;

  AboutModel({
    required this.mobileAboutPageContent,
    required this.mobileAboutPageContentEnglish,
    required this.mobileAboutPageContentFrench,
    required this.mobileAboutPageContentGermany,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
        mobileAboutPageContent: json["mobile_about_page_content"],
        mobileAboutPageContentEnglish:
            json["mobile_about_page_content_english"],
        mobileAboutPageContentFrench: json["mobile_about_page_content_french"],
        mobileAboutPageContentGermany:
            json["mobile_about_page_content_germany"],
      );

  Map<String, dynamic> toJson() => {
        "mobile_about_page_content": mobileAboutPageContent,
        "mobile_about_page_content_english": mobileAboutPageContentEnglish,
        "mobile_about_page_content_french": mobileAboutPageContentFrench,
        "mobile_about_page_content_germany": mobileAboutPageContentGermany,
      };
}
