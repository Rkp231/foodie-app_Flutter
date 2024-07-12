import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/cart_page.vewmodel.dart';
import 'package:foodie/views/base.page.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/cart/cart_item.dart';
import 'package:foodie/widgets/cart/total_cart_price.dart';
import 'package:foodie/widgets/empty/empty_cart.dart';
import 'package:foodie/widgets/inputs/custom_input_form_field.dart';
import 'package:foodie/widgets/state/busy_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/cart.i18n.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin<CartPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BasePage(
      body: ViewModelBuilder<CartPageViewModel>.reactive(
        viewModelBuilder: () => CartPageViewModel(context),
        onModelReady: (model) => model.initialize(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: AppColor.appBackground(context),
            appBar: AppBar(
              backgroundColor: AppColor.appBackground(context),
              elevation: 0,
              title: Text(
                "My Cart".i18n,
                style: AppTextStyle.h1TitleTextStyle(
                  color: AppColor.textColor(context),
                ),
              ),
              centerTitle: false,
              automaticallyImplyLeading: false,
            ),
            body: model.currency == null ||
                    model.products == null ||
                    model.products.length == 0
                ? EmptyCart()
                : Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: AppSizes.containerTopBorderRadiusShape(),
                      color: AppColor.primaryColor.withOpacity(0.10),
                    ),
                    child: ListView(
                      padding: AppPaddings.defaultPadding(),
                      children: <Widget>[
                        //list of products in cart
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.products.length,
                          itemBuilder: (context, index) {
                            return CartItem(
                              product: model.products[index],
                              currency: model.currency,
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                        ),

                        //coupon code
                        UiSpacer.divider(),
                        UiSpacer.verticalSpace(),
                        CustomInputFormField(
                            labelText: "Coupon Code".i18n,
                            textEditingController: model.couponCodeTEC,
                            suffixWidget: Icon(
                              FlutterIcons.ticket_ent,
                              color: AppColor.primaryColor,
                            ),
                            onFieldSubmitted: model.applyCoupon,
                            isReadOnly: model.busy(model.coupon),
                            errorText: model.error(model.coupon)),

                        //coupon code
                        UiSpacer.verticalSpace(),
                        model.busy(model.coupon)
                            ? BusyIndicator()
                            : UiSpacer.empty(),
                        UiSpacer.divider(),
                        //total cart item
                        TotalCartPrice(
                          viewModel: model,
                        ),

                        //checkout button
                        UiSpacer.verticalSpace(space: 40),
                        CustomButton(
                          color: AppColor.accentColor,
                          child: Text(
                            "Check out".i18n,
                            style: AppTextStyle.h4TitleTextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: model.checkoutPressed,
                        ).wFull(context),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
