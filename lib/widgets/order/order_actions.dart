import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/order.strings.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/buttons/outline_custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderActions extends StatelessWidget {
  const OrderActions({
    @required this.order,
    @required this.openDeliveryTracking,
    @required this.openChat,
    Key key,
  }) : super(key: key);

  final Order order;
  final Function openDeliveryTracking;
  final Function(bool) openChat;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //track delivery boy
        order.isEnroute()
            ? CustomButton(
                onPressed: openDeliveryTracking,
                color: AppColor.accentColor,
                child: HStack(
                  [
                    Icon(
                      Icons.local_shipping,
                      color: Colors.white,
                    ),
                    UiSpacer.horizontalSpace(space: 10),
                    Text(
                      OrderStrings.trackOrder,
                      style: AppTextStyle.h4TitleTextStyle(
                        color: Colors.white,
                      ),
                      
                    ),
                  ],
                ).px12(),
              ).wFull(context)
            : UiSpacer.empty(),

        //chat vendor
        (!order.isCancelled() && !order.isDelivered() && !order.isFailed())
            ? CustomOutlineButton(
                onPressed: () => openChat(true),
                color: AppColor.accentColor,
                child: HStack(
                  [
                    Icon(
                      Icons.chat,
                      color: AppColor.accentColor,
                    ).pOnly(right: Vx.dp8),
                    Text(
                      OrderStrings.vendorChatTitle,
                      style: AppTextStyle.h4TitleTextStyle(
                        color: AppColor.accentColor,
                      ),
                      
                    ),
                  ],
                ).centered(),
              ).py4()
            : UiSpacer.empty(),

        //chat delivery boy
        order.isEnroute()
            ? CustomOutlineButton(
                onPressed: () => openChat(false),
                color: AppColor.accentColor,
                child: HStack(
                  [
                    Icon(
                      Icons.chat,
                      color: AppColor.accentColor,
                    ).pOnly(right: Vx.dp8),
                    Text(
                      OrderStrings.driverChatTitle,
                      style: AppTextStyle.h4TitleTextStyle(
                        color: AppColor.accentColor,
                      ),
                      
                    ),
                  ],
                ).centered(),
              ).py4()
            : UiSpacer.empty(),
      ],
    );
  }
}
