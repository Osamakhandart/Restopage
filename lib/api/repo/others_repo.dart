import 'package:resto_page/models/response_item.dart';

import '../../constant/request_constant.dart';
import '../api_helpers.dart';

class OthersRepo {
  static Future<ResponseItem?> getAboutUs() async {
    ResponseItem result;
    try {
      String requestUrl = AppUrls.BASE_URL + MethodNames.aboutUs;
      // preferences.getString(SharedPreference.REST_ID)!;

      result = await BaseApiHelper.getRequest(requestUrl);

      return result;
    } catch (e) {
      return null;
    }
  }

  static Future<ResponseItem?> getTerm() async {
    ResponseItem result;
    try {
      String requestUrl = AppUrls.BASE_URL + MethodNames.term;
      // preferences.getString(SharedPreference.REST_ID)!;

      result = await BaseApiHelper.getRequest(requestUrl);

      return result;
    } catch (e) {
      return null;
    }
  }
}
