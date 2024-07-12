import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/deliver_address.dart';

class DeliveryAddressItem extends StatefulWidget {
  DeliveryAddressItem({
    Key key,
    this.deliveryAddress,
    this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  final DeliveryAddress deliveryAddress;
  final Function(DeliveryAddress selectedDeliveryAddres) onPressed;
  final Function(DeliveryAddress selectedDeliveryAddres) onLongPressed;
  @override
  _DeliveryAddressItemState createState() => _DeliveryAddressItemState();
}

class _DeliveryAddressItemState extends State<DeliveryAddressItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.deliveryAddress.icon(context),
      title: Text(
        widget.deliveryAddress.name,
        style: AppTextStyle.h4TitleTextStyle(
          color: AppColor.textColor(context),
        ),
        
      ),
      subtitle: Text(
        widget.deliveryAddress.address,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.h5TitleTextStyle(
          color: AppColor.hintTextColor(context),
        ),
        
      ),
      onTap: widget.onPressed != null
          ? () {
              widget.onPressed(
                widget.deliveryAddress,
              );
            }
          : null,
      onLongPress: widget.onLongPressed != null
          ? () {
              widget.onLongPressed(
                widget.deliveryAddress,
              );
            }
          : null,
    );
  }
}
