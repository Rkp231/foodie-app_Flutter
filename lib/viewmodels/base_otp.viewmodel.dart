import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/data/repositories/auth.repository.dart';
import 'package:foodie/viewmodels/viewmodel.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class BaseOTPViewModel extends ViewModel {
  //
  String validatedPhoneNumber = "";
  String validationError = "";
  AuthRepository authRepository = AuthRepository();
  String firebaseToken = "";
  String firebaseVerificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  bool canResendOTP = true;
  CountdownController countDownController = CountdownController();

  //
  signInUserViaFirebase() async {
    setBusy(true);
    final apiResponse = await authRepository.otpLogin(
      token: firebaseToken,
      phone: validatedPhoneNumber,
    );

    //phone number & otp is valid
    if (apiResponse.allGood) {
      //
      viewContext.navigator.pushNamedAndRemoveUntil(AppRoutes.homeRoute, (route) => false);
    } else {
      validationError = apiResponse.message;
    }
      setBusy(false);
  }
}
