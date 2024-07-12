import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/checkout.strings.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/data/models/payment_option.dart';
import 'package:foodie/data/models/state_data_model.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/checkout.viewmodel.dart';
import 'package:foodie/views/base.page.dart';
import 'package:foodie/widgets/appbar/leading_app_bar.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/checkout/payment_option_list_view_item.dart';
import 'package:foodie/widgets/delivery_address/delivery_address_item.dart';
import 'package:foodie/widgets/empty/empty_payment_method.dart';
import 'package:foodie/widgets/empty/no_selected_delivery_address.dart';
import 'package:foodie/widgets/inputs/custom_input_form_field.dart';
import 'package:foodie/widgets/list_view_header.dart';
import 'package:foodie/widgets/shimmers/general_shimmer_list_view_item.dart';
import 'package:foodie/widgets/state/state_loading_data.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/checkout.i18n.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({
    Key key,
    this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: ViewModelBuilder<CheckOutPageViewModel>.reactive(
        viewModelBuilder: () => CheckOutPageViewModel(context, order),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: AppColor.appBackground(context),
            appBar: AppBar(
              backgroundColor: AppColor.appBackground(context),
              elevation: 0,
              brightness: MediaQuery.of(context).platformBrightness,
              leading: LeadingAppBar(),
            ),
            body: ListView(
              padding: AppPaddings.defaultPadding(),
              children: <Widget>[
                //header
                Text(
                  CheckoutStrings.title,
                  style: AppTextStyle.h1TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                  
                ),

                //delivery methods
                UiSpacer.verticalSpace(),
                MaterialSegmentedControl(
                  children: model.deliveryMethods,
                  selectionIndex: model.currentDeliveryMethodSelection,
                  borderColor: Colors.grey,
                  selectedColor: AppColor.primaryColor,
                  unselectedColor: Colors.white,
                  borderRadius: 20.0,
                  onSegmentChosen: model.updateSelectedDeliveryOption,
                ),
                //delivery addresses
                UiSpacer.verticalSpace(space: 30),

                //when user select pickup as delivery method
                model.currentDeliveryMethodSelection == 1
                    ? ListViewHeader(
                        title: CheckoutStrings.pickupDeliveryMethod,
                        subTitle: CheckoutStrings.pickupDeliveryMethodInstruction,
                        iconData: FlutterIcons.building_o_faw,
                      )
                    : Row(
                        
                        children: <Widget>[
                          Expanded(
                            child: ListViewHeader(
                              title: CheckoutStrings.deliverTo,
                              subTitle: CheckoutStrings.deliverToInstruction,
                              iconData: FlutterIcons.home_city_outline_mco,
                            ),
                          ),
                          //
                          UiSpacer.horizontalSpace(),

                          //change delivery address button
                          CustomButton(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            color: AppColor.primaryColor,
                            child: Text(
                              CheckoutStrings.changeAddress,
                              style: AppTextStyle.h5TitleTextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: model.changeDeliveryAddress,
                          ),//.w20(context).h(40),
                        ],
                      ),
                //selected delivery addresses
                UiSpacer.verticalSpace(space: 10),
                model.currentDeliveryMethodSelection == 1
                    ? UiSpacer.empty()
                    : model.busy(model.selectedDeliveryAddress)
                        ? GeneralShimmerListViewItem()
                        : model.selectedDeliveryAddress == null
                            ? NoSelectedDeliveryAddresses()
                            : Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  //
                                  VxBox(
                                    child: DeliveryAddressItem(
                                      deliveryAddress:
                                          model.selectedDeliveryAddress,
                                    ),
                                  )
                                      .color(
                                        AppColor.primaryColor.withOpacity(0.10),
                                      )
                                      .roundedSM
                                      .make(),

                                  //incase there is an error with the selected delivery address
                                  model.hasErrorForKey(
                                          model.selectedDeliveryAddress)
                                      ? UiSpacer.verticalSpace(space: 5)
                                      : UiSpacer.empty(),
                                  model.hasErrorForKey(
                                          model.selectedDeliveryAddress)
                                      ? Text(
                                          model.error(
                                              model.selectedDeliveryAddress),
                                          style: AppTextStyle.h5TitleTextStyle(
                                            color: Colors.red,
                                          ),
                                        )
                                      : UiSpacer.empty(),
                                ],
                              ),

                //note
                UiSpacer.divider(thickness: 3).py12(),
                CheckoutStrings.checkoutNote.text
                    .textStyle(AppTextStyle.h5TitleTextStyle())
                    .make()
                    .pOnly(bottom: AppPaddings.contentPaddingSize),
                CustomInputFormField(
                  labelText: "Note".i18n,
                  textEditingController: model.noteTEC,
                ),

                //payment options
                UiSpacer.divider(thickness: 3).py12(),
                ListViewHeader(
                  title: CheckoutStrings.paymentOptions,
                  subTitle: CheckoutStrings.paymentOptionsInstruction,
                  iconData: FlutterIcons.creditcard_ant,
                ),
               
                UiSpacer.verticalSpace(),
                //checking if the payment options is still loading
                model.busy(model.paymentOptions)
                    ? GeneralShimmerListViewItem()
                    //checking if there is error with the loading process
                    : model.hasErrorForKey(model.paymentOptions)
                        //show error state
                        ? LoadingStateDataView(
                            stateDataModel: StateDataModel(
                              showActionButton: true,
                              actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                                color: Colors.red,
                              ),
                              actionFunction: () => model.getPaymentOptions(),
                            ),
                          )
                        //show payment options list if there is
                        : model.hasPaymentOptions
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    UiSpacer.verticalSpace(space: 20),
                                itemBuilder: (context, index) {
                                  return PaymentOptionListViewItem(
                                    paymentOption: model.paymentOptions[index],
                                    onPressed: (PaymentOption paymentOption) {
                                      model.processCheckout(
                                        paymentOption,
                                        context,
                                      );
                                    },
                                  );
                                },
                                itemCount: model.paymentOptions.length,
                              )
                            //incase there no payment options
                            : EmptyPaymentMethod(),
              ],
            ),
          );
        },
      ),
    );
  }
}
