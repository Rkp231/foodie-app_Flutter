import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/viewmodels/otp_verification.viewmodel.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/state/busy_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:foodie/translations/auth/auth.i18n.dart';

class OTPEntryView extends StatelessWidget {
  OTPEntryView({this.phone, this.firebaseVerificationId, Key key}) : super(key: key);

  //
  final String phone;
  final String firebaseVerificationId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OTPVerificationViewModel>.reactive(
      viewModelBuilder: () => OTPVerificationViewModel(
        context,
        phone,
        firebaseVerificationId,
      ),
      builder: (context, vm, child) {
        return VStack(
          [
            //
            Image.asset(
              AppImages.otpLogin,
            )
                .wh(
                  context.percentWidth * 60,
                  context.percentWidth * 60,
                )
                .centered(),
            //
            "OTP Verification".i18n.text.semiBold.xl2.makeCentered().py12(),
            "Enter OTP Code sent to %s".i18n.fill(["$phone"]).text.makeCentered(),
            //PIN OTP
            OTPTextField(
              length: 6,
              width: context.percentWidth * 90,
              fieldWidth: (context.percentWidth * 90) / 7,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onChanged: vm.otpChanged,
              onCompleted: vm.otpChanged,
            ).centered().py12(),
            //resend
            HStack(
              [
                //
                "Didn't receive OTP code? ".i18n.text.make(),
                //count down
                vm.busy(vm.canResendOTP)
                    ? BusyIndicator()
                    : vm.canResendOTP
                        ? "Resend".i18n
                            .text
                            .color(AppColor.primaryColor)
                            .make()
                            .onInkTap(vm.resendOTPViaFirebase)
                        : Countdown(
                            seconds: 30,
                            controller: vm.countDownController,
                            build: (BuildContext context, double time) => Text(
                              " Resend in %s".i18n.fill(["${time.toInt().floor()}"]),
                              style: context.textTheme.bodyText1.copyWith(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            onFinished: vm.countDownFinished,
                          ),
              ],
            ).py12().centered(),
            //validation error
            vm.validationError.text.red500.sm.center.makeCentered().py8(),
            //submit button
            CustomButton(
              child: "Verify".i18n.text.make(),
              loading: vm.isBusy,
              color: AppColor.primaryColor,
              textColor: Colors.white,
              onPressed: vm.canVerify ? vm.verifyOTPViaFirebase : null,
            ).wFull(context),
          ],
        ).p20().scrollVertical().hThreeForth(context).pOnly(bottom: context.mq.viewInsets.bottom);
      },
    );
  }
}
