import 'dart:async';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pos_uga/models/user_model.dart';

class SplashScreenController extends GetxController {
  final obj = ''.obs;
  @override
  void onInit() {
    splash();
    super.onInit();
  }

  Future splash() async {
    return Timer(Duration(seconds: 3), () async {
      try {
        var boxUser = await Hive.openBox("user_model");
        UserModel user = boxUser.getAt(0);
        if (user != null) {
          Get.offAllNamed("/home");
        }
      } catch (e) {
        Get.offAllNamed("/login");
      }
    });
  }
}

class SplashScreenPage extends GetView<SplashScreenController> {
  final controller = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(640, 360), allowFontScaling: true);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Parent(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Txt(
                    "POS Uga",
                    style: TxtStyle()
                      ..fontSize(35.sp)
                      ..textColor(Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Txt(
                    "Versi 1.0",
                    style: TxtStyle()
                      ..fontSize(24.sp)
                      ..textColor(Colors.white),
                  ),
                )
              ],
            ),
            style: ParentStyle()
              ..width(1.sw)
              ..height(1.sh)
              ..padding(vertical: 0.05.sh, horizontal: 0.05.sw)));
  }
}
