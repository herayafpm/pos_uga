import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as Trans;
import 'package:hive/hive.dart';
import 'package:pos_uga/models/user_model.dart';
import 'package:pos_uga/splash_screen_page.dart';
import 'package:pos_uga/ui/auth/forgot_pass_page.dart';
import 'package:pos_uga/ui/auth/login_page.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:pos_uga/ui/distributor/home_distributor_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserModelAdapter());
  runApp(App());
}

final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Color(0xFF018577),
  primaryColor: Colors.blueAccent,
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Georgia',
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Pos Uga",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: appThemeData,
      defaultTransition: Trans.Transition.fadeIn,
      getPages: [
        GetPage(name: "/", page: () => SplashScreenPage()),
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/forgotpass", page: () => ForgotPassPage()),
        GetPage(name: "/home", page: () => HomeDistributorPage()),
      ],
    );
  }
}
