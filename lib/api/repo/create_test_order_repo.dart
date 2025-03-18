import 'package:resto_page/utils/shared_prefs.dart';

import '../../constant/request_constant.dart';
import '../../models/response_item.dart';
import '../api_helpers.dart';

class CreateTestOrderRepo {
  static Future<ResponseItem> reservationOrder() async {
    ResponseItem result;

    String requestUrl = AppUrls.BASE_URL +
        MethodNames.createTestOrder +
        preferences.getString(SharedPreference.REST_ID)! +
        MethodNames.reservation;

    result = await BaseApiHelper.getRequest(requestUrl);

    return result;
  }

  static Future<ResponseItem> deliveryOrder() async {
    ResponseItem result;

    String requestUrl = AppUrls.BASE_URL +
        MethodNames.createTestOrder +
        preferences.getString(SharedPreference.REST_ID)! +
        MethodNames.delivery;

    result = await BaseApiHelper.getRequest(requestUrl);

    return result;
  }

  static Future<ResponseItem> pickupOrder() async {
    ResponseItem result;

    String requestUrl = AppUrls.BASE_URL +
        MethodNames.createTestOrder +
        preferences.getString(SharedPreference.REST_ID)! +
        MethodNames.pickup;

    result = await BaseApiHelper.getRequest(requestUrl);

    return result;
  }
}
