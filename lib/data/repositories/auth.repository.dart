import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/constants/api.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/strings/forgot_password.strings.dart';
import 'package:foodie/constants/strings/login.strings.dart';
import 'package:foodie/constants/strings/register.strings.dart';
import 'package:foodie/constants/strings/update_password.strings.dart';
import 'package:foodie/constants/strings/update_profile.strings.dart';
import 'package:foodie/data/models/api_response.dart';
import 'package:foodie/data/models/dialog_data.dart';
import 'package:foodie/data/models/user.dart';
import 'package:foodie/services/http.service.dart';
import 'package:foodie/utils/api_response.utils.dart';

class AuthRepository extends HttpService {
  //FirebaseMessaging instance
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //process user account login
  Future<DialogData> login({String email, String password}) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.login,
      {
        "email": email,
        "password": password,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = LoginStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      //save the user data to hive box
      saveuserData(
        apiResponse.body["user"],
        apiResponse.body["token"],
        apiResponse.body["type"],
      );
    } else {
      resultDialogData.title = LoginStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  Future<DialogData> register({
    String name,
    String email,
    String phone,
    String phoneCountryCode,
    String password,
    bool social = false,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.register,
      {
        "name": name,
        "email": email,
        "phone": phone,
        "phone_country": phoneCountryCode,
        "password": password,
        "social": social ? "1" : "0"
      },
    );

    // print("Api Result ==> $apiResult");
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = RegisterStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      //save the user data to hive box
      saveuserData(
        apiResponse.body["user"],
        apiResponse.body["token"],
        apiResponse.body["type"],
      );
    } else {
      resultDialogData.title = RegisterStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  Future<DialogData> loginSocial({
    String name,
    String email,
    String phone,
    String password,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.loginSocial,
      {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      },
    );

    // print("Api Result ==> $apiResult");
    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = RegisterStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;

      //save the user data to hive box
      saveuserData(
        apiResponse.body["user"],
        apiResponse.body["token"],
        apiResponse.body["type"],
      );
    } else {
      resultDialogData.title = RegisterStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  //reset password
  Future<DialogData> resetPassword({
    @required String email,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.forgotPassword,
      {
        "email": email,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = ForgotPasswordStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.success;
    } else {
      resultDialogData.title = ForgotPasswordStrings.processFailedTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  //update account profile
  Future<DialogData> updateProfile({
    String name,
    String email,
    String phone,
    File photo,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();

    final Map<String, dynamic> bodyPayload = {
      "name": name,
      "email": email,
      "phone": phone,
    };

    //adding photo file to the payload if photo was selected
    if (photo != null) {
      final photoFile = await MultipartFile.fromFile(
        photo.path,
      );

      bodyPayload.addAll({
        "photo": photoFile,
      });
    }

    final apiResult = await postWithFiles(
      Api.updateProfile,
      bodyPayload,
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if (apiResponse.allGood) {
      resultDialogData.title = UpdateProfileStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.successThenClosePage;

      //get the local version of user data
      final currentUser = await appDatabase.userDao.findCurrent();
      //change the data/info
      currentUser.name = apiResponse.body["user"]["name"];
      currentUser.email = apiResponse.body["user"]["email"];
      currentUser.phone = apiResponse.body["user"]["phone"];
      currentUser.photo = apiResponse.body["user"]["photo"];
      //update the local version of user data
      await appDatabase.userDao.updateItem(currentUser);
    } else {
      //the error message
      var errorMessage = apiResponse.message;

      try {
        errorMessage += "\n" + apiResponse.body["errors"]["name"][0];
      } catch (error) {
        print("Name Validation ===> $error");
      }
      try {
        errorMessage += "\n" + apiResponse.body["errors"]["email"][0];
      } catch (error) {
        print("Email Validation ===> $error");
      }

      resultDialogData.title = UpdateProfileStrings.processFailedTitle;
      resultDialogData.body = errorMessage ?? apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }
    return resultDialogData;
  }

  //update user password
  Future<DialogData> updatePassword({
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  }) async {
    //instance of the model to be returned
    final resultDialogData = DialogData();
    final apiResult = await post(
      Api.changePassword,
      {
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": confirmNewPassword,
      },
    );

    ApiResponse apiResponse = ApiResponseUtils.parseApiResponse(apiResult);

    if (apiResponse.allGood) {
      resultDialogData.title = UpdatePasswordStrings.processCompleteTitle;
      resultDialogData.body = apiResponse.message;
      resultDialogData.dialogType = DialogType.successThenClosePage;
    } else {
      //the error message
      var errorMessage = apiResponse.message;

      try {
        errorMessage +=
            "\n" + apiResponse.body["errors"]["current_password"][0];
      } catch (error) {
        print("Current Password ===> $error");
      }
      try {
        errorMessage += "\n" + apiResponse.body["errors"]["new_password"][0];
      } catch (error) {
        print("New Password ===> $error");
      }

      try {
        errorMessage +=
            "\n" + apiResponse.body["errors"]["new_password_confirmation"][0];
      } catch (error) {
        print("New Password Confirmation ===> $error");
      }

      resultDialogData.title = UpdatePasswordStrings.processFailedTitle;
      resultDialogData.body = errorMessage ?? apiResponse.message;
      resultDialogData.dialogType = DialogType.failed;
    }

    return resultDialogData;
  }

  //save user data
  void saveuserData(dynamic userObject, String token, String tokenType) async {
    //this is variable is inherited from HttpService
    final mUser = User.formJson(userJSONObject: userObject);
    mUser.token = token;
    mUser.tokenType = tokenType;
    await appDatabase.userDao.deleteAll();
    await appDatabase.userDao.insertItem(mUser);

    //save to tellam

    //
    _firebaseMessaging.subscribeToTopic("all");
    _firebaseMessaging.subscribeToTopic(mUser.role);
    _firebaseMessaging.subscribeToTopic(mUser.id.toString());

    //save to shared pref
    AuthBloc.prefs.setBool(AppStrings.authenticated, true);
  }

  //logout
  Future<void> logout() async {
    //get current user data
    final currentUser = await appDatabase.userDao.findCurrent();
    //delete current user data from local storage
    await appDatabase.userDao.deleteAll();

    _firebaseMessaging.unsubscribeFromTopic("all");
    try {
      _firebaseMessaging.unsubscribeFromTopic(currentUser.role);
      _firebaseMessaging.unsubscribeFromTopic(currentUser.id.toString());
    } catch (error) {
      print("Error Unsubscribing user");
    }

    //save to shared pref
    AuthBloc.prefs.setBool(AppStrings.authenticated, false);
  }

  //OTP Related functions
  Future<ApiResponse> verifyPhoneNumber({
    String code,
    String phone,
  }) async {
    final apiResult = await post(
      Api.phoneValidation,
      {
        "code": code,
        "phone": phone,
      },
    );

    //
    return ApiResponseUtils.parseApiResponse(apiResult);
  }

  Future<ApiResponse> otpLogin({
    String token,
    String phone,
  }) async {
    final apiResult = await post(
      Api.otpLogin,
      {
        "token": token,
        "phone": phone,
      },
    );

    //
    final apiResponse = ApiResponseUtils.parseApiResponse(apiResult);
    if( apiResponse.allGood ){
      saveuserData(
        apiResponse.body["user"],
        apiResponse.body["token"],
        apiResponse.body["type"],
      );
    }
    return apiResponse;
  }
}
