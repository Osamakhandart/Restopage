import 'package:resto_page/utils/shared_prefs.dart';

import '../../constant/request_constant.dart';
import '../../models/response_item.dart';
import '../api_helpers.dart';

class UserAuthRepo {
  static Future<ResponseItem> userLogin(String email, String password) async {
    ResponseItem result;

    dynamic params = {
      "rest_email": email,
      "rest_pass": password,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.resLoginValidate;

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }

  static Future<ResponseItem> userLogout(String restId, deviceToken) async {
    ResponseItem result;

    dynamic params = {
      "rest_id": restId.toString(), // Your restaurant ID
      "device_token":
          deviceToken.toString(), // The device token used for this session
    };
    print(params);
    String requestUrl = AppUrls.BASE_URL + MethodNames.resLogout;

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }

  static Future<ResponseItem> forgetPassword(String email) async {
    ResponseItem result;
    dynamic params = {
      "rest_email": email,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.forgotpassword;

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }

/*  static Future<ResponseItem> updateDeviceToken(String saveDeviceToken) async {
    ResponseItem result;
    dynamic params = {
      "device_token": saveDeviceToken,
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.saveDeviceToken;

    result = await BaseApiHelper.uploadFormData(requestUrl: requestUrl, requestData: params);

    return result;
  }*/

  static Future<ResponseItem> updateDeviceToken(String saveDeviceToken) async {
    ResponseItem result;
    dynamic params = {
      "device_token": saveDeviceToken,
    };

    String requestUrl =
        "${AppUrls.BASE_URL}${MethodNames.saveDeviceToken}${preferences.getString(SharedPreference.REST_ID)!}/$saveDeviceToken";

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }
}
