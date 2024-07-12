// ViewModel
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/data/models/category.dart';
import 'package:foodie/data/models/category_banner.dart';
import 'package:foodie/data/models/deliver_address.dart';
import 'package:foodie/data/models/loading_state.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/data/repositories/vendor.repository.dart';
import 'package:foodie/utils/custom_dialog.dart';
import 'package:foodie/viewmodels/base.viewmodel.dart';
import 'package:foodie/widgets/deliver_to_bottom_sheet_content.dart';
import 'package:location/location.dart';

class MainHomeViewModel extends MyBaseViewModel {
  //
  LoadingState categoriesLoadingState = LoadingState.Loading;
  LoadingState nearbyLoadingState = LoadingState.Loading;
  LoadingState popularsLoadingState = LoadingState.Loading;
  int listingStyle = 1;

  List<Category> categories = [];
  List<Vendor> nearbyVendors = [];
  List<Vendor> popularVendors = [];
  DeliveryAddress selectedDeliveryAddress;
  //
  bool isLocationAvailable = false;
  Location location = new Location();
  LocationData currentLocationData;

  MainHomeViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void initialise() {
    //
    getCategories();
    //
    getPopularVendors();
    //
    getLocationPermissionStatus();
  }

  //get location permission status
  void getLocationPermissionStatus() async {
    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      isLocationAvailable = true;
      getNearbyVendors();
    }
  }

  //request location permission
  void requestLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        isLocationAvailable = true;
        getNearbyVendors();
      }
    } else {
      isLocationAvailable = true;
      notifyListeners();
    }
  }

  //getting all nearby
  void getNearbyVendors() async {
    //get current location
    currentLocationData = await location.getLocation();

    //
    setBusyForObject(nearbyVendors, true);

    try {
      nearbyVendors = await vendorRepository.getVendors(
        type: VendorListType.nearBy,
        location: currentLocationData,
      );
      clearErrors();
    } catch (error) {
      setErrorForObject(nearbyVendors, error);
    }

    setBusyForObject(nearbyVendors, false);
  }

  //getting all popular
  void getPopularVendors() async {
    //add null data so listener can show shimmer widget to indicate loading
    popularsLoadingState = LoadingState.Loading;
    notifyListeners();

    try {
      popularVendors = await vendorRepository.getVendors(
        type: VendorListType.popular,
      );
      popularsLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      popularsLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  //get all categories
  void getCategories() async {
    //add null data so listener can show shimmer widget to indicate loading
    categoriesLoadingState = LoadingState.Loading;
    notifyListeners();

    try {
      categories = await categoryRepository.getCategories();
      categoriesLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      categoriesLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  //
  void changeDeliveryAddress() {
    //show bottomsheet with delivery addresses container
    CustomDialog.showCustomBottomSheet(
      viewContext,
      contentPadding: EdgeInsets.all(20),
      content: DeliverTo(
        onSubmit: (DeliveryAddress deliveryAddres) {
          //update the selected model
          this.selectedDeliveryAddress = deliveryAddres;
          notifyListeners();
        },
      ),
    );
  }

  //
  void openSearchPage() {
    //navigate to search vendors page
    Navigator.pushNamed(
      viewContext,
      AppRoutes.searchVendorsPage,
    );
  }

  //
  void openCategorySearchPage(dynamic data) {
    //
    var category;
    if (data is CategoryBanner) {
      category = data.category;
    } else {
      category = data;
    }

    //navigate to search vendors page
    Navigator.pushNamed(
      viewContext,
      AppRoutes.categoryVendorsRoute,
      arguments: category,
    );
  }

  void changeListingStyle(int style) {
    listingStyle = style;
    notifyListeners();
  }
}
