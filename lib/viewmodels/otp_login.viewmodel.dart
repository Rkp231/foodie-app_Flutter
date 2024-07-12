import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/viewmodels/base_otp.viewmodel.dart';
import 'package:country_picker/country_picker.dart';
import 'package:foodie/views/auth/otp/widgets/otp_entry.view.dart';
import 'package:form_validator/form_validator.dart';
import 'package:velocity_x/velocity_x.dart';

class OTPLoginViewModel extends BaseOTPViewModel {
  //
  String phoneCode = AppStrings.defaultPhoneCode;
  String countryCode = AppStrings.defaultCountryCode;
  String validationError = "";
  TextEditingController phoneTEC = TextEditingController();

  OTPLoginViewModel(BuildContext context) {
    this.viewContext = context;
  }

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
        print('Select country: ${country.displayName}');
      },
    );
  }

  void openLoginPage() {
    viewContext.navigator.pushNamed(AppRoutes.loginRoute);
  }

  void openRegisterPage() {
    viewContext.navigator.pushNamed(AppRoutes.registerRoute);
  }

  ////
  initiateOTP() async {
    final validate = ValidationBuilder().phone().build();
    validationError = validate(phoneTEC.text) ?? "";
    notifyListeners();

    if (validationError.isEmptyOrNull) {
      //
      setBusy(true);
      final apiResponse = await authRepository.verifyPhoneNumber(
        code: countryCode,
        phone: phoneTEC.text,
      );

      //phone number is valid
      if (apiResponse.allGood) {
        //set the validate phone from server
        validatedPhoneNumber = apiResponse.body.toString();
        //send otp then show entry
        await sendOTPViaFirebase();
        setBusy(false);
      } else {
        validationError = apiResponse.message;
        setBusy(false);
      }
    }
  }

  //
  sendOTPViaFirebase() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: validatedPhoneNumber,
      //
      verificationCompleted: (PhoneAuthCredential credential) async {
        //
        UserCredential userCredential = await auth.signInWithCredential(
          credential,
        );

        //fetch user id token
        firebaseToken = await userCredential.user.getIdToken();
        firebaseVerificationId = credential.verificationId;

        //
        await signInUserViaFirebase();
      },
      //
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          validationError = "The provided phone number is not valid.";
        } else {
          validationError = e.message ?? "There was a problem sendig you OTP";
        }
        notifyListeners();
      },
      codeSent: (String verificationId, int resendToken) {
        firebaseVerificationId = verificationId;
        showOTPEntryView();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // firebaseVerificationId = verificationId;
        // showOTPEntryView();
      },
    );
    //
  }

  //
  showOTPEntryView() {
    showModalBottomSheet(
      context: viewContext,
      // isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) {
        return OTPEntryView(
          phone: validatedPhoneNumber,
          firebaseVerificationId: firebaseVerificationId,
        );
      },
    );
  }
}
