import 'package:flutter/cupertino.dart';

class AppAssets {
  static const imagePath = "assets/images/";

  static const appLogo = "${imagePath}img_app_logo.png";
  static const loginBackgroundImg = "${imagePath}img_login_background.jpg";
  static const dontMissImg = "${imagePath}img_dont_miss.png";
  static const cartImg = "${imagePath}img_cart.png";
  static const userImg = "${imagePath}img_user.png";
  static const locationImg = "${imagePath}img_location.png";
  static const phoneImg = "${imagePath}img_phone.png";
  static const emailImg = "${imagePath}img_email.png";
  static const tableImg = "${imagePath}img_table.png";
  static const peopleImg = "${imagePath}img_people.png";
  static const calenderImg = "${imagePath}img_calendar.png";
  static const deliveryImg = "${imagePath}img_delivery.png";
  static const packetImg = "${imagePath}img_packet.png";
  static const coinImg = "${imagePath}img_coin.png";
  static const deliveryRoundImg = "${imagePath}img_delivery_round.png";
  static const phone2Img = "${imagePath}img_phone2.png";
  static const stopwatchImg = "${imagePath}img_stopwatch.png";
  static const packetRoundedImg = "${imagePath}img_packet_round.png";
  static const audioDummyMp = "${imagePath}audio_dummy.wav";
}

Widget assetImage(String image, {double? height, double? width, Color? color}) {
  return Image.asset(
    image,
    height: height,
    width: width,
    color: color
  );
}

AssetImage assetsImage2(String image,
    {double? height, double? width, Color? color}) {
  return AssetImage(image);
}
