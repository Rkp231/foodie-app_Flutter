import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/data/database/app_database_singleton.dart';
import 'package:foodie/data/models/dialog_data.dart';
import 'package:foodie/data/repositories/categories.repository.dart';
import 'package:foodie/data/repositories/vendor.repository.dart';
import 'package:foodie/utils/custom_dialog.dart';
import 'package:stacked/stacked.dart';

class ViewModel extends BaseViewModel {
  BuildContext viewContext;
  final formKey = GlobalKey<FormState>();

  //repositories
  CategoryRepository categoryRepository = CategoryRepository();
  VendorRepository vendorRepository = VendorRepository();
  final appDatabase = AppDatabaseSingleton.database;

  //
  void initialise(){}
  
  //
  void showAlert({
    String title = "",
    String description = "",
    IconData iconData,
    Color backgroundColor,
  }) {
    EdgeAlert.show(
      viewContext,
      title: title,
      description: description,
      backgroundColor: backgroundColor ?? AppColor.successfulColor,
      icon: iconData ?? FlutterIcons.check_ant,
    );
  }

  void showErrorAlert({
    String title = "",
    String description = "",
    IconData iconData,
    Color backgroundColor,
  }) {
    EdgeAlert.show(
      viewContext,
      title: title,
      description: description,
      backgroundColor: backgroundColor ?? AppColor.failedColor,
      icon: iconData ?? FlutterIcons.error_mdi,
    );
  }

  //
  void showDialogAlert({
    DialogData dialogData,
    Function onPositivePressed,
  }) {
    CustomDialog.showConfirmationActionAlertDialog(
      viewContext,
      dialogData,
      negativeButtonAction: () {
        //dismiss dialog
        CustomDialog.dismissDialog(
          viewContext,
        );
      },
      positiveButtonAction: () {
        //dismiss dialog
        CustomDialog.dismissDialog(
          viewContext,
        );

        //
        onPositivePressed();
      },
    );
  }
}
