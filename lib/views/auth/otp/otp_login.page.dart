import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/constants/strings/login.strings.dart';
import 'package:foodie/viewmodels/otp_login.viewmodel.dart';
import 'package:foodie/views/base.page.dart';
import 'package:foodie/widgets/appbar/custom_leading_only_app_bar.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/inputs/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/auth/auth.i18n.dart';

class OTPLoginpage extends StatelessWidget {
  const OTPLoginpage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OTPLoginViewModel>.reactive(
      viewModelBuilder: () => OTPLoginViewModel(context),
      builder: (context, vm, child) {
        return BasePage(
          body: Stack(
            children: [
              VStack(
                [
                  Image.asset(
                    AppImages.otpLogin,
                  )
                      .wh(
                        context.percentWidth * 70,
                        context.percentWidth * 70,
                      )
                      .centered(),
                  //
                  "You will receive a 6 digit code to verify next".i18n
                      .text
                      .center
                      .medium
                      .color(context.textTheme.bodyText1.color)
                      .makeCentered()
                      .py20(),

                  CustomTextFormField(
                    //
                    isFixedHeight: false,
                    borderRadius: 30,
                    fillColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    textEditingController: vm.phoneTEC,
                    textStyle: context.textTheme.headline6.copyWith(color: Colors.black, fontSize: 17),
                    keyboardType: TextInputType.phone,
                    hintText: "Mobile number".i18n,
                    prefixWidget: vm.phoneCode.text.xl.semiBold
                        .make()
                        .onInkTap(vm.changeCountryCode),
                    suffixWidget: CustomButton(
                      color: AppColor.primaryColor,
                      textColor: Colors.white,
                      loading: vm.isBusy,
                      child: "Countinue".i18n.text.make(),
                      onPressed: vm.initiateOTP,
                    ),
                  ).box.roundedLg.shadow.make(),
                  //validation error
                  vm.validationError.text.red500.sm.center.makeCentered().py8(),

                  "OR".i18n.text.center.semiBold.xl.color(context.textTheme.bodyText1.color).makeCentered().py20(),
                  //login
                  LoginStrings.emailLogin.text.center.medium.lg.color(context.textTheme.bodyText1.color)
                      .makeCentered()
                      .onInkTap(vm.openLoginPage),

                  //sign up
                  LoginStrings.signup.text.center.medium.lg.color(context.textTheme.bodyText1.color)
                      .makeCentered()
                      .onInkTap(vm.openRegisterPage)
                      .py12(),
                ],
              ).centered().p20().hFull(context).scrollVertical(),

              //appbar
              CustomLeadingOnlyAppBar(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
