import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_uga/bloc/auth/authbloc.dart';

class ForgotPassController extends GetxController {
  final username = ''.obs;
  final password = ''.obs;
  final password2 = ''.obs;
  final isShowPass = false.obs;
  final isLoading = false.obs;
  final status = false.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void forgotpass(AuthBloc bloc) async {
    if (status.value) {
      isLoading.value = !isLoading.value;
      username.value = usernameController.text;
      password.value = passwordController.text;
      bloc..add(AuthBlocForgotPassEvent(username.value, password.value));
    } else {
      Flushbar(
        title: "Koneksi",
        message: "Anda tidak memiliki koneksi",
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.do_not_disturb,
          color: Colors.redAccent,
        ),
      )..show(Get.context);
    }
  }
}
