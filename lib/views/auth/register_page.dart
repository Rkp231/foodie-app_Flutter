import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/constants/strings/register.strings.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/register.viewmodel.dart';
import 'package:foodie/widgets/appbar/custom_leading_only_app_bar.dart';
import 'package:foodie/widgets/appbar/empty_appbar.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/inputs/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(context),
      builder: (context, vm, child) {
        return Scaffold(
          primary: false,
          appBar: EmptyAppBar(),
          extendBodyBehindAppBar: true,
          backgroundColor: AppColor.appBackground(context),
          body: Stack(
            children: <Widget>[
              //body
              ListView(
                children: <Widget>[
                  //page intro image
                  Hero(
                    tag: AppStrings.authImageHeroTag,
                    child: Image.asset(
                      AppImages.registerImage,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.45,
                    ),
                  ),

                  Form(
                    key: vm.formKey,
                    child: VStack(
                      [
                        //page title
                        Text(
                          RegisterStrings.title,
                          style: AppTextStyle.h1TitleTextStyle(
                            color: AppColor.textColor(context),
                          ),
                          textAlign: TextAlign.start,
                          
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //fullname textformfield
                        CustomTextFormField(
                          hintText: GeneralStrings.fullname,
                          textEditingController: vm.nameTEC,
                          errorText: vm.validateFullNameError,
                          nextFocusNode: vm.emailFocusNode,
                          textInputAction: TextInputAction.next,
                        ),
                        UiSpacer.verticalSpace(),
                        //email textformfield
                        CustomTextFormField(
                          hintText: GeneralStrings.email,
                          textEditingController: vm.emailAddressTEC,
                          focusNode: vm.emailFocusNode,
                          nextFocusNode: vm.phoneNumberFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          errorText: vm.validateEmailError,
                        ),
                        UiSpacer.verticalSpace(),
                        //phone number textformfield
                        CustomTextFormField(
                          isFixedHeight: false,
                          hintText: GeneralStrings.phone,
                          textEditingController: vm.phoneNumberTEC,
                          focusNode: vm.phoneNumberFocusNode,
                          nextFocusNode: vm.passwordFocusNode,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          errorText: vm.validatePhoneError,
                          prefixWidget: vm.phoneCode.text.xl.color(context.textTheme.bodyText1.color).semiBold
                              .make()
                              .onInkTap(vm.changeCountryCode),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //password textformfield
                        CustomTextFormField(
                          hintText: GeneralStrings.password,
                          togglePassword: true,
                          obscureText: true,
                          textEditingController: vm.passwordTEC,
                          errorText: vm.validatePasswordError,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //register button
                        CustomButton(
                          padding: AppPaddings.mediumButtonPadding(),
                          color: AppColor.accentColor,
                          loading: vm.isBusy,
                          onPressed: vm.processRegistration,
                          child: Text(
                            RegisterStrings.title,
                            style: AppTextStyle.h4TitleTextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                            
                          ),
                        ).wFull(context),
                      ],
                    ).p20(),
                  ),
                ],
              ),

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
