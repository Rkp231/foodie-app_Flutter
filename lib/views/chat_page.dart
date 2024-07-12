import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/strings/chat.strings.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/viewmodels/chat.viewmodel.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/inputs/custom_text_form_field.dart';
import 'package:foodie/widgets/listview/chat_message.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatPage extends StatelessWidget {
  ChatPage({this.order, this.vendor, Key key}) : super(key: key);

  final Order order;
  final bool vendor;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(context, order, vendor),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            title:
                "${ChatStrings.chatTitle} ${!vm.withVendor ? ChatStrings.driver : ChatStrings.vendor}"
                    .text
                    .make(),
            centerTitle: false,
          ),
          body: VStack(
            [
              //
              ListView.separated(
                reverse: true,
                itemCount: vm.messages.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  //
                  return ChatMessageListItem(
                    message: vm.messages[index],
                    withVendor: vm.withVendor,
                  );
                },
              ).expand(),
              //
              SafeArea(
                child: CustomTextFormField(
                  padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  isFixedHeight: false,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  textEditingController: vm.messageTEC,
                  maxLines: 3,
                  hintText: ChatStrings.message,
                  suffixWidget: CustomButton(
                    child: ChatStrings.send.text.white.make(),
                    color: AppColor.primaryColor,
                    onPressed: vm.sendMessage,
                    loading: vm.isBusy,
                  ),
                ).px8(),
              ),
            ],
          ),
        );
      },
    );
  }
}
