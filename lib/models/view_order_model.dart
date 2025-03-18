// To parse this JSON data, do
//
//     final viewOrderModel = viewOrderModelFromJson(jsonString);

import 'dart:convert';

ViewOrderModel viewOrderModelFromJson(String str) =>
    ViewOrderModel.fromJson(json.decode(str));

String viewOrderModelToJson(ViewOrderModel data) => json.encode(data.toJson());

class ViewOrderModel {
  Order? order;
  List<Item>? items;
  List<SubTotal>? subTotal;
  String? currency;

  ViewOrderModel({
    this.order,
    this.items,
    this.subTotal,
    this.currency,
  });

  // factory ViewOrderModel.fromJson(Map<String, dynamic> json) => ViewOrderModel(
  //       order: json["order"] == null ? null : Order.fromJson(json["order"]),
  //       items: json["items"] == null
  //           ? []
  //           : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  //       subTotal: json["sub_total"] == null
  //           ? []
  //           : List<SubTotal>.from(
  //               json["sub_total"]!.map((x) => SubTotal.fromJson(x))),
  //       currency: json["currency"],
  //     );

  factory ViewOrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> _subTotal = [];
    for (var element in ((json["sub_total"]) as List)) {
      if (element != []) {
        _subTotal.add(element);
        _subTotal.removeWhere((element) => element.isEmpty);
      } else {}
    }
    print("_subTotal Length ----> ${_subTotal.length}");
    return ViewOrderModel(
      order: json["order"] == null ? null : Order.fromJson(json["order"]),
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      subTotal: json["sub_total"] == null
          ? []
          : List<SubTotal>.from(_subTotal.map((x) => SubTotal.fromJson(x))),
      currency: json["currency"],
    );
  }

  Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "sub_total": subTotal == null
            ? []
            : List<dynamic>.from(subTotal!.map((x) => x.toJson())),
        "currency": currency,
      };
}

class Item {
  String? itemId;
  ItemData? itemData;

  Item({
    this.itemId,
    this.itemData,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["item_id"],
        itemData: json["item_data"] == null
            ? null
            : ItemData.fromJson(json["item_data"]),
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_data": itemData?.toJson(),
      };
}

class ItemData {
  String? qty;
  String? itemName;
  String? priceTitle;
  String? price;
  Map<String, dynamic>? foodExtra;
  String? itemTotal;
  bool? status;

  ItemData({
    this.qty,
    this.itemName,
    this.priceTitle,
    this.price,
    this.foodExtra,
    this.itemTotal,
    this.status,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        qty: json["qty"],
        itemName: json["item_name"],
        priceTitle: json["price_title"],
        price: json["price"],
        foodExtra: (json["food_extra"] is List)
            ? null
            : (json["food_extra"] as Map<String, dynamic>),
        itemTotal: json["item_total"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "qty": qty,
        "item_name": itemName,
        "price_title": priceTitle,
        "price": price,
        "food_extra": foodExtra,
        "item_total": itemTotal,
        "status": status,
      };
}

class FoodExtraClass {
  String? mitBurrata;
  String? mitHhnchenstreifen;
  String? mitKseExtra;
  String? mitKnoblauch;
  String? mitProsciuttoParma;
  String? mitThunfisch;
  String? mitZwiebeln;

  FoodExtraClass({
    this.mitBurrata,
    this.mitHhnchenstreifen,
    this.mitKseExtra,
    this.mitKnoblauch,
    this.mitProsciuttoParma,
    this.mitThunfisch,
    this.mitZwiebeln,
  });

  factory FoodExtraClass.fromJson(Map<String, dynamic> json) => FoodExtraClass(
        mitBurrata: json["mit Burrata"],
        mitHhnchenstreifen: json["mit Hähnchenstreifen"],
        mitKseExtra: json["mit Käse, extra"],
        mitKnoblauch: json["mit Knoblauch"],
        mitProsciuttoParma: json["mit Prosciutto Parma"],
        mitThunfisch: json["mit Thunfisch"],
        mitZwiebeln: json["mit Zwiebeln"],
      );

  Map<String, dynamic> toJson() => {
        "mit Burrata": mitBurrata,
        "mit Hähnchenstreifen": mitHhnchenstreifen,
        "mit Käse, extra": mitKseExtra,
        "mit Knoblauch": mitKnoblauch,
        "mit Prosciutto Parma": mitProsciuttoParma,
        "mit Thunfisch": mitThunfisch,
        "mit Zwiebeln": mitZwiebeln,
      };
}

class Order {
  String? orderId;
  String? orderCustomerId;
  String? orderAmount;
  String? orderQty;
  String? orderType;
  String? orderPaymentMethod;
  String? orderItemIds;
  String? orderExtraIds;
  DateTime? orderDate;
  String? orderStatus;
  var orderTransaction;
  String? orderRestId;
  String? orderDeliveryCost;
  String? orderIsPrinted;
  String? orderIsViewed;
  String? orderPayoutStatus;
  String? orderDurationTime;
  String? orderTax;
  String? orderDiscount;
  String? orderSpecification;
  String? orderReservationTime;
  String? orderRemark;//here
  String? orderCurrency;
  String? orderMobileNotify;
  String? customerId;
  String? customerEmail;
  String? customerPhone;
  String? customerFloor;
  String? customerAddress;
  String? customerCity;
  String? customerPostcode;
  String? customerCompanyName;
  String? customerCountryAbv;
  String? customerName;
  String? userId;
  String? orderRemainingTime;

  Order({
    this.orderId,
    this.orderCustomerId,
    this.orderAmount,
    this.orderQty,
    this.orderType,
    this.orderPaymentMethod,
    this.orderItemIds,
    this.orderExtraIds,
    this.orderDate,
    this.orderStatus,
    this.orderTransaction,
    this.orderRestId,
    this.orderDeliveryCost,
    this.orderIsPrinted,
    this.orderIsViewed,
    this.orderPayoutStatus,
    this.orderDurationTime,
    this.orderTax,
    this.orderDiscount,
    this.orderSpecification,
    this.orderReservationTime,
    this.orderRemark,
    this.orderCurrency,
    this.orderMobileNotify,
    this.customerId,
    this.customerEmail,
    this.customerPhone,
    this.customerFloor,
    this.customerAddress,
    this.customerCity,
    this.customerPostcode,
    this.customerCompanyName,
    this.customerCountryAbv,
    this.customerName,
    this.userId,
    this.orderRemainingTime,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        orderCustomerId: json["order_customer_id"],
        orderAmount: json["order_amount"],
        orderQty: json["order_qty"],
        orderType: json["order_type"],
        orderPaymentMethod: json["order_payment_method"],
        orderItemIds: json["order_item_ids"],
        orderExtraIds: json["order_extra_ids"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        orderStatus: json["order_status"],
        orderTransaction: json["order_transaction"],
        orderRestId: json["order_rest_id"],
        orderDeliveryCost: json["order_delivery_cost"],
        orderIsPrinted: json["order_is_printed"],
        orderIsViewed: json["order_is_viewed"],
        orderPayoutStatus: json["order_payout_status"],
        orderDurationTime: json["order_duration_time"],
        orderTax: json["order_tax"],
        orderDiscount: json["order_discount"],
        orderSpecification: json["order_specification"],
        orderReservationTime: json["order_reservation_time"],
        orderRemark: json["order_remark"],
        orderCurrency: json["order_currency"],
        orderMobileNotify: json["order_mobile_notify"],
        customerId: json["customer_id"],
        customerEmail: json["customer_email"],
        customerPhone: json["customer_phone"],
        customerFloor: json["customer_floor"],
        customerAddress: json["customer_address"],
        customerCity: json["customer_city"],
        customerPostcode: json["customer_postcode"],
        customerCompanyName: json["customer_company_name"],
        customerCountryAbv: json["customer_country_abv"],
        customerName: json["customer_name"],
        userId: json["user_id"],
        orderRemainingTime: json["order_remaining_time"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_customer_id": orderCustomerId,
        "order_amount": orderAmount,
        "order_qty": orderQty,
        "order_type": orderType,
        "order_payment_method": orderPaymentMethod,
        "order_item_ids": orderItemIds,
        "order_extra_ids": orderExtraIds,
        "order_date": orderDate?.toIso8601String(),
        "order_status": orderStatus,
        "order_transaction": orderTransaction,
        "order_rest_id": orderRestId,
        "order_delivery_cost": orderDeliveryCost,
        "order_is_printed": orderIsPrinted,
        "order_is_viewed": orderIsViewed,
        "order_payout_status": orderPayoutStatus,
        "order_duration_time": orderDurationTime,
        "order_tax": orderTax,
        "order_discount": orderDiscount,
        "order_specification": orderSpecification,
        "order_reservation_time": orderReservationTime,
        "order_remark": orderRemark,
        "order_currency": orderCurrency,
        "order_mobile_notify": orderMobileNotify,
        "customer_id": customerId,
        "customer_email": customerEmail,
        "customer_phone": customerPhone,
        "customer_floor": customerFloor,
        "customer_address": customerAddress,
        "customer_city": customerCity,
        "customer_postcode": customerPostcode,
        "customer_company_name": customerCompanyName,
        "customer_country_abv": customerCountryAbv,
        "customer_name": customerName,
        "user_id": userId,
        "order_remaining_time": orderRemainingTime,
      };
}

class SubTotal {
  String? label;
  String? value;

  SubTotal({
    this.label,
    this.value,
  });

  factory SubTotal.fromJson(Map<String, dynamic> json) => SubTotal(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}

class FoodExtraModel {
  final List<String> title;
  final List<String> price;

  FoodExtraModel({required this.price, required this.title});
}
