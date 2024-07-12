import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/widgets/buttons/delivery_time_button.dart';

class SmallVendorListViewItem extends StatefulWidget {
  SmallVendorListViewItem({
    Key key,
    @required this.vendor,
  }) : super(key: key);

  final Vendor vendor;
  @override
  _SmallVendorListViewItemState createState() =>
      _SmallVendorListViewItemState();
}

class _SmallVendorListViewItemState extends State<SmallVendorListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.vendor.slug,
      child: Container(
        height: 800,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0),
            // elevation: 3,
            // shape: StadiumBorder(),
            primary: AppColor.listItemBackground(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            //show vendor full info and menu
            Navigator.pushNamed(
              context,
              AppRoutes.vendorRoute,
              arguments: widget.vendor,
            );
          },
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              //vendor feature image
              CachedNetworkImage(
                imageUrl: widget.vendor.featureImage,
                placeholder: (context, url) => Container(
                  height: AppSizes.smallVendorImageHeight,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: AppSizes.smallVendorImageHeight,
                fit: BoxFit.cover,
                width: double.infinity,
              ),

              //vendor info
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPaddings.buttonPaddingSize,
                  vertical: AppPaddings.contentPaddingSize,
                ),
                margin: EdgeInsets.only(
                  top: AppSizes.smallVendorImageHeight - 10,
                ),
                color: AppColor.listItemBackground(context),
                height: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  
                  children: <Widget>[
                    //vendor name
                    Text(
                      widget.vendor.name,
                      style: AppTextStyle.h5TitleTextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textColor(context),
                      ),
                      overflow: TextOverflow.ellipsis,
                      
                    ),
                    //Rating
                    RichText(
                      
                      text: TextSpan(
                        style: AppTextStyle.h6TitleTextStyle(
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
                            text: "  ${widget.vendor.rating}  ",
                          ),
                        ],
                      ),
                    ),

                    //product types and minimum order amount
                    UiSpacer.verticalSpace(space: 10),
                    //menu types
                    Text(
                      widget.vendor.categories,
                      style: AppTextStyle.h6TitleTextStyle(
                        color: AppColor.iconHintColor,
                      ),
                      
                      overflow: TextOverflow.ellipsis,
                    ),
                    UiSpacer.verticalSpace(space: 5),
                    //minimum order amount
                    Text(
                      "${AppStrings.minimumOrderLabel}${widget.vendor.currency.symbol}${widget.vendor.minimumOrder}",
                      style: AppTextStyle.h6TitleTextStyle(
                        color: AppColor.textColor(context),
                      ),
                      
                    ),
                  ],
                ),
              ),

              //delivery info
              //delivery time
              Positioned(
                right: 10,
                top: AppSizes.smallVendorImageHeight - 40,
                child: DeliveryTimeButton(
                  deliveryTime: widget.vendor.deliveryTime,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
