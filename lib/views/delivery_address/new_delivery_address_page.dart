import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/constants/strings/profile/delivery_address.strings.dart';
import 'package:foodie/constants/strings/profile/new_delivery_address.strings.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/new_delivery_address.viewmodel.dart';
import 'package:foodie/widgets/appbar/leading_app_bar.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/buttons/outline_custom_button.dart';
import 'package:foodie/widgets/inputs/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class NewDeliveryAddressPage extends StatelessWidget {
  NewDeliveryAddressPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewDeliveryAddressViewModel>.reactive(
      viewModelBuilder: () => NewDeliveryAddressViewModel(context),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColor.appBackground(context),
          appBar: AppBar(
            backgroundColor: AppColor.appBackground(context),
            brightness: MediaQuery.of(context).platformBrightness,
            elevation: 0,
            leading: LeadingAppBar(),
          ),
          body: VStack(
            [
              //header
              Text(
                NewDeliveryaAddressStrings.title,
                style: AppTextStyle.h2TitleTextStyle(
                  color: AppColor.textColor(context),
                ),
              ),
              UiSpacer.verticalSpace(space: 5),
              Text(
                NewDeliveryaAddressStrings.instruction,
                style: AppTextStyle.h5TitleTextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColor.textColor(context),
                ),
              ),
              UiSpacer.verticalSpace(space: 40),

              //form section
              CustomTextFormField(
                isFixedHeight: false,
                labelText: GeneralStrings.name,
                hintText: GeneralStrings.deliveryAddresNameHint,
                textEditingController: model.nameTEC,
                errorText: model.validationError,
              ),

              //select delivery address info
              model.selectedLocationResult == null
                  ? UiSpacer.horizontalSpace(space: 0)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        UiSpacer.verticalSpace(),
                        Text(
                          DeliveryaAddressStrings.selectedAddress,
                          style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                          ),
                        ),
                        Text(
                          model.selectedLocationResult.address,
                          style: AppTextStyle.h5TitleTextStyle(
                            color: AppColor.textColor(context),
                          ),
                        ),
                        UiSpacer.verticalSpace(),
                        //address corrdinates label
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                DeliveryaAddressStrings.latitude,
                                style: AppTextStyle.h4TitleTextStyle(
                                  color: AppColor.textColor(context),
                                ),
                              ),
                            ),
                            UiSpacer.horizontalSpace(),
                            Expanded(
                              flex: 1,
                              child: Text(
                                DeliveryaAddressStrings.longitude,
                                style: AppTextStyle.h4TitleTextStyle(
                                  color: AppColor.textColor(context),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //address corrdinates
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                model.selectedLocationResult.latLng.latitude
                                    .toString(),
                                style: AppTextStyle.h5TitleTextStyle(
                                  color: AppColor.textColor(context),
                                ),
                              ),
                            ),
                            UiSpacer.horizontalSpace(),
                            Expanded(
                              flex: 1,
                              child: Text(
                                model.selectedLocationResult.latLng.longitude
                                    .toString(),
                                style: AppTextStyle.h5TitleTextStyle(
                                  color: AppColor.textColor(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

              //Location picker button
              CustomOutlineButton(
                padding: AppPaddings.mediumButtonPadding(),
                child: Text(
                  DeliveryaAddressStrings.pickLocation,
                  style: AppTextStyle.h4TitleTextStyle(
                    color: AppColor.primaryColor,
                  ),
                ),
                onPressed: !model.isBusy
                    ? model.showDeliveryAddressLocationPicker
                    : null,
                color: AppColor.primaryColor,
              ).py16().wFull(context),
              //default
              HStack(
                [
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: context.textTheme.bodyText1.color,
                    ),
                    child: Checkbox(
                      value: model.isDefault,
                      onChanged: model.onDefaultChange,
                      activeColor: AppColor.primaryColor,
                      focusColor: context.textTheme.bodyText1.color,
                      checkColor: Colors.white,
                    ),
                  ),
                  //
                  DeliveryaAddressStrings.isDefault.text.xl
                      .color(context.textTheme.bodyText1.color)
                      .make()
                      .expand(),
                ],
              )
                  .onInkTap(
                    () => model.onDefaultChange(!model.isDefault),
                  )
                  .pOnly(bottom: Vx.dp16),
              //show info of the just picked address
              CustomButton(
                padding: AppPaddings.mediumButtonPadding(),
                color: AppColor.primaryColor,
                loading: model.isBusy,
                // disabledColor: Colors.white,
                child: Text(
                  GeneralStrings.save,
                  style: AppTextStyle.h4TitleTextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: model.saveDeliveryAddress,
              ).wFull(context),
            ],
          ).p20().scrollVertical(),
        );
      },
    );
  }
}
