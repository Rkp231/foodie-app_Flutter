import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/data/models/dialog_data.dart';
import 'package:foodie/data/repositories/auth.repository.dart';
import 'package:foodie/services/validator.service.dart';
import 'package:foodie/viewmodels/viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/dialog.i18n.dart';

class RegisterViewModel extends ViewModel {
  //
  RegisterViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //Auth repository
  AuthRepository authRepository = new AuthRepository();
  //text editing controller
  TextEditingController nameTEC =
      new TextEditingController(text: !kReleaseMode ? "John Doe" : "");
  //add current timestamp so every test registeration generates different email addresses
  TextEditingController emailAddressTEC = new TextEditingController(
    text: !kReleaseMode
        ? "client_${DateTime.now().millisecondsSinceEpoch}@demo.com"
        : "",
  );
  TextEditingController phoneNumberTEC = new TextEditingController(
    text: !kReleaseMode ? "0557484181" : "",
  );
  TextEditingController passwordTEC = new TextEditingController(
    text: !kReleaseMode ? "password" : "",
  );

  //error texts
  String validateFullNameError = null;
  String validateEmailError = null;
  String validatePhoneError = null;
  String validatePasswordError = null;

  //
  String phoneCode = AppStrings.defaultPhoneCode;
  String countryCode = AppStrings.defaultCountryCode;

  //focus nodes
  FocusNode nameFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();
  FocusNode phoneNumberFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();

  //
  //
  changeCountryCode() {
    //
    showCountryPicker(
      context: viewContext,
      showPhoneCode: true,
      onSelect: (Country country) {
        phoneCode = "+${country.phoneCode}";
        countryCode = country.countryCode;
        notifyListeners();
      },
    );
  }

  //process login when user tap on the login button
  void processRegistration() async {
    //
    clearAllValidationError();
    //check if the user entered email & password are valid
    if (validateName() &&
        validateEmailAddress() &&
        validatePhone() &&
        validatePassword()) {
      //update ui state
      setBusy(true);
      final resultDialogData = await authRepository.register(
        name: nameTEC.text,
        email: emailAddressTEC.text,
        phone: phoneNumberTEC.text,
        phoneCountryCode: countryCode,
        password: passwordTEC.text,
      );

      //update ui state after operation
      setBusy(false);

      //checking if operation was successful before either showing an error or redirect to home page
      if (resultDialogData.dialogType == DialogType.success) {
        //remove all screen and add new page
        viewContext.navigator.pushNamedAndRemoveUntil(
          AppRoutes.homeRoute,
          (route) => false,
        );
      } else {
        //prepare the data model to be used to show the alert on the view
        final dialogData = DialogData();
        dialogData.title = resultDialogData.title;
        dialogData.body = resultDialogData.body;
        dialogData.backgroundColor = AppColor.failedColor;
        dialogData.iconData = FlutterIcons.error_mdi;
        dialogData.negativeButtonTitle = "Cancel".i18n;
        dialogData.positiveButtonTitle = "Ok".i18n;
        //notify listners tto show show alert
        showDialogAlert(dialogData: dialogData, onPositivePressed: () {});
      }
    }

    notifyListeners();
  }

  //
  clearAllValidationError() {
    validateFullNameError = null;
    validateEmailError = null;
    validatePhoneError = null;
    validatePasswordError = null;
    notifyListeners();
  }

  //as user enters name, we are doing name validation, error if its empty of less than 3 words
  bool validateName() {
    validateFullNameError = FormValidator.validateName(nameTEC.text);
    if (validateFullNameError != null ) {
      return false;
    } else {
      return true;
    }
  }

  //as user enters email, we are doing email validation
  bool validateEmailAddress() {
    validateEmailError = FormValidator.validateEmail(emailAddressTEC.text);
    if (validateEmailError != null ) {
      return false;
    } else {
      return true;
    }
  }

  //as user enters phone, we are doing phone nuber validation
  bool validatePhone() {
    validatePhoneError = FormValidator.validatePhone(phoneNumberTEC.text);
    if (validatePhoneError != null ) {
      return false;
    } else {
      return true;
    }
  }

  //as user enters password, we are doing password validation
  bool validatePassword() {
    validatePasswordError = FormValidator.validatePassword(passwordTEC.text);
    if (validatePasswordError != null ) {
      return false;
    } else {
      return true;
    }
  }
}
