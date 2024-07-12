import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/payment_option.dart';
import 'package:foodie/utils/ui_spacer.dart';

class PaymentOptionListViewItem extends StatelessWidget {
  const PaymentOptionListViewItem({
    Key key,
    @required this.paymentOption,
    @required this.onPressed,
  }) : super(key: key);

  final PaymentOption paymentOption;
  final Function(PaymentOption) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColor.listItemBackground(context),
        elevation: 2,
        padding: AppPaddings.mediumButtonPadding(),
      ),
      onPressed: () {
        this.onPressed(this.paymentOption);
      },
      child: Row(
        
        children: <Widget>[
          //Payment option logo/image
          this.paymentOption.isWallet
              ? Icon(
                  FlutterIcons.wallet_ant,
                )
              : CachedNetworkImage(
                  imageUrl: this.paymentOption.logo,
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
          UiSpacer.horizontalSpace(),
          //payment option name and description
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: <Widget>[
                Text(
                  this.paymentOption.name,
                  style: AppTextStyle.h4TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                  
                ),
                Text(
                  this.paymentOption.description,
                  style: AppTextStyle.h5TitleTextStyle(
                    fontWeight: FontWeight.w300,
                    color: AppColor.hintTextColor(context),
                  ),
                  
                ),
              ],
            ),
          ),
          //arrow icon
          Icon(
            FlutterIcons.right_ant,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
