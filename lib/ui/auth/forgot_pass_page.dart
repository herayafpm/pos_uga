import 'dart:async';

import 'package:division/division.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pos_uga/bloc/auth/authbloc.dart';
import 'package:pos_uga/controllers/forgot_pass_controller.dart';

// ignore: must_be_immutable
class ForgotPassPage extends GetView<ForgotPassController> {
  final controller = Get.put(ForgotPassController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(640, 360), allowFontScaling: true);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
            create: (context) => AuthBloc(), child: FormForgotPassView()));
  }
}

// ignore: must_be_immutable
class FormForgotPassView extends StatelessWidget {
  final controller = Get.find<ForgotPassController>();
  // ignore: close_sinks
  AuthBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) async {
        if (state is AuthBlocStateLoading) {
          controller.isLoading.value = true;
        } else if (state is AuthBlocStateSuccess) {
          controller.isLoading.value = false;
          Flushbar(
            title: "Success",
            message: state.data['message'] ?? "",
            icon: Icon(
              Icons.check,
              color: Colors.greenAccent,
            ),
            duration: Duration(seconds: 2),
          )..show(context);
          Timer(Duration(seconds: 4), () {
            Get.back();
          });
        } else if (state is AuthBlocStateError) {
          controller.isLoading.value = false;
          Flushbar(
            title: "Error",
            message: state.errors['data']['username'] ??
                state.errors['data']['message'] ??
                "",
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
                Txt("Lupa Password",
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
                      if (value != controller.password2Controller.text) {
                        return "Password harus sama";
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
                Obx(() => TextFormField(
                    controller: controller.password2Controller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Konfirmasi Password tidak boleh kosong";
                      }
                      if (value.length < 6) {
                        return "Konfirmasi Password harus lebih dari 6 karakter";
                      }
                      if (value != controller.passwordController.text) {
                        return "Konfirmasi Password harus sama";
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
                        hintText: "Konfirmasi Password",
                        hintStyle: TextStyle(color: Colors.white60)))),
                SizedBox(
                  height: 0.02.sh,
                ),
                Parent(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            "Sudah ingat password?",
                            style: TxtStyle()..textColor(Colors.white),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Txt(
                              "Masuk",
                              style: TxtStyle()..textColor(Colors.white),
                            ),
                          )
                        ]),
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
                                "Kirim Data",
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
                                  controller.forgotpass(bloc);
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
