import 'dart:async';

import 'package:division/division.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pos_uga/bloc/auth/authbloc.dart';
import 'package:pos_uga/controllers/login_controller.dart';
import 'package:pos_uga/models/user_model.dart';

class LoginPage extends GetView<LoginController> {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(640, 360), allowFontScaling: true);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
            create: (context) => AuthBloc(), child: FormLoginView()));
  }
}

// ignore: must_be_immutable
class FormLoginView extends StatelessWidget {
  final controller = Get.find<LoginController>();
  // ignore: close_sinks
  AuthBloc authBloc;
  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) async {
        if (state is AuthBlocStateLoading) {
          controller.isLoading.value = true;
        } else if (state is AuthBlocStateSuccess) {
          controller.isLoading.value = false;
          Flushbar(
            title: "Success",
            message: state.data['message'],
            icon: Icon(
              Icons.check,
              color: Colors.greenAccent,
            ),
            duration: Duration(seconds: 2),
          )..show(context);
          var boxUser = await Hive.openBox("user_model");
          var userModel = UserModel.createFromJson(state.data['data']);
          boxUser.add(userModel);
          Get.offAllNamed("/home");
        } else if (state is AuthBlocStateError) {
          controller.isLoading.value = false;
          Flushbar(
            title: "Error",
            message: state.errors['message'],
            duration: Duration(seconds: 5),
            icon: Icon(
              Icons.do_not_disturb,
              color: Colors.redAccent,
            ),
          )..show(Get.context);
        }
      },
      child: Parent(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_box,
                  size: 0.15.sw,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 0.01.sh,
                ),
                Txt("Login",
                    style: TxtStyle()
                      ..textColor(Colors.white)
                      ..fontSize(30.ssp)
                      ..fontWeight(FontWeight.w500)),
                SizedBox(
                  height: 0.02.sh,
                ),
                TextFormField(
                    controller: controller.usernameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Username tidak boleh kosong";
                      }
                      return null;
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide:
                                new BorderSide(color: Colors.white, width: 2)),
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide:
                                new BorderSide(color: Colors.white, width: 2)),
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.white60))),
                SizedBox(
                  height: 0.02.sh,
                ),
                Obx(() => TextFormField(
                    controller: controller.passwordController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Password tidak boleh kosong";
                      }
                      if (value.length < 6) {
                        return "Password harus lebih dari 6 karakter";
                      }
                      return null;
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    obscureText: !controller.isShowPass.value,
                    decoration: InputDecoration(
                        suffixStyle: TextStyle(backgroundColor: Colors.white),
                        suffixIcon: Obx(() => IconButton(
                              icon: Icon((controller.isShowPass.value)
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.white,
                              onPressed: () {
                                controller.isShowPass.value =
                                    !controller.isShowPass.value;
                              },
                            )),
                        enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide:
                                new BorderSide(color: Colors.white, width: 2)),
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            borderSide:
                                new BorderSide(color: Colors.white, width: 2)),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white60)))),
                SizedBox(
                  height: 0.02.sh,
                ),
                Parent(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Lupa Password?",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed("/forgotpass"))
                      ]),
                    ),
                    style: ParentStyle()
                      ..width(1.sw)
                      ..alignmentContent.centerRight()),
                SizedBox(
                  height: 0.02.sh,
                ),
                Obx(() => Parent(
                      child: Center(
                        child: (controller.isLoading.value)
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                                width: 20,
                                height: 20,
                              )
                            : Txt(
                                "Login",
                                style: TxtStyle()
                                  ..fontSize(23.sp)
                                  ..textColor(Colors.white)
                                  ..fontWeight(FontWeight.bold),
                              ),
                      ),
                      gesture: Gestures()
                        ..onTap((controller.isLoading.value)
                            ? null
                            : () {
                                if (controller.formKey.currentState
                                    .validate()) {
                                  controller.login(authBloc);
                                }
                              }),
                      style: ParentStyle()
                        ..height(0.06.sh)
                        ..width(0.9.sw)
                        ..opacity((!controller.isLoading.value) ? 1 : 0.8)
                        ..background.color(Color(0xFFFF4E4C))
                        ..borderRadius(all: 4)
                        ..elevation((!controller.isLoading.value) ? 3 : 0)
                        ..ripple(!controller.isLoading.value,
                            splashColor: Colors.white),
                    ))
              ],
            ),
          ),
          style: ParentStyle()
            ..width(1.sw)
            ..height(1.sh)
            ..background.color(Color(0xFF018577))
            ..padding(vertical: 0.05.sh, horizontal: 0.05.sw)),
    );
  }
}
