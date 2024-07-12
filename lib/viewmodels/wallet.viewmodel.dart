import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/strings/wallet.strings.dart';
import 'package:foodie/data/models/currency.dart';
import 'package:foodie/data/models/wallet.dart';
import 'package:foodie/data/repositories/wallet.repository.dart';
import 'package:foodie/services/validator.service.dart';
import 'package:foodie/viewmodels/viewmodel.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/buttons/outline_custom_button.dart';
import 'package:foodie/widgets/inputs/custom_text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class WalletViewModel extends ViewModel {
  //
  WalletRepository walletRepository = WalletRepository();
  Wallet wallet;
  Currency currency;
  String newTopUpAmount;

  //
  initialize(context) async {
    //
    this.viewContext = context;
    //
    await fetchWallet();
  }

  //
  fetchWallet() async {
    setBusy(true);
    try {
      final resultData = await walletRepository.getWallet();
      currency = resultData[0];
      wallet = resultData[1];
      clearErrors();
    } catch (error) {
      print("Error  => $error");
      setError(error);
    }
    setBusy(false);
  }

  //
  topUpWallet() async {
    //
    TextEditingController amountTEC = new TextEditingController();
    //
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        return SafeArea(
          child: Form(
            key: formKey,
            child: VStack(
              [
                //
                WalletStrings.topUp.text.xl2.semiBold
                    .make()
                    .pOnly(bottom: Vx.dp12),
                WalletStrings.instruction.text.make().pOnly(bottom: Vx.dp20),
                //
                CustomTextFormField(
                  isFixedHeight: false,
                  hintText: WalletStrings.amount,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  textEditingController: amountTEC,
                  validator: (value) => FormValidator.validateEmpty(value,
                      errorTitle: WalletStrings.amount),
                ),

                //
                HStack(
                  [
                    //
                    Spacer(),
                    //
                    CustomOutlineButton(
                      child: WalletStrings.cancel.text.make(),
                      onPressed: () {
                        viewContext.pop();
                      },
                    ).px12(),
                    //
                    CustomButton(
                      child: WalletStrings.proceed.text.make(),
                      color: AppColor.primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        //
                        if (formKey.currentState.validate()) {
                          //
                          newTopUpAmount = amountTEC.text;
                          //
                          viewContext.pop();
                          //
                          processTopUpWallet();
                        }
                      },
                    ),
                  ],
                ).py12(),
              ],
            ).p20().pOnly(bottom: viewContext.mq.viewInsets.bottom),
          ),
        );
      },
    );
  }

  //
  // showPaymentOptions() {
  //   //
  //   showModalBottomSheet(
  //     context: viewContext,
  //     builder: (context) {
  //       return SafeArea(
  //         child: PaymentOptionPicker(
  //           // paymentOptionSelected: processTopUpWallet,
  //         ),
  //       );
  //     },
  //   );
  // }

  //
  processTopUpWallet() async {
    setBusyForObject(wallet, true);
    try {
      final apiResponse = await walletRepository.requestTopUp(newTopUpAmount);
      //
      if (apiResponse.allGood) {
        //open link
        await launch(
          apiResponse.body["link"],
          forceSafariVC: true,
          forceWebView: true,
        );
      } else {
        //
        viewContext.showToast(msg: apiResponse.message, bgColor: Colors.red);
      }
    } catch (error) {
      print("Error  => $error");
    }
    setBusyForObject(wallet, false);
  }
}
