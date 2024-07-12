import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/viewmodels/base_otp.viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';

class OTPVerificationViewModel extends BaseOTPViewModel {
  //
  String otp = "";
  bool canVerify = false;

  OTPVerificationViewModel(
      BuildContext context, phone, firebaseVerificationId) {
    this.viewContext = context;
    this.validatedPhoneNumber = phone;
    this.firebaseVerificationId = firebaseVerificationId;
  }

  //
  otpChanged(String pin) {
    this.otp = pin;

    if (otp.length == 6) {
      canVerify = true;
    } else {
      canVerify = false;
    }
    notifyListeners();
  }

  //
  countDownFinished() {
    canResendOTP = true;
    notifyListeners();
  }

  //
  resendOTPViaFirebase() async {
    //
    setBusyForObject(canResendOTP, true);
    //
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
        setBusyForObject(canResendOTP, false);
        signInUserViaFirebase();
      },
      //
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          validationError = "The provided phone number is not valid.";
        } else {
          validationError = e.message ?? "There was a problem sendig you OTP";
        }
        //
        setBusyForObject(canResendOTP, false);
      },
      codeSent: (String verificationId, int resendToken) {
        firebaseVerificationId = verificationId;
        resendSuccessful();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        firebaseVerificationId = verificationId;
        resendSuccessful();
      },
    );
    //
  }

  //
  resendSuccessful() {
    //
    canResendOTP = false;
    countDownController.restart();
    setBusyForObject(canResendOTP, false);

    //
    viewContext.showToast(msg: "OTP Sent Successfully");
  }

  //
  verifyOTPViaFirebase() async {
    //
    validationError = "";
    setBusy(true);

    // Sign the user in (or link) with the credential
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: firebaseVerificationId,
        smsCode: otp,
      );

      UserCredential userCredential = await auth.signInWithCredential(
        phoneAuthCredential,
      );
      //
      firebaseToken = await userCredential.user.getIdToken();
      //login via firebase token
      await signInUserViaFirebase();
    } on FirebaseAuthException catch (error) {
      // viewContext.showToast(msg: "$error", bgColor: Colors.red);
      validationError = error.message;
    } catch (error) {
      validationError = "$error";
    }
    //
    setBusy(false);
  }
}
