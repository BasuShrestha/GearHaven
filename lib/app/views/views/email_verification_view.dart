import 'package:flutter/material.dart';
import 'package:gearhaven/app/components/register_page_background.dart';
import 'package:gearhaven/app/modules/register/controllers/register_controller.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class EmailVerificationView extends GetView<RegisterController> {
  const EmailVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OtpTimerButtonController resnedTimer = OtpTimerButtonController();
    return Stack(
      children: [
        const RegisterPageBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: GetBuilder<RegisterController>(
            builder: (controller) => SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mark_email_read_outlined,
                      color: Colors.white,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Please enter the OTP sent to your email',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 30,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                      otpFieldStyle: OtpFieldStyle(
                        borderColor: Colors.white,
                        enabledBorderColor: Colors.white,
                        focusBorderColor: Colors.white,
                        disabledBorderColor: Colors.white,
                        errorBorderColor: Colors.red,
                      ),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.underline,
                      onCompleted: (pin) {
                        controller.verifyEnteredOTP(
                            controller.emailController.text, pin);
                      },
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 50,
                      child: Material(
                        color: CustomColors.accentColor,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        child: OtpTimerButton(
                          controller: resnedTimer,
                          backgroundColor: CustomColors.accentColor,
                          textColor: Colors.white,
                          buttonType: ButtonType.elevated_button,
                          duration: 60,
                          text: const Text('Resend OTP'),
                          onPressed: () async {
                            controller.resendUserOTP(
                              controller.emailController.text,
                              controller.firstNameController.text,
                            );
                            resnedTimer.startTimer();
                          },
                        ),
                      ),
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
