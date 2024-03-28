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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your first name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.lastNameController,
                            label: "Lastname",
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your last name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.emailController,
                            label: "Email",
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = RegExp(pattern as String);
                              if (!regex.hasMatch(value ?? '')) {
                                return 'Please enter a valid email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.passwordController,
                            label: "Password",
                            isPassword: true,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a password";
                              }
                              if (value.length < 8) {
                                return "The password must be at least 8 characters long";
                              }
                              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return "The password must contain at least one uppercase letter";
                              }
                              if (!RegExp(r'[a-z]').hasMatch(value)) {
                                return "The password must contain at least one lowercase letter";
                              }
                              if (!RegExp(r'\d').hasMatch(value)) {
                                return "The password must contain at least one number";
                              }
                              if (!RegExp(r'[^A-Za-z0-9]').hasMatch(value)) {
                                return "The password must contain at least one special character";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.confirmPasswordController,
                            label: "Confirm Password",
                            isPassword: true,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value != controller.passwordController.text) {
                                return "The passwords do not match";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.contactController,
                            label: "Contact Number",
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a contact number";
                              }
                              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return "Please enter a valid contact number";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                            controller: controller.locationController,
                            label: "Address",
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your current address";
                              }
                              return null;
                            },
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
