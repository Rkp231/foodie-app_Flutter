import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/cornered_container.dart';
import 'package:foodie/translations/order.i18n.dart';

class OrderItem extends StatelessWidget {
  OrderItem({
    Key key,
    this.order,
    this.onPressed,
    this.onCancelPressed,
    this.showAllActions = false,
  }) : super(key: key);

  final Order order;
  final Function(Order) onPressed;
  final Function onCancelPressed;
  final bool showAllActions;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(10),
      ),
      onPressed: this.onPressed == null
          ? null
          : () {
              this.onPressed(this.order);
            },
      
      child: Row(
        
        children: <Widget>[
          //order preview imgae
          CorneredContainer(
            child: CachedNetworkImage(
              imageUrl: this.order.vendor.logo,
              placeholder: (context, url) => Container(
                height: AppSizes.productImageHeight,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: AppSizes.productImageHeight,
              fit: BoxFit.fill,
              width: AppSizes.productImageWidth,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          //order info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[
                Text(
                  this.order.code.toUpperCase(),
                  style: AppTextStyle.h4TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                  
                ),
                Text(
                  this.order.formattedDate,
                  style: AppTextStyle.h5TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                  
                ),
                Text(
                  "${this.order.currency.symbol} ${this.order.totalAmount}",
                  style: AppTextStyle.h4TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                  
                ),
              ],
            ),
          ),

          //status
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColor.statusColor(
                    status: this.order.status,
                  ),
                  borderRadius: AppSizes.containerBorderRadiusShape(
                    radius: 10,
                  ),
                ),
                child: Text(
                  StringUtils.capitalize(this.order.status).i18n,
                  style: AppTextStyle.h5TitleTextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  
                ),
              ),
              (this.showAllActions && this.order.isPending())
                  ? ButtonTheme(
                      height: 30,
                      child: CustomButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          GeneralStrings.cancel,
                          style: AppTextStyle.h5TitleTextStyle(
                            color: Colors.red,
                          ),
                          
                        ),
                        borderColor: Colors.red,
                        onPressed: this.onCancelPressed,
                      ),
                    )
                  : UiSpacer.verticalSpace(space: 0),
            ],
          ),
        ],
      ),
    );
  }
}
