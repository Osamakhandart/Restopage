// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/controllers/home_screen_controller.dart';
import 'package:resto_page/utils/extension.dart';

import '../constant/app_assets.dart';
import '../constant/app_color.dart';

/// DELIVERY TIMER
class DeliveryTimer extends StatefulWidget {
  final String dateTime;
  final Color? textColor;

  const DeliveryTimer({super.key, required this.dateTime, this.textColor});

  @override
  _DeliveryTimerState createState() => _DeliveryTimerState();
}

class _DeliveryTimerState extends State<DeliveryTimer> {
  final homeScreenCtrl = Get.find<HomeScreenController>();
  late Timer _timer;
  late Duration _duration;
  String second = "";
  TimeOfDay? startOpeningTime;

  DateTime? orderDate;
  DateTime? openingDate;

  @override
  void initState() {
    super.initState();
    _calculateTimer();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateTimer() {
    second = widget.dateTime.contains("-") ? "0" : widget.dateTime;
    // print("Before Duration ---> $_duration");
    _duration = Duration(seconds: num.parse(second).toInt());
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration -= const Duration(seconds: 1);
          // _duration = _duration - const Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return hours == 00
        ? '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
        : '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _formatDuration(_duration).appTextStyle400(
            fontColor: widget.textColor ?? Colors.white, fontSize: 13));
  }
}

/// REMAINING ORDER TIMER
class RemainingTimer extends StatefulWidget {
  final String orderTime;
  final double? fontSize;

  const RemainingTimer({super.key, required this.orderTime, this.fontSize});

  @override
  State<RemainingTimer> createState() => _RemainingTimerState();
}

class _RemainingTimerState extends State<RemainingTimer> {
  late Timer _timer;
  late Duration _duration;
  String second = "";

  @override
  void initState() {
    super.initState();
    _calculateTimer();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateTimer() {
    second = widget.orderTime.contains("-") ? "0" : widget.orderTime;
    _duration = Duration(seconds: num.parse(second).toInt());
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration -= const Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return hours == 00
        ? '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
        : '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _formatDuration(_duration).appTextStyle400(
            fontColor: greyColor, fontSize: widget.fontSize ?? 13));
  }
}

/// PRE ORDER TIMER
class PreOrderTimer extends StatefulWidget {
  final DateTime? placedOrderDate;
  final bool showTimerIcon;

  // final bool isTested;
  final String orderType;

  const PreOrderTimer({
    super.key,
    required this.placedOrderDate,
    required this.orderType,
    this.showTimerIcon = true,
    // required this.isTested
  });

  @override
  State<PreOrderTimer> createState() => _PreOrderTimerState();
}

class _PreOrderTimerState extends State<PreOrderTimer> {
  late Timer _timer;
  late DateTime _orderTime;
  DateTime currentTime = DateTime.now();
  Duration? _duration;
  final homeScreenCtrl = Get.find<HomeScreenController>();

  @override
  void initState() {
    super.initState();
    _calculateTimer();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Duration beforeOpen = const Duration(seconds: 00, minutes: 00);

  void _calculateTimer() {
    Duration? _tempDuration = null;
    _duration = null;
    _orderTime = widget.placedOrderDate ?? DateTime(1998, 08, 05);
    Duration _orderDuration = DateTime.now().difference(_orderTime);
    TimeOfDay? startOpeningTime;
    TimeOfDay? secondOpeningStartTime;
    TimeOfDay? startOpeningEndTime;
    TimeOfDay? secondOpeningEndTime;

    if (widget.orderType == "delivery") {
      startOpeningTime = homeScreenCtrl.firstDeliverTime;
      secondOpeningStartTime = homeScreenCtrl.secondDeliverStartTime;
      startOpeningEndTime = homeScreenCtrl.firstDeliverEndTime;
      secondOpeningEndTime = homeScreenCtrl.secondDeliverEndTime;
    } else if (widget.orderType == "pickup") {
      startOpeningTime = homeScreenCtrl.firstPickUpTime;
      secondOpeningStartTime = homeScreenCtrl.secondPickUpStartTime;
      startOpeningEndTime = homeScreenCtrl.firstPickUpEndTime;
      secondOpeningEndTime = homeScreenCtrl.secondPickUpEndTime;
    } else if (widget.orderType == "reservation") {
      startOpeningTime = homeScreenCtrl.firstOpeningTime;
      secondOpeningStartTime = homeScreenCtrl.secondOpeningStartTime;
      startOpeningEndTime = homeScreenCtrl.firstOpeningEndTime;
      secondOpeningEndTime = homeScreenCtrl.secondOpeningEndTime;
    }

    if (_orderDuration.inDays >= 7) {
      return;
    }
    _tempDuration =
        _setTimerBeforeStart(startOpeningTime!, secondOpeningStartTime!);
    if (_tempDuration != null) {
      _duration = _tempDuration;
      setState(() {});
      return;
    }
    _tempDuration = _setTimerInOpenTime(startOpeningTime, startOpeningEndTime!,
        secondOpeningStartTime, secondOpeningEndTime!);
    if (_tempDuration != null) {
      _duration = _tempDuration;
      setState(() {});
      return;
    }
    _tempDuration =
        _setTimerAfterClose(startOpeningTime, secondOpeningStartTime);
    if (_tempDuration != null) {
      _duration = _tempDuration;
      setState(() {});
      return;
    }
    setState(() {});
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration != null) {
        if (_duration!.isNegative || (_duration!.inSeconds == 00)) {
          setState(() {
            _duration = null;
            _timer.cancel();
          });
        } else {
          setState(() {
            if (_duration!.inSeconds > 0) {
              _duration = _duration! - const Duration(seconds: 1);
              _calculateTimer();
            } else {
              _calculateTimer();
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _duration != null
        ? Row(
            children: [
              widget.showTimerIcon
                  ? assetImage(AppAssets.stopwatchImg, height: 18, width: 18)
                  : assetImage(AppAssets.packetRoundedImg,
                      height: 25, width: 25),
              5.0.addWSpace(),
              _formatDuration(_duration!)
                  .appTextStyle400(fontColor: greyColor, fontSize: 13)
            ],
          ).paddingOnly(right: 10)
        : const SizedBox();
  }

  Duration? _setTimerBeforeStart(
      TimeOfDay resStartTime, TimeOfDay secondResStartTime) {
    DateTime _resStartTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, resStartTime.hour, resStartTime.minute);
    if (_orderTime.isBefore(_resStartTime)) {
      Duration difference = _orderTime.difference(_resStartTime);
      difference = Duration(minutes: difference.inMinutes + 20);
      return difference;
    } else {
      return null;
    }
  }

  Duration? _setTimerInOpenTime(TimeOfDay resStartTime, TimeOfDay resEndTime,
      TimeOfDay secondeResStartTime, TimeOfDay secondeResEndTime) {
    DateTime _resStartTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, resStartTime.hour, resStartTime.minute);

    DateTime _resEndTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, resEndTime.hour, resEndTime.minute);

    DateTime _secondeResStartTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        secondeResStartTime.hour,
        secondeResStartTime.minute);

    DateTime _secondeResEndTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, secondeResEndTime.hour, secondeResEndTime.minute);

    if (_orderTime.isAfter(_resStartTime) && _orderTime.isBefore(_resEndTime)) {
      DateTime actionTime = _orderTime.add(const Duration(minutes: 20));
      if (DateTime.now().isBefore(actionTime)) {
        Duration difference = actionTime.difference(DateTime.now());
        return difference;
      }
    } else if (_orderTime.isBefore(_secondeResStartTime)) {
      DateTime actionTime = _orderTime.add(const Duration(minutes: 20));
      if (DateTime.now().isBefore(actionTime)) {
        Duration difference = _orderTime.difference(_secondeResStartTime);
        difference = Duration(minutes: difference.inMinutes + 20);
        return difference;
      }
    } else if (_orderTime.isAfter(_secondeResStartTime) &&
        _orderTime.isBefore(_secondeResEndTime)) {
      DateTime actionTime = _orderTime.add(const Duration(minutes: 20));
      if (DateTime.now().isBefore(actionTime)) {
        Duration difference = actionTime.difference(DateTime.now());
        return difference;
      }
    }
    return const Duration(seconds: 00, minutes: 00);
  }

  Duration? _setTimerAfterClose(
      TimeOfDay resEndTime, TimeOfDay secondResEndTime) {
    DateTime _resStartTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, resEndTime.hour, resEndTime.minute);
    DateTime _secondResStartTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, secondResEndTime.hour, secondResEndTime.minute);

    if (_orderTime.isAfter(_resStartTime)) {
      DateTime _dayEndTime = DateTime(2023, 08, 10, 23, 59, 59);

      Duration difference =
          _dayEndTime.difference(_orderTime.add(const Duration(minutes: -20)));
      return difference;
    } else if (_orderTime.isAfter(_secondResStartTime)) {
      DateTime _dayEndTime = DateTime(2023, 08, 10, 23, 59, 59);

      Duration difference =
          _dayEndTime.difference(_orderTime.add(const Duration(minutes: -20)));
      return difference;
    }
    return null;
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return hours == 00
        ? '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
        : '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

/*  String _formatDuration(Duration duration) {
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  */

/*bool _setTimerBeforeStart(TimeOfDay resStartTime) {
    DateTime _resStartTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, resStartTime.hour, resStartTime.minute);
    if (_orderTime.isBefore(_resStartTime)) {
      Duration difference = _orderTime.difference(_resStartTime);
      difference = Duration(minutes: difference.inMinutes + 20);
      log("Order Before Restaurant Open and Difference ------> ${difference.inHours.remainder(24).toString().replaceAll("-", "")}:${difference.inMinutes.remainder(60).toString().replaceAll("-", "")}");
      return true;
    } else {
      return false;
    }
  }*/

/*bool _setTimerInOpenTime(TimeOfDay resStartTime, TimeOfDay resEndTime) {

    DateTime _resStartTime = DateTime(currentTime.year, currentTime.month, currentTime.day, resStartTime.hour, resStartTime.minute);

    DateTime _resEndTime = DateTime(currentTime.year, currentTime.month, currentTime.day, resStartTime.hour, resStartTime.minute);

    if (_orderTime.isAfter(_resStartTime) && _orderTime.isBefore(_resEndTime)) {
      DateTime actionTime = _orderTime.add(const Duration(minutes: 20));

      if (DateTime.now().isBefore(actionTime)) {
        Duration difference = actionTime.difference(DateTime.now());
        log("Order Placed ------> ${difference.inHours.remainder(24).toString().replaceAll("-", "")}:${difference.inMinutes.remainder(60).toString().replaceAll("-", "")}");
      }
    }
    return false;
  }*/

/*bool _setTimerAfterClose(TimeOfDay resEndTime) {
    DateTime _resStartTime = DateTime(currentTime.year, currentTime.month, currentTime.day, resEndTime.hour, resEndTime.minute);
    if (_orderTime.isAfter(_resStartTime)) {
      DateTime _dayEndTime = DateTime(2023, 08, 8, 23, 59, 59);

      Duration difference = _dayEndTime.difference(_orderTime.add(const Duration(minutes: -20)));
      log("Order After Restaurant Closed and Difference ------> ${difference.inHours.remainder(24).toString().replaceAll("-", "")}:${difference.inMinutes.remainder(60).toString().replaceAll("-", "")}");
    }

    return false;
  }*/
