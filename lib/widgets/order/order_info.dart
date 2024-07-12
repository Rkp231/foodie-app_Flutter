import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/order.strings.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/widgets/order/order_actions.dart';
import 'package:foodie/widgets/order/order_item.dart';
import 'package:foodie/widgets/order/order_product_info.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({
    Key key,
    this.order,
    this.onCancelledPressed,
  }) : super(key: key);

  final Order order;
  final Function onCancelledPressed;

  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.percentHeight * 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: <Widget>[
          //info of order
          OrderItem(
            order: this.widget.order,
            showAllActions: true,
            onCancelPressed: this.widget.onCancelledPressed,
          ),
          // order status
          Divider(),
         OrderActions(
           order: this.widget.order,
           openDeliveryTracking:  _openDeliveryBoyTracking,
           openChat: _openOrderChat,
         ),

          Divider(),
          //products title/header
          Container(
            padding: EdgeInsets.all(AppPaddings.buttonPaddingSize),
            width: double.infinity,
            child: Text(
              OrderStrings.products,
              style: AppTextStyle.h3TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              textAlign: TextAlign.start,
              
            ),
          ),

          //list of products
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(AppPaddings.buttonPaddingSize),
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return OrderProductInfo(
                  currency: this.widget.order.currency,
                  product: this.widget.order.products[index],
                );
              },
              itemCount: this.widget.order.products.length,
            ),
          ),
        ],
      ),
    );
  }


  //open tracking
  void _openDeliveryBoyTracking() {
    Navigator.pushNamed(
      context,
      AppRoutes.trackOrderRoute,
      arguments: this.widget.order,
    );
  }

  //open chat
  void _openOrderChat(bool withVendor) {
    //
    Navigator.pushNamed(
      context,
      AppRoutes.chatRoute,
      arguments: [this.widget.order, withVendor],
    );
  }
}
