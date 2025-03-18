import '../../constant/request_constant.dart';
import '../../models/response_item.dart';
import '../api_helpers.dart';

class ChangeStatusRepo {
  static acceptOrderStatus(
      {required String orderId,
      required String restId,
      required String orderDurationTime,
      required String orderType}) async {
    var result;

    dynamic params = orderType == "reservation"
        ? {
            "reservation_id": orderId,
            "status": "accepted",
            "rest_id": restId,
            "order_payment_method": 'stripe'
          }
        : {
            "order_id": orderId,
            "order_status": "accepted",
            "rest_id": restId,
            "order_duration_time": orderDurationTime,
            "order_payment_method": 'stripe'
          };

    String requestUrl = AppUrls.BASE_URL +
        (orderType == "reservation"
            ? MethodNames.changeReservationStatus
            : MethodNames.changeOrderStatus);

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }

  static Future<ResponseItem> cancelOrderStatus(
      {required String orderId,
      required String restId,
      required String orderDurationTime}) async {
    ResponseItem result;

    dynamic params = {
      "order_id": orderId,
      "order_status": "canceled",
      "rest_id": restId,
      "order_duration_time": orderDurationTime
    };

    String requestUrl = AppUrls.BASE_URL + MethodNames.changeOrderStatus;

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }
}
