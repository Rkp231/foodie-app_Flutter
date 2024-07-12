import 'package:flutter/material.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/data/models/state_data_model.dart';
import 'package:foodie/viewmodels/main_home.viewmodel.dart';
import 'package:foodie/widgets/state/state_loading_data.dart';
import 'package:foodie/translations/general.i18n.dart';
import 'package:velocity_x/velocity_x.dart';

class NoLocationPermission extends StatelessWidget {
  const NoLocationPermission({this.model, Key key}) : super(key: key);

  final MainHomeViewModel model;
  @override
  Widget build(BuildContext context) {
    return LoadingStateDataView(
      stateDataModel: StateDataModel(
        title: GeneralStrings.noLocationPermissionTitle,
        titleStyle: context.textTheme.bodyText1,
        description: GeneralStrings.noLocationPermissionDescription,
        descriptionStyle: context.textTheme.bodyText2,
        showActionButton: true,
        imageAssetPath: AppImages.ic_location,
        actionButtonStyle: AppTextStyle.h4TitleTextStyle(
          color: Colors.red,
        ),
        actionButtonTitle: "Enable Location".i18n,
        actionFunction: model.requestLocationPermission,
      ),
    );
  }
}
