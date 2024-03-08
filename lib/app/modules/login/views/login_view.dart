// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/components/customs/custom_progress_indicator.dart';
import 'package:gearhaven/app/components/customs/custom_textfield.dart';
import 'package:gearhaven/app/components/login_page_background.dart';
import 'package:gearhaven/app/modules/register/views/register_view.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/views/views/forgot_password_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    return Obx(
      () => Stack(
        children: [
          LoginPageBackground(),
          controller.isLoading.value
              ? CustomProgressIndicator(
                  color: CustomColors.accentColor,
                )
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.loginFormKey,
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              child: Center(
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  CustomTextfield(
                                    label: "Email",
                                    controller: controller.emailController,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextfield(
                                    controller: controller.passwordController,
                                    label: "Password",
                                    isPassword: true,
                                  ),
                                  // SizedBox(
                                  //   width: 350,
                                  //   child: TextField(
                                  //     decoration: InputDecoration(
                                  //       label: Text(
                                  //         "Password",
                                  //         style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 20,
                                  //         ),
                                  //       ),
                                  //       enabledBorder: UnderlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //           color: Colors.white,
                                  //           width: 2,
                                  //           style: BorderStyle.solid,
                                  //         ),
                                  //       ),
                                  //       suffixIcon: Icon(
                                  //         Icons.visibility_off_rounded,
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => ForgotPasswordView());
                                      },
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  CustomButton(
                                    label: "Login",
                                    onPressed: () {
                                      controller.validateLogin();
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Not registered yet? ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => RegisterView());
                                        },
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
