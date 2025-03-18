// To parse this JSON data, do
//
//     final aboutModel = aboutModelFromJson(jsonString);

import 'dart:convert';

TermModel termModelFromJson(var str) => TermModel.fromJson(str);

String termModelToJson(TermModel data) => json.encode(data.toJson());

class TermModel {
  String mobileTermsPageContent;
  String mobileTermsPageContentEnglish;
  String mobileTermsPageContentFrench;
  String mobileTermsPageContentGermany;

  TermModel({
    required this.mobileTermsPageContent,
    required this.mobileTermsPageContentEnglish,
    required this.mobileTermsPageContentFrench,
    required this.mobileTermsPageContentGermany,
  });

  factory TermModel.fromJson(Map<String, dynamic> json) => TermModel(
        mobileTermsPageContent: json["mobile_terms_page_content"],
        mobileTermsPageContentEnglish:
            json["mobile_terms_page_content_english"],
        mobileTermsPageContentFrench: json["mobile_terms_page_content_french"],
        mobileTermsPageContentGermany:
            json["mobile_terms_page_content_germany"],
      );

  Map<String, dynamic> toJson() => {
        "mobile_terms_page_content": mobileTermsPageContent,
        "mobile_terms_page_content_english": mobileTermsPageContentEnglish,
        "mobile_terms_page_content_french": mobileTermsPageContentFrench,
        "mobile_terms_page_content_germany": mobileTermsPageContentGermany,
      };
}
