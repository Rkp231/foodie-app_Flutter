import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/strings/profile/new_delivery_address.strings.dart';
import 'package:foodie/data/models/dialog_data.dart';
import 'package:foodie/data/repositories/delivery_address.repository.dart';
import 'package:foodie/viewmodels/viewmodel.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class NewDeliveryAddressViewModel extends ViewModel {
  //
  NewDeliveryAddressViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  //delivery address repository
  DeliveryAddressRepository deliveryAddressRepository =
      DeliveryAddressRepository();

  //
  TextEditingController nameTEC = new TextEditingController();
  LocationResult selectedLocationResult;
  bool isDefault = false;
  String validationError = null;

  //
  onDefaultChange(bool value) {
    isDefault = value;
    notifyListeners();
  }

  //
  void showDeliveryAddressLocationPicker() async {
    selectedLocationResult = await showLocationPicker(
      viewContext,
      AppStrings.googleApiKey,
      automaticallyAnimateToCurrentLocation: true,
      myLocationButtonEnabled: true,
      layersButtonEnabled: true,
      // resultCardAlignment: Alignment.bottomCenter,
    );
    notifyListeners();
  }

  //
  bool validateDeliveryAddressName() {
    validationError = null;
    if (nameTEC.text.isNotBlank) {
      return true;
    }

    //
    validationError = NewDeliveryaAddressStrings.instruction;
    return false;
  }

  bool validateSelectedLocation() {
    if (selectedLocationResult != null) {
      return true;
    }

    //
    showErrorAlert(
      title: NewDeliveryaAddressStrings.title,
      description: NewDeliveryaAddressStrings.instruction,
    );
    return false;
  }

  //saving the delivery address
  void saveDeliveryAddress() async {
    if (validateDeliveryAddressName() && validateSelectedLocation()) {
      //
      setBusy(true);
      final dialogData = await deliveryAddressRepository.saveDeliveryAddress(
        name: nameTEC.text,
        isDefault: isDefault,
        address: selectedLocationResult.address,
        latitude: selectedLocationResult.latLng.latitude,
        longitude: selectedLocationResult.latLng.longitude,
      );

      //notify the view of the current state
      setBusy(false);
      if (dialogData.dialogType == DialogType.successThenClosePage) {
        showAlert(
          title: dialogData.title,
          description: dialogData.body,
        );
        //close page
        viewContext.pop();
      } else {
        showErrorAlert(
          title: dialogData.title,
          description: dialogData.body,
        );
      }
    } else {
      notifyListeners();
    }
  }
}
