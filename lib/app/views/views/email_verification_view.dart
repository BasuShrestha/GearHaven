import 'package:flutter/material.dart';
import 'package:gearhaven/app/modules/register/controllers/register_controller.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart'; // Make sure to adjust this import based on your file structure

class EmailVerificationView extends GetView<RegisterController> {
  const EmailVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please enter the OTP sent to your email',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 40,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                controller.verifyEnteredOTP(
                    controller.emailController.text, pin);
              },
            ),
            const SizedBox(height: 20),
            OtpTimerButton(
              controller: OtpTimerButtonController(),
              duration: 30,
              text: Text('Resend OTP'),
              onPressed: () {
                controller.resendUserOTP(
                  controller.emailController.text,
                  controller.firstNameController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
