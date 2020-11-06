import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pos_uga/models/user_model.dart';

class HomeDistributorController extends GetxController {
  final obj = ''.obs;
  final userModel = UserModel().obs;

  @override
  void onInit() async {
    try {
      var boxUser = await Hive.openBox("user_model");
      UserModel user = boxUser.getAt(0);
      if (user != null) {
        userModel.value = user;
      }
    } catch (e) {
      Get.offAllNamed("/login");
    }
    super.onInit();
  }
}

class HomeDistributorPage extends GetView<HomeDistributorController> {
  final controller = Get.put(HomeDistributorController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(640, 360), allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF018577),
        title: Txt("Dashboard"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_box, color: Colors.white, size: 70.sp),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  Obx(() => Txt(
                        controller.userModel.value.nama.capitalizeFirst,
                        style: TxtStyle()
                          ..textColor(Colors.white)
                          ..fontSize(30.sp),
                      ))
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFF018577),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Profil'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.local_offer),
              title: Text('Barang'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Data Penjualan'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Mitra'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(),
            Txt("Sistem",
                style: TxtStyle()
                  ..textColor(Colors.grey[500])
                  ..margin(left: 0.05.sw)),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Tentang'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Logout'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
