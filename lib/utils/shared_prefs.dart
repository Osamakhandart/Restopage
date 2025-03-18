// ignore_for_file: constant_identifier_names
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resto_page/constant/request_constant.dart';
import 'package:resto_page/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

final preferences = SharedPreference();

class SharedPreference {
  static SharedPreferences? _preferences;

  init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static const LANGUAGE_CODE = "LANGUAGE_CODE";
  static const COUNTRY_CODE = "COUNTRY_CODE";
  static const IS_LOGGED_IN = "IS_LOGGED_IN";

  static const USER_EMAIL = "USER_EMAIL";
  static const REST_ID = "REST_ID";
  static const USER_NAME = "USER_NAME";
  static const USER_PASS = "USER_PASS";
  static const RESTAURANT_ID = "RESTAURANT_ID";
  static const USER_LOGO = "USER_LOGO";
  static const USER_FAVICON = "USER_FAVICON";
  static const GST_NO = "GST_NO";
  static const ADDRESS_NO_1 = "ADDRESS_NO_1";
  static const OWNER_NAME = "OWNER_NAME";
  static const CURRENCY_ID = "CURRENCY_ID";
  static const ADMIN_LANGUAGE = "ADMIN_LANGUAGE";
  static const OWNER_MOBILE_NO = "OWNER_MOBILE_NO";
  static const RESTO_CONTACT_MOBILE_NO = "RESTO_CONTACT_MOBILE_NO";
  static const REST_NAME = "REST_NAME";
  static const DEVICE_TOKEN = "DEVICE_TOKEN";

  void clearUserItem() async {
    _preferences?.clear();
    _preferences = null;
    await init();
  }

  saveUserItem(UserModel userItem) {
    preferences.putBool(IS_LOGGED_IN, true);
    preferences.putString(USER_EMAIL, userItem.restEmail);
    preferences.putString(REST_NAME, userItem.restName);
    preferences.putString(REST_ID, userItem.restId);
    preferences.putString(USER_PASS, userItem.restPass);
    preferences.putString(RESTAURANT_ID, userItem.restaurantId);
    preferences.putString(USER_LOGO, userItem.restLogo);
    preferences.putString(USER_FAVICON, userItem.restFavicon);
    preferences.putString(GST_NO, userItem.gstNo);
    preferences.putString(ADDRESS_NO_1, userItem.address1);
    preferences.putString(OWNER_NAME, userItem.ownerName);
    preferences.putString(CURRENCY_ID, userItem.currencyId);
    preferences.putString(ADMIN_LANGUAGE, userItem.adminLanguage);
    preferences.putString(OWNER_MOBILE_NO, userItem.ownerMobile);
    preferences.putString(RESTO_CONTACT_MOBILE_NO, userItem.restContactNo);
    preferences.putString(DEVICE_TOKEN, userItem.deviceTokens);
    fetchLogo(userItem.restLogo);
  }
  
Future<void> downloadAndSaveImage(String imageUrl) async {
  var logoUrl = "${AppUrls.Image_Url}/assets/rest_logo/$imageUrl";
  final response = await http.get(Uri.parse(logoUrl));
  if (response.statusCode == 200) {
    // Decode the image to ensure it's valid
    final img.Image? downloadedImage = img.decodeImage(response.bodyBytes);
    if (downloadedImage == null) {
      throw Exception("Downloaded image is corrupted or unsupported");
    }

    // Get the directory to store the image
    final directory = await getApplicationDocumentsDirectory();
    // File path to save the image
    File file = File('${directory.path}/logo.png');
    // Write the file
    await file.writeAsBytes(response.bodyBytes);
    print("Image saved to ${file.path}");
  } else {
    throw Exception("Failed to download image: ${response.statusCode}");
  }
}

Future<void> fetchLogo(String imageUrl) async {
  var logoUrl = "${AppUrls.Image_Url}/assets/rest_logo/$imageUrl";
  try {
    final response = await http.get(Uri.parse(logoUrl));
    if (response.statusCode == 200) {
      // Decode the image
      img.Image? image = img.decodeImage(response.bodyBytes);

      if (image != null) {
        // Convert the image to grayscale
        img.Image grayscaleImage = img.grayscale(image);

        // Adjust brightness to make the image darker
        // A negative value reduces brightness (makes it darker)
        grayscaleImage = img.adjustColor(grayscaleImage, brightness: -50); // Adjust this value as needed

        // Get the directory to store the image
        final directory = await getApplicationDocumentsDirectory();
        // File path to save the image
        File file = File('${directory.path}/logo.png');
        // Write the file
        await file.writeAsBytes(img.encodePng(grayscaleImage));
        print("Image saved to ${file.path}");
      } else {
        throw Exception('Failed to decode the image');
      }
    } else {
      throw Exception('Failed to load the image');
    }
  } catch (e) {
    print('Error fetching image: ${e.toString()}');
    throw Exception('Error fetching image: ${e.toString()}');
  }
}
Future<void> processAndSaveAssetImage(String assetPath) async {
  try {
    // Step 1: Load the asset image as ByteData
    ByteData byteData = await rootBundle.load(assetPath);

    // Step 2: Convert ByteData to Uint8List
    Uint8List imageBytes = byteData.buffer.asUint8List();

    // Step 3: Decode the image
    img.Image? image = img.decodeImage(imageBytes);

    if (image != null) {
      // Step 4: Convert the image to grayscale
      img.Image grayscaleImage = img.grayscale(image);

      // Step 5: Adjust brightness to make the image darker
      grayscaleImage = img.adjustColor(grayscaleImage, brightness: -50); // Adjust this value as needed

      // Step 6: Get the directory to store the image
      final directory = await getApplicationDocumentsDirectory();

      // Step 7: File path to save the image
      File file = File('${directory.path}/processed_asset_image.png');

      // Step 8: Write the file
      await file.writeAsBytes(img.encodePng(grayscaleImage));

      print("Processed image saved to ${file.path}");
    } else {
      throw Exception('Failed to decode the asset image');
    }
  } catch (e) {
    print('Error processing asset image: ${e.toString()}');
    throw Exception('Error processing asset image: ${e.toString()}');
  }
}
  logOut() async {
    preferences.putBool(IS_LOGGED_IN, false);

    await _preferences!.clear();
    Get.offAllNamed(Routes.loginScreen);
  }

  Future<bool?> putString(String key, String value) async {
    return _preferences == null ? null : _preferences!.setString(key, value);
  }

  String? getString(String key, {String defValue = ""}) {
    return _preferences == null
        ? defValue
        : _preferences!.getString(key) ?? defValue;
  }

  Future<bool?> putInt(String key, int value) async {
    return _preferences == null ? null : _preferences!.setInt(key, value);
  }

  int? getInt(String key, {int defValue = 0}) {
    return _preferences == null
        ? defValue
        : _preferences!.getInt(key) ?? defValue;
  }

  Future<bool?> putDouble(String key, double value) async {
    return _preferences == null ? null : _preferences!.setDouble(key, value);
  }

  double getDouble(String key, {double defValue = 0.0}) {
    return _preferences == null
        ? defValue
        : _preferences!.getDouble(key) ?? defValue;
  }

  Future<bool?> putBool(String key, bool value) async {
    return _preferences == null ? null : _preferences!.setBool(key, value);
  }

  bool? getBool(String key, {bool defValue = false}) {
    return _preferences == null
        ? defValue
        : _preferences!.getBool(key) ?? defValue;
  }
}
