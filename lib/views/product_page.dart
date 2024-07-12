import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/constants/strings/product.strings.dart';
import 'package:foodie/data/models/product.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/product_page.viewmodel.dart';
import 'package:foodie/views/base.page.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/buttons/floating_cart_button.dart';
import 'package:foodie/widgets/buttons/outline_custom_button.dart';
import 'package:readmore/readmore.dart';
import 'package:stacked/stacked.dart';

class ProductPage extends StatefulWidget {
  ProductPage({
    Key key,
    this.product,
    this.vendor,
  }) : super(key: key);

  final Product product;
  final Vendor vendor;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: ViewModelBuilder<ProductPageViewModel>.reactive(
        viewModelBuilder: () => ProductPageViewModel(
          context,
          widget.vendor,
          widget.product,
        ),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: AppColor.appBackground(context),
            appBar: AppBar(
              title: Text(
                model.product.name,
              ),
              elevation: 0,
            ),
            body: Stack(
              children: <Widget>[
                //product details and options
                Positioned(
                  child: ListView(
                    padding: EdgeInsets.only(
                      bottom: 300,
                    ),
                    children: <Widget>[
                      //product featured image
                      Hero(
                        tag: model.product.id,
                        child: CachedNetworkImage(
                          imageUrl: model.product.photoUrl,
                          placeholder: (context, url) => Container(
                            height: AppSizes.vendorImageHeight,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                          ),
                          height: AppSizes.vendorImageHeight,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      //product name and price
                      Container(
                        padding: AppPaddings.defaultPadding(),
                        decoration: BoxDecoration(
                          color: AppColor.appBackground(context),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(0, 1.0),
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                widget.product.name,
                                style: AppTextStyle.h2TitleTextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textColor(context),
                                ),
                              ),
                            ),
                            UiSpacer.horizontalSpace(space: 20),
                            model.product.hasDiscount
                                ? Text(
                                    "${widget.vendor.currency.symbol} ${widget.product.price}",
                                    style: AppTextStyle.h2TitleTextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textColor(context),
                                      decoration: model.product.hasDiscount
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  )
                                : Text(
                                    "${widget.vendor.currency.symbol} ${widget.product.price}",
                                    style: AppTextStyle.h1TitleTextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.amountTextColor(context),
                                      decoration: model.product.hasDiscount
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                            model.product.hasDiscount
                                ? UiSpacer.horizontalSpace(space: 10)
                                : UiSpacer.empty(),
                            model.product.hasDiscount
                                ? Text(
                                    "${model.vendor.currency.symbol} ${model.product.discountPrice}",
                                    style: AppTextStyle.h1TitleTextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.amountTextColor(context),
                                    ),
                                  )
                                : UiSpacer.horizontalSpace(),
                          ],
                        ),
                      ),

                      //product description
                      Container(
                        padding: AppPaddings.defaultPadding(),
                        color: AppColor.appBackground(context),
                        child: ReadMoreText(
                          widget.product.description,
                          trimLines: 4,
                          colorClickableText: AppColor.primaryColor,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: GeneralStrings.showMore,
                          trimExpandedText: GeneralStrings.showLess,
                          style: AppTextStyle.h5TitleTextStyle(
                            color: AppColor.textColor(context),
                          ),
                        ),
                      ),

                      Divider(),

                      //product extras
                      Padding(
                        padding: AppPaddings.defaultPadding(),
                        child: Text(
                          ProductStrings.extras,
                          style: AppTextStyle.h3TitleTextStyle(
                            color: AppColor.textColor(context),
                          ),
                        ),
                      ),
                      //list of the extras
                      ...model.buildProductExtrasWidgetList(),
                    ],
                  ),
                ),

                //add to cart section
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: AppPaddings.defaultPadding(),
                    decoration: BoxDecoration(
                      borderRadius: AppSizes.containerTopBorderRadiusShape(),
                      color: AppColor.listItemBackground(context),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                ProductStrings.quantity,
                                style: AppTextStyle.h4TitleTextStyle(
                                  color: AppColor.textColor(context),
                                ),
                              ),
                              Spacer(
                                flex: 6,
                              ),
                              //decrease product quantity button
                              ButtonTheme(
                                minWidth: 40,
                                height: 30,
                                child: CustomOutlineButton(
                                  padding: EdgeInsets.all(5),
                                  color: AppColor.accentColor,
                                  child: Icon(
                                    FlutterIcons.minus_ant,
                                    size: 16,
                                    color: AppColor.textColor(context),
                                  ),
                                  onPressed: model.quantity == 1
                                      ? null
                                      : model.decreaseFoodQuantity,
                                ),
                              ),
                              //selected product quantity text
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${model.quantity}",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.h3TitleTextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.textColor(context),
                                  ),
                                ),
                              ),
                              //increase food quantity button
                              ButtonTheme(
                                minWidth: 40,
                                height: 30,
                                child: CustomOutlineButton(
                                  padding: EdgeInsets.all(5),
                                  color: AppColor.accentColor,
                                  child: Icon(
                                    FlutterIcons.plus_ant,
                                    size: 16,
                                    color: AppColor.textColor(context),
                                  ),
                                  onPressed: model.increaseFoodQuantity,
                                ),
                              ),
                            ],
                          ),

                          UiSpacer.verticalSpace(),

                          //add to cart buttonn
                          CustomButton(
                            color: AppColor.accentColor,
                            padding: AppPaddings.mediumButtonPadding(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  ProductStrings.addToCart,
                                  style: AppTextStyle.h4TitleTextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                UiSpacer.horizontalSpace(),
                                Text(
                                  "${model.vendor.currency.symbol} ${model.totalAmount}",
                                  style: AppTextStyle.h3TitleTextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: model.addToCart,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // floating cart button
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  right: AuthBloc.prefs.getString(AppStrings.localeKey) != "ar"
                      ? AppPaddings.contentPaddingSize
                      : null,
                  left: AuthBloc.prefs.getString(AppStrings.localeKey) == "ar"
                      ? AppPaddings.contentPaddingSize
                      : null,
                  child: FloatingCartButton(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
