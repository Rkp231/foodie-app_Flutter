import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/widgets/buttons/delivery_time_button.dart';
import 'package:foodie/translations/home/home.i18n.dart';

class VendorListViewItem extends StatefulWidget {
  VendorListViewItem({
    Key key,
    @required this.vendor,
  }) : super(key: key);

  final Vendor vendor;
  @override
  _VendorListViewItemState createState() => _VendorListViewItemState();
}

class _VendorListViewItemState extends State<VendorListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.vendor.slug,
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
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
                  height: AppSizes.vendorImageHeight,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: AppSizes.vendorImageHeight,
                fit: BoxFit.cover,
                width: double.infinity,
              ),

              //vendor info
              Container(
                padding: AppPaddings.defaultPadding(),
                margin: EdgeInsets.only(
                  top: AppSizes.vendorImageHeight - 10,
                ),
                decoration: BoxDecoration(
                  color: AppColor.listItemBackground(context),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  
                  children: <Widget>[
                    //vendor name
                    Flexible(
                      child: Row(
                        
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.vendor.name,
                              style: AppTextStyle.h4TitleTextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColor.textColor(context),
                              ),
                              
                            ),
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
                                  text: "  ${widget.vendor.rating}  ",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //product types and minimum order amount
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Row(
                        
                        children: <Widget>[
                          //menu types
                          Expanded(
                            child: Text(
                              widget.vendor.categories,
                              style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.iconHintColor,
                              ),
                              
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          //minimum order amount
                          Text(
                            "${AppStrings.minimumOrderLabel.i18n} - ${widget.vendor.currency.symbol}${widget.vendor.minimumOrder}",
                            style: AppTextStyle.h5TitleTextStyle(
                              color: AppColor.textColor(context),
                            ),
                            
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //delivery info
              //delivery time
              Positioned(
                right: 20,
                top: AppSizes.vendorImageHeight - 40,
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
