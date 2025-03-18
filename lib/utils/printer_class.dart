import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:gcprinter/gcprinter.dart';
import 'package:intl/intl.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/models/view_order_model.dart';
import 'package:resto_page/utils/shared_prefs.dart';

class PrintService {
  final preferences = SharedPreference();
  final ViewOrderModel orderModel;

  PrintService(this.orderModel);
Future<Uint8List> _getAssetImage(String assetPath) async {
  // Load the image as byte data from the asset bundle.
  final ByteData data = await rootBundle.load(assetPath);

  // Convert the byte data to a Uint8List.
  final Uint8List bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  return bytes;
}
Future<Uint8List> getResizedImage(String imagePath, int width, int height, {bool isAsset = true, int padding = 200}) async {
  List<int> imageBytes;

  if (isAsset) {
    // Load the image as byte data from the asset bundle.
    final ByteData data = await rootBundle.load(imagePath);
    imageBytes = data.buffer.asUint8List();
  } else {
    // Load the image from a local file.
    final File imageFile = File(imagePath);
    imageBytes = await imageFile.readAsBytes();
  }

  // Decode the image.
  final img.Image? originalImage = img.decodeImage(imageBytes);
  if (originalImage == null) {
    throw Exception("Failed to decode image.");
  }

  // Resize the image.
  final img.Image resizedImage = img.copyResize(originalImage, width: width, height: height);

  // Create a new image with padding (only if not an asset)
  img.Image finalImage;
  if (!isAsset && padding > 0) {
    final paddedWidth = width + 2 * padding;
    finalImage = img.Image(paddedWidth, height); // New image with additional horizontal space
    img.fill(finalImage, img.getColor(0, 0, 0, 0)); // Fill with transparent color; change as needed
    img.copyInto(finalImage, resizedImage, dstX: padding, blend: false); // Paste resized image centered
  } else {
    finalImage = resizedImage;
  }

  // Encode the resized image to PNG (or you could use jpg or another format depending on your requirements).
  List<int> resizedBytes = img.encodePng(finalImage);

  return Uint8List.fromList(resizedBytes);
}





img.Image resizeImage(img.Image originalImage, int width, int height) {
  return img.copyResize(originalImage, width: width, height: height);
}




Future<String> fetchAddress() async {

  final String address1 =       preferences.getString(SharedPreference.ADDRESS_NO_1, defValue: ".") ??
            ".";
  return address1;
}

Future<String> resturantName() async {

  final String resturant=       preferences.getString(SharedPreference.REST_NAME, defValue: ".") ??
            ".";
  return resturant;
}
Future<List<String>> printAddress() async {
  String address = await fetchAddress(); // Fetch the address
  List<String> addressParts = address.split(','); // Split the address by commas
List<String>? addressRest=[];
  // Iterate over each part and print it on a new line
  for (String part in addressParts) {
    part = part.trim(); 
    addressRest.add(part);
    // Trim whitespace

    // if (part.isNotEmpty) {
    //   Gcprinter.drawText(part, Gcprinter.fontSmall, "", 0, "", 0);
    // }
  }
      return addressRest!;
}
Future<List<String>> printAddressCustomer(address) async {
// Fetch the address
  List<String> addressParts = address.split(','); // Split the address by commas
List<String>? addressRest=[];
  // Iterate over each part and print it on a new line
  for (String part in addressParts) {
    part = part.trim(); 
    addressRest.add(part);
    // Trim whitespace

    // if (part.isNotEmpty) {
    //   Gcprinter.drawText(part, Gcprinter.fontSmall, "", 0, "", 0);
    // }
  }
      return addressRest!;
}
String capitalize(String? text) {
  if (text == null || text.isEmpty) {
    return "";
  }
  return text[0].toUpperCase() + text.substring(1);
}


String formatDateTime(String? dateTimeStr) {
  // Parse the original date string
  DateTime dateTime = DateTime.parse(dateTimeStr!);
  // Create a new DateFormat
  DateFormat formatter = DateFormat('dd/MM/yyyy | HH:mm');
  // Return the formatted date
  return formatter.format(dateTime);
}


Future<void> printOrderReceipt({String? duration}) async {
  print('printing');
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/logo.png';
  File imageFile = File(filePath);

  // Ensure the file exists before attempting to print
  if (!await imageFile.exists()) {
    print("Logo file does not exist.");
    return;
  } else {
    print('file exists');
  }

 
  Uint8List bytes = await getResizedImage(filePath, 200, 120, isAsset: false);
  Uint8List inBytes = await getResizedImage("assets/images/endblack.png", 600, 150,isAsset: true);  // Set desired size here.

  List<String> address = await printAddress();
  String rest = await resturantName();
  String formattedDate = formatDateTime(orderModel.order?.orderDate!.toIso8601String());
   Future.delayed(Duration(seconds: 3));
  // Send the image data to the printer.
  Gcprinter.printImage(bytes, Gcprinter.alignCenter, false);
    Future.delayed(Duration(seconds: 3));


  Gcprinter.drawOneLine(10);


 // Start printing the receipt header
  Gcprinter.drawText("Order Nr.: ${orderModel.order?.orderId}", Gcprinter.fontSmall, "", 0, "", 0);
  Gcprinter.drawText("Date: $formattedDate", Gcprinter.fontSmall, "", 0, "", 0);
  // Gcprinter.printText(true);
  if (orderModel.order!.orderReservationTime == '' || orderModel.order!.orderReservationTime!.isEmpty) {
    Gcprinter.drawText("${capitalize(orderModel.order?.orderType)} in ${orderModel.order?.orderDurationTime == '0' ? duration : orderModel.order?.orderDurationTime} Minutes", Gcprinter.fontSmall, "", 0, "", 0);
  } else {
    Gcprinter.drawText("${capitalize(orderModel.order?.orderType)} Pre-Order: ${orderModel.order?.orderReservationTime}", Gcprinter.fontSmall, "", 0, "", 0);
  }

 Gcprinter.drawOneLine(10);
  Gcprinter.drawText('ORDER: ', Gcprinter.fontMediumBold, "", 0, "", 0);

  // Print each item
  for (Item item in orderModel.items ?? []) {
    Gcprinter.drawLeftRight("${item.itemData!.qty}x ${item.itemData!.itemName}", "${item.itemData?.itemTotal}${orderModel!.currency}", Gcprinter.fontSmallBold);
    Gcprinter.drawText("${item.itemData?.priceTitle}: ${item.itemData!.price}${orderModel!.currency}", Gcprinter.fontSmallBold, "", 0, "", 0);
    if (item.itemData?.foodExtra != null) {
      item.itemData?.foodExtra?.forEach((key, value) {
        Gcprinter.drawLeftRight("- $key", '${value}${orderModel!.currency}', Gcprinter.fontSmall);
      });
    }
    Gcprinter.drawOneLine(10);
  }

  Gcprinter.drawLeftRight("TOTAL:", "${orderModel.order?.orderAmount} €", Gcprinter.fontSmallBold);

  orderModel.subTotal?.forEach((sub) {
    Gcprinter.drawLeftRight("${sub.label}:", "${sub.value} €", Gcprinter.fontSmall);
  });
  Gcprinter.drawOneLine(10);
  Gcprinter.drawLeftRight("PAID:", orderModel.order!.orderPaymentMethod == 'stripe' ? 'Yes' : 'No', Gcprinter.fontSmallBold);
  Gcprinter.drawLeftRight("DUE:", orderModel.order!.orderPaymentMethod == 'stripe' ? "0€" : "${orderModel.order?.orderAmount}€", Gcprinter.fontSmallBold);
  Gcprinter.drawLeftRight("Method of Payment:", "${orderModel.order?.orderPaymentMethod} €", Gcprinter.fontSmall);
  Gcprinter.drawOneLine(10);

  // Delivery address
  if (orderModel.order?.orderType == 'delivery' && orderModel.order?.customerAddress != '') {
    Gcprinter.drawText('Customer Address', Gcprinter.fontSmallBold, "", 0, "", 0);
    List<String> customerAddress = await printAddressCustomer(orderModel.order?.customerAddress);
    if (orderModel.order?.customerFloor != "") {
      Gcprinter.drawText("${AppString.floorText.tr}: ${orderModel.order?.customerFloor ?? ""}", Gcprinter.fontSmall, "", 0, "", 0);
    }
    if (orderModel.order?.customerCompanyName != "") {
      Gcprinter.drawText("${AppString.companyText.tr}: ${orderModel.order?.customerCompanyName ?? ""}", Gcprinter.fontSmall, "", 0, "", 0);
    }
    for (var item in customerAddress) {
      Gcprinter.drawText(item, Gcprinter.fontSmall, "", 0, "", 0);
    }
  }

  Gcprinter.drawOneLine(10);

  // Customer note
  if (orderModel.order?.orderRemark != null) {
    Gcprinter.drawText("CUSTOMER NOTE:", Gcprinter.fontSmallBold, "", 0, "", 0);
    Gcprinter.drawText("\"${orderModel.order!.orderRemark}\"", Gcprinter.fontSmall, "", 0, "", 0);
  }
  Gcprinter.drawOneLine(10);

  // Restaurant name and address
  if (rest.isNotEmpty) {
    Gcprinter.drawText(rest, Gcprinter.fontSmall, "", 0, "", 0);
  }

  if (address.isNotEmpty) {
    for (var item in address) {
      Gcprinter.drawText(item, Gcprinter.fontSmall, "", 0, "", 0);
    }
  }

  Gcprinter.drawOneLine(10);
  Gcprinter.drawText("", 0, "Thank you for your order!", Gcprinter.fontMediumBold, "", 0);
  Gcprinter.drawOneLine(10);
 Gcprinter.printImage(inBytes, Gcprinter.alignCenter, false);
  // Add extra blank lines for easier cutting
  Gcprinter.drawNewLine();
  Gcprinter.drawNewLine();
  Gcprinter.drawNewLine();
   Future.delayed(Duration(seconds: 5));
 Gcprinter.printText(true);
  // Print the final image
 
}

void mockPrintOrderReceipt() {
  print("printing");
  print("=" * 40); // Print a divider for the header
  print("Order Nr.: ${orderModel.order?.orderId}");
  print("Date: ${orderModel.order?.orderDate}");

  if (orderModel.order?.orderReservationTime == '' || orderModel.order!.orderReservationTime!.isEmpty) {
      print("${capitalize(orderModel.order?.orderType)} in ${orderModel.order?.orderDurationTime} Minutes");
  } else {
      print("${capitalize(orderModel.order?.orderType)} Pre-Order: ${orderModel.order?.orderReservationTime}");

  }

  print("\nORDER:");
  orderModel.items?.forEach((item) {
    print("${item.itemData?.qty}x ${item.itemData?.itemName} - ${item.itemData?.price}${orderModel.currency}");
    item.itemData?.foodExtra?.forEach((key, value) {
      print("  - $key: $value${orderModel.currency}");
    });
  });

  print("=" * 40);
  print("TOTAL: ${orderModel.order?.orderAmount}€");
  String paidStatus = orderModel.order?.orderPaymentMethod == 'stripe' ? 'Yes' : 'No';
  String dueAmount = orderModel.order?.orderPaymentMethod == 'stripe' ? "0€" : "${orderModel.order?.orderAmount}€";
  print("PAID: $paidStatus");
  print("DUE: $dueAmount");
  print("Method of Payment: ${orderModel.order?.orderPaymentMethod}€");

  if (orderModel.order?.orderType == 'delivery' && orderModel.order?.customerAddress != null) {
    print("\nCustomer Address:");
    orderModel.order?.customerAddress!.split(', ').forEach(print);
  }
  

  if (orderModel.order?.orderRemark != null) {
    print("\nCUSTOMER NOTE:");
    print("\"${orderModel.order?.orderRemark}\"");
  }

  print("\nRestaurant Name and Address:");
  // Assume `rest` and `address` are available here
  print("YOUR_RESTAURANT_NAME");
  // Example address, split each line
  ["123 Main St", "City, Country"].forEach(print);

  print("\nThank you for your order!");
  print("=" * 40);
}
}
