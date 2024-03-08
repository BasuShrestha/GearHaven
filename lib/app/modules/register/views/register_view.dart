// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/components/customs/custom_textfield.dart';
import 'package:gearhaven/app/components/register_page_background.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegisterController());
    return Stack(
      children: [
        RegisterPageBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: controller.registerFormKey,
                      child: Column(
                        children: [
                          CustomTextfield(
                            controller: controller.firstNameController,
                            label: "Firstname",
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.lastNameController,
                            label: "Lastname",
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.emailController,
                            label: "Email",
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.passwordController,
                            label: "Password",
                            isPassword: true,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.confirmPasswordController,
                            label: "Confirm Password",
                            isPassword: true,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.contactController,
                            label: "Contact Number",
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.locationController,
                            label: "Address",
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          CustomButton(
                            label: "Register",
                            onPressed: () {
                              controller.register();
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.offAllNamed(Routes.LOGIN);
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
