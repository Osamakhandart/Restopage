import 'package:get/get.dart';

import '../../constant/request_constant.dart';
import '../../models/response_item.dart';
import '../api_helpers.dart';

class StatusRepo {
  static Future<ResponseItem> getOrderStatus(String id) async {
    ResponseItem result;

    dynamic params = {
      "limit": "20",
      "offset": "0",
      "type": "api_get_rejected_orders_success",
    };
//add here 
var currentLang=Get.locale?.languageCode == 'en'
                    ? 'english'
                    : Get.locale?.languageCode == 'de'
                        ? 'germany':'french';

    String requestUrl = "${AppUrls.BASE_URL}${MethodNames.getOrderDetail}$id?lang=$currentLang";


    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }

  static Future<ResponseItem> getReservation(String id) async {
    ResponseItem result;

    dynamic params = {
      "limit": "20",
      "offset": "0",
      "type": "api_get_rejected_orders_success",
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.getReservation + id;

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }

}
