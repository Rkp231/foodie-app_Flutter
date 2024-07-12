import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/cart.strings.dart';
import 'package:foodie/constants/strings/vendor.strings.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/widgets/buttons/delivery_time_button.dart';
import 'package:foodie/translations/home/home.i18n.dart';

class VendorPageHeader extends StatelessWidget {
  const VendorPageHeader({
    Key key,
    @required this.vendor,
  }) : super(key: key);

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: new SliverChildListDelegate(
        [
          Stack(
            children: <Widget>[
              //vendor feature image
              Hero(
                tag: vendor.slug,
                child: CachedNetworkImage(
                  imageUrl: vendor.featureImage,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: AppSizes.vendorPageImageHeight,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),

              //curved top
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: AppSizes.vendorPageInfoCurveHeight,
                  decoration: BoxDecoration(
                    borderRadius: AppSizes.containerTopBorderRadiusShape(),
                    color: AppColor.appBackground(context),
                  ),
                ),
              ),

              //delivery time
              Positioned(
                right: 20,
                top: AppSizes.vendorPageInfoTopMargin,
                child: DeliveryTimeButton(
                  deliveryTime: vendor.deliveryTime,
                ),
              ),
            ],
          ),

          //Vendor info
          Padding(
            // padding: AppPaddings.vendorPageContentPadding(),
            padding: EdgeInsets.fromLTRB(
              AppPaddings.contentPaddingSize,
              AppPaddings.contentPaddingSize,
              AppPaddings.contentPaddingSize,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[
                //vendor name text
                Text(
                  vendor.name,
                  style: AppTextStyle.h2TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                  
                ),

                //vendor is open or not and vendor address
                SizedBox(
                  height: 10,
                ),
                Row(
                  
                  children: <Widget>[
                    Text(
                      this.vendor.open
                          ? VendorStrings.open.i18n
                          : VendorStrings.close.i18n,
                      style: AppTextStyle.h5TitleTextStyle(
                        color: this.vendor.open
                            ? AppColor.vendorOpenColor
                            : AppColor.vendorCloseColor,
                        fontWeight: FontWeight.w500,
                      ),
                      
                    ),
                    Text(
                      AppStrings.dot,
                      
                      style: AppTextStyle.h5TitleTextStyle(
                        color: AppColor.textColor(context),
                      ),
                    ),
                    Text(
                      vendor.address,
                      style: AppTextStyle.h5TitleTextStyle(
                        color: AppColor.textColor(context),
                      ),
                      
                    ),
                  ],
                ),

                Divider(
                  height: 30,
                ),

                //rating, deliver fee
                RichText(
                  
                  text: TextSpan(
                    style: AppTextStyle.h5TitleTextStyle(
                      color: AppColor.textColor(context),
                    ),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.star,
                          size: 16,
                          color: AppColor.textColor(context),
                        ),
                      ),
                      TextSpan(
                        text: " ${vendor.rating} ",
                      ),
                      TextSpan(
                        text: " ${AppStrings.dot} ",
                      ),
                      TextSpan(
                        text:
                            "${AppStrings.minimumOrderLabel.i18n} - ${vendor.currency.symbol} ${vendor.minimumOrder}",
                      ),
                      TextSpan(
                        text: " ${AppStrings.dot} ",
                      ),
                      TextSpan(
                        text: CartStrings.deliveryFee,
                      ),
                      TextSpan(
                        text: "${vendor.currency.symbol} ${vendor.deliveryFee}",
                      ),
                    ],
                  ),
                ),
                //search bar

                Divider(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
