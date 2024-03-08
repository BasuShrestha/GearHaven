import 'package:gearhaven/app/components/customs/custom_textfield.dart';
import 'package:gearhaven/app/components/login_page_background.dart';
import 'package:gearhaven/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import 'package:get/get.dart';

class ForgotPasswordView extends GetView {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    return Stack(
      children: [
        const LoginPageBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextfield(
                      label: "Email",
                      controller: TextEditingController(),
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: List.generate(
                    //     5,
                    //     (index) => Container(
                    //       width: 50,
                    //       child: TextFormField(
                    //         controller: controller.otpNumberController,
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(fontSize: 20, color: Colors.white),
                    //         decoration: InputDecoration(
                    //           focusedBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(color: Colors.white),
                    //           ),
                    //           border: UnderlineInputBorder(
                    //             borderSide: BorderSide(color: Colors.white),
                    //           ),
                    //           enabledBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(color: Colors.white),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Theme(
                      data: ThemeData(
                        inputDecorationTheme: InputDecorationTheme(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: OTPTextField(
                          controller: controller.otpFieldController,
                          length: 5,
                          width: 200,
                          contentPadding: EdgeInsets.all(10),
                          fieldWidth: 50,
                          otpFieldStyle: OtpFieldStyle(
                            backgroundColor: Colors.transparent,
                            borderColor: Colors.transparent,
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textFieldAlignment: MainAxisAlignment.spaceBetween,
                          fieldStyle: FieldStyle.underline,
                          onCompleted: (pin) {
                            debugPrint(pin);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint(controller.otpNumberController.toString());
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
