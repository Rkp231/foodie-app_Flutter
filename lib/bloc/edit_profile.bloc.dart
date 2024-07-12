import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:foodie/bloc/base.bloc.dart';
import 'package:foodie/constants/validation_messages.dart';
import 'package:foodie/data/repositories/auth.repository.dart';
import 'package:foodie/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileBloc extends BaseBloc {
  //auth repository
  AuthRepository _authRepository = AuthRepository();

  //text editing controller
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController emailAddressTEC = new TextEditingController();
  TextEditingController phoneNumberTEC = new TextEditingController();

  //view entered data
  BehaviorSubject<dynamic> _profilePhoto = BehaviorSubject<dynamic>();
  BehaviorSubject<bool> _nameValid = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> _emailValid = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> _phoneNumberValid = BehaviorSubject<bool>.seeded(true);

  //entered data variables getter
  Stream<dynamic> get profilePhoto => _profilePhoto.stream;
  Stream<bool> get validName => _nameValid.stream;
  Stream<bool> get validEmailAddress => _emailValid.stream;
  Stream<bool> get validPhoneNumber => _phoneNumberValid.stream;

  @override
  void initBloc() async {
    super.initBloc();
    final currentUser = await appDatabase.userDao.findCurrent();
    nameTEC.text = currentUser.name;
    emailAddressTEC.text = currentUser.email;
    phoneNumberTEC.text = currentUser.phone;
    _profilePhoto.add(currentUser.photo);
  }

  //pick new profile
  void pickNewProfilePhoto() async {
    try {
      //
      FilePickerResult result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File image = File(result.files.single.path);
        _profilePhoto.add(image);
      }
    } catch (error) {
      print("Error picking profile photo");
      _profilePhoto.addError(error);
    }
  }

  //as user enters name, we are doing name validation, error if its empty of less than 3 words
  bool validateName(String value) {
    if (value.isEmpty || value.length < 3) {
      _nameValid.addError(ValidationMessages.invalidName);
      return false;
    } else {
      _nameValid.add(true);
      return true;
    }
  }

  //as user enters email, we are doing email validation
  bool validateEmailAddress(String value) {
    if (!Validators.isEmailValid(value)) {
      _emailValid.addError(ValidationMessages.invalidEmail);
      return false;
    } else {
      _emailValid.add(true);
      return true;
    }
  }

  //as user enters email, we are doing email validation
  bool validatePhoneNumber(String value) {
    if (!Validators.isPhoneNumberValid(value)) {
      _phoneNumberValid.addError(ValidationMessages.invalidPhoneNumber);
      return false;
    } else {
      _phoneNumberValid.add(true);
      return true;
    }
  }

  //process login when user tap on the login button
  void processAccountUpdate() async {
    //get the entered value from the text editing controller
    final name = nameTEC.text;
    final email = emailAddressTEC.text;
    final phone = phoneNumberTEC.text;

    //check if the user entered name & email are valid
    if (validateName(name) &&
        validateEmailAddress(email) &&
        validatePhoneNumber(phone)) {
      //update ui state
      setUiState(UiState.loading);

      //make the request to the server
      final profilePhotoValue = _profilePhoto.value;
      final resultDialogData = await _authRepository.updateProfile(
        name: name,
        email: email,
        phone: phone,
        photo: profilePhotoValue is File ? profilePhotoValue : null,
      );

      //update ui state after operation
      setUiState(UiState.done);

      //prepare the data model to be used to show the alert on the view
      dialogData = resultDialogData;
      dialogData.isDismissible = true;
      //notify listners tto show show alert
      setShowDialogAlert(true);
    }
  }
}
