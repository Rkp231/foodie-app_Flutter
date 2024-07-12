import 'package:flutter/material.dart';
import 'package:foodie/constants/strings/chat.strings.dart';
import 'package:foodie/data/models/message.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessageListItem extends StatelessWidget {
  const ChatMessageListItem({this.message, this.withVendor, Key key}) : super(key: key);

  final Message message;
  final bool withVendor;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        "${message.customer ? ChatStrings.customer : !withVendor ? ChatStrings.driver : ChatStrings.vendor}"
            .text.gray600.sm
            .make(),
        message.text.text.medium.make(),
      ],
    ).px12();
  }
}
