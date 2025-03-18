// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserResponseModel userModelFromJson(String str) =>
    UserResponseModel.fromJson(json.decode(str));

String userModelToJson(UserResponseModel data) => json.encode(data.toJson());

class UserResponseModel {
  bool result;
  UserModel rest;

  UserResponseModel({
    required this.result,
    required this.rest,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        result: json["result"] == 1,
        rest: UserModel.fromJson(json["rest"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result ? 1 : 0,
        "rest": rest.toJson(),
      };
}

class UserModel {
  String restId;
  String restName;
  String restEmail;
  String restPass;
  String restUrlSlug;
  String restDomain;
  String tblResId;
  String restaurantId;
  String restLogo;
  String restFavicon;
  String gstNo;
  String address1;
  String address2;
  String geocode;
  String establishmentYear;
  String ownerName;
  String ownerMobile;
  String restContactNo;
  String menuCardId;
  DateTime addedOn;
  String activationStatus;
  String domainStatus;
  String dpOption;
  String adminLanguage;
  String websiteLanguages;
  String menuLanguages;
  String activePages;
  String restoPlan;
  String colorSettings;
  String fontSettings;
  DateTime proPlanStartDate;
  String deliveryTax;
  String restContactEmail;
  String allowGuestOrder;
  String kitchenIds;
  String preOrder;
  String openPreOrder;
  String ontableShow;
  String deviceTokens;
  String currencyId;
  String dateFormat;
  String timeFormat;
  String addonIds;

  UserModel({
    required this.restId,
    required this.restName,
    required this.restEmail,
    required this.restPass,
    required this.restUrlSlug,
    required this.restDomain,
    required this.tblResId,
    required this.restaurantId,
    required this.restLogo,
    required this.restFavicon,
    required this.gstNo,
    required this.address1,
    required this.address2,
    required this.geocode,
    required this.establishmentYear,
    required this.ownerName,
    required this.ownerMobile,
    required this.restContactNo,
    required this.menuCardId,
    required this.addedOn,
    required this.activationStatus,
    required this.domainStatus,
    required this.dpOption,
    required this.adminLanguage,
    required this.websiteLanguages,
    required this.menuLanguages,
    required this.activePages,
    required this.restoPlan,
    required this.colorSettings,
    required this.fontSettings,
    required this.proPlanStartDate,
    required this.deliveryTax,
    required this.restContactEmail,
    required this.allowGuestOrder,
    required this.kitchenIds,
    required this.preOrder,
    required this.openPreOrder,
    required this.ontableShow,
    required this.deviceTokens,
    required this.currencyId,
    required this.dateFormat,
    required this.timeFormat,
    required this.addonIds,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        restId: json["rest_id"] ?? "",
        restName: json["rest_name"] ?? "",
        restEmail: json["rest_email"] ?? "",
        restPass: json["rest_pass"] ?? "",
        restUrlSlug: json["rest_url_slug"] ?? "",
        restDomain: json["rest_domain"] ?? "",
        tblResId: json["tbl_res_id"] ?? "",
        restaurantId: json["restaurant_id"] ?? "",
        restLogo: json["rest_logo"] ?? "",
        restFavicon: json["rest_favicon"] ?? "",
        gstNo: json["gst_no"] ?? "",
        address1: json["address1"] ?? "",
        address2: json["address2"] ?? "",
        geocode: json["geocode"] ?? "",
        establishmentYear: json["establishment_year"] ?? "",
        ownerName: json["owner_name"] ?? "",
        ownerMobile: json["owner_mobile"] ?? "",
        restContactNo: json["rest_contact_no"] ?? "",
        menuCardId: json["menu_card_id"] ?? "",
        addedOn: DateTime.parse(json["added_on"]),
        activationStatus: json["activation_status"] ?? "",
        domainStatus: json["domain_status"] ?? "",
        dpOption: json["dp_option"] ?? "",
        adminLanguage: json["admin_language"] ?? "",
        websiteLanguages: json["website_languages"] ?? "",
        menuLanguages: json["menu_languages"] ?? "",
        activePages: json["active_pages"] ?? "",
        restoPlan: json["resto_plan"] ?? "",
        colorSettings: json["color_settings"] ?? "",
        fontSettings: json["font_settings"] ?? "",
        proPlanStartDate: json["pro_plan_start_date"] != null
            ? DateTime.parse(json["pro_plan_start_date"])
            : DateTime.now(),
        deliveryTax: json["delivery_tax"] ?? "",
        restContactEmail: json["rest_contact_email"] ?? "",
        allowGuestOrder: json["allow_guest_order"] ?? "",
        kitchenIds: json["kitchen_ids"] ?? "" ?? "",
        preOrder: json["pre_order"] ?? "",
        openPreOrder: json["open_pre_order"] ?? "",
        ontableShow: json["ontable_show"] ?? "",
        deviceTokens: json["device_tokens"] ?? "",
        currencyId: json["currency_id"] ?? "",
        dateFormat: json["date_format"] ?? "",
        timeFormat: json["time_format"] ?? "",
        addonIds: json["addon_ids"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "rest_id": restId,
        "rest_name": restName,
        "rest_email": restEmail,
        "rest_pass": restPass,
        "rest_url_slug": restUrlSlug,
        "rest_domain": restDomain,
        "tbl_res_id": tblResId,
        "restaurant_id": restaurantId,
        "rest_logo": restLogo,
        "rest_favicon": restFavicon,
        "gst_no": gstNo,
        "address1": address1,
        "address2": address2,
        "geocode": geocode,
        "establishment_year": establishmentYear,
        "owner_name": ownerName,
        "owner_mobile": ownerMobile,
        "rest_contact_no": restContactNo,
        "menu_card_id": menuCardId,
        "added_on": addedOn.toIso8601String(),
        "activation_status": activationStatus,
        "domain_status": domainStatus,
        "dp_option": dpOption,
        "admin_language": adminLanguage,
        "website_languages": websiteLanguages,
        "menu_languages": menuLanguages,
        "active_pages": activePages,
        "resto_plan": restoPlan,
        "color_settings": colorSettings,
        "font_settings": fontSettings,
        "pro_plan_start_date":
            "${proPlanStartDate.year.toString().padLeft(4, '0')}-${proPlanStartDate.month.toString().padLeft(2, '0')}-${proPlanStartDate.day.toString().padLeft(2, '0')}",
        // "pro_plan_start_date": proPlanStartDate,
        "delivery_tax": deliveryTax,
        "rest_contact_email": restContactEmail,
        "allow_guest_order": allowGuestOrder,
        "kitchen_ids": kitchenIds,
        "pre_order": preOrder,
        "open_pre_order": openPreOrder,
        "ontable_show": ontableShow,
        "device_tokens": deviceTokens,
        "currency_id": currencyId,
        "date_format": dateFormat,
        "time_format": timeFormat,
        "addon_ids": addonIds,
      };
}
