import 'package:flutter/material.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/strings/checkout.strings.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/data/models/dialog_data.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/data/models/payment_option.dart';
import 'package:foodie/data/repositories/checkout.repository.dart';
import 'package:foodie/utils/custom_dialog.dart';
import 'package:foodie/viewmodels/viewmodel.dart';
import 'package:paystack_manager/paystack_manager.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

class PaymentViewModel extends ViewModel {
  //delivery address repository
  CheckOutRepository checkOutRepository = CheckOutRepository();

  //Razorpay instance
  final _razorpay = Razorpay();
  //newOrder variable
  Order newOrder;
  //for dialog
  DialogData dialogData = DialogData();

  //
  var cartTotalAmount = 0.00;
  var cartDiscountAmount = 0.00;
  var cartSubTotalAmount = 0.00;
  var vendorDeliveryFee = 0.00;

  void prepareOrderAmounts({bool includeDeliveryFee = true}) {
    if (includeDeliveryFee) {
      newOrder.totalAmount = newOrder.subTotalAmount -
          newOrder.discountAmount +
          newOrder.deliveryFee;
    } else {
      newOrder.totalAmount = newOrder.subTotalAmount - newOrder.discountAmount;
    }
  }

  //Payment via card
  void processCardPayment({
    PaymentOption paymentOption,
    BuildContext context,
    dynamic responseBody,
  }) async {
    if (paymentOption.slug.toLowerCase() == "razorpay") {
      _payViaRazorPay(paymentOption, context);
    } else if (paymentOption.slug.toLowerCase() == "paystack") {
      _payViaPaystack(
        paymentOption,
        context,
        reference: newOrder.code,
      );
    } else if (paymentOption.slug.toLowerCase() == "flutterwave") {
      _payViaFlutterwave(
        paymentOption,
        context,
        reference: newOrder.code,
      );
    }
    //load the payment link
    else if (responseBody["link"] != null) {
      //x
      Navigator.popAndPushNamed(
        context,
        AppRoutes.webViewRoute,
        arguments: responseBody["link"],
      );
    } else {
      print("Payment Payment not implmented");
    }
  }

  //razorpay payment
  void _payViaRazorPay(PaymentOption paymentOption, context) async {
    //add the razorpay handlers
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    var options = {
      'key': "${paymentOption.publicKey}",
      'amount': cartTotalAmount * 100,
      'name': AppStrings.appName,
      'order_id': newOrder.transactionRef,
      'description': 'Payment for items in cart',
      'prefill': {
        'email': (await appDatabase.userDao.findCurrent()).email,
      }
    };

    //open the checkout
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //process payment succefull checkout
    _handleSuccessfulPayment();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    //payment failed
    _handleFailedPayment();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("Payment External Response ==> $response");
  }

  //flutterwave
  _payViaFlutterwave(
    PaymentOption paymentOption,
    BuildContext context, {
    String reference = "",
  }) async {
    final currentUser = await appDatabase.userDao.findCurrent();
    //
    final Flutterwave flutterwave = Flutterwave.forUIPayment(
      context: context,
      encryptionKey: paymentOption.secretHash,
      publicKey: paymentOption.publicKey,
      currency: newOrder.currency.code,
      amount: newOrder.totalAmount.toString(),
      email: currentUser.email,
      fullName: currentUser.name,
      txRef: newOrder.code,
      isDebugMode: true,
      phoneNumber: currentUser.phone,
      acceptCardPayment: true,
      acceptUSSDPayment: false,
      acceptAccountPayment: false,
      acceptFrancophoneMobileMoney: false,
      acceptGhanaPayment: true,
      acceptMpesaPayment: false,
      acceptRwandaMoneyPayment: true,
      acceptUgandaPayment: true,
      acceptZambiaPayment: false,
    );

    try {
      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      if (response == null) {
        // user didn't complete the transaction. Payment wasn't successful.
        print("User cancel transaction");
        _handleFailedPayment(
          status: "cancelled",
        );
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          // provide value to customer
          print("Successfull Man");
          _handleSuccessfulPayment();
        } else {
          print("Failed");
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data.processorResponse);
          _handleFailedPayment();
        }
      }
    } catch (error, stacktrace) {
      //handleError(error);
      print("Payment stacktrace ==> $stacktrace");
      print("Payment error ==> $error");
      _handleFailedPayment();
    }
  }

  bool checkPaymentIsSuccessful(ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL && response.data.txRef == newOrder.code;
    // return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
    //     response.data.currency == newOrder.currency.code &&
    //     response.data.amount == newOrder.totalAmount &&
    //     response.data.txRef == newOrder.code;
  }

  //paystack payment
  void _payViaPaystack(
    PaymentOption paymentOption,
    BuildContext context, {
    String reference = "",
  }) async {
    final currentUser = await appDatabase.userDao.findCurrent();

    PaystackPayManager(context: context)
      ..setSecretKey(paymentOption.secretKey)
      //accepts widget
      ..setReference(reference)
      ..setCompanyAssetImage(Image(
        image: AssetImage(AppImages.appLogo),
      ))
      //the amount is in kobo,peswas or cents
      ..setAmount(
        (cartTotalAmount * 100).toInt(),
      )
      ..setCurrency(
        (await appDatabase.currencyDao.findAllCurrencys())[0].code,
      )
      ..setEmail(currentUser.email)
      ..setFirstName(currentUser.name)
      ..setLastName("")
      ..setMetadata(
        {
          "custom_fields": [
            {
              "value": AppStrings.appName,
              "display_name": "Payment to",
              "variable_name": "payment_to"
            }
          ]
        },
      )
      ..onSuccesful(_onPaymentSuccessful)
      ..onFailed(_onPaymentFailed)
      ..onCancel(_onPaymentCancelled)
      ..initialize();
  }

  void _onPaymentSuccessful(Transaction transaction) {
    //process payment succefull checkout
    _handleSuccessfulPayment();
  }

  void _onPaymentFailed(Transaction transaction) async {
    //process payment failure checkout
    _handleFailedPayment();
  }

  void _onPaymentCancelled(Transaction transaction) async {
    //payment was canncelled
    _handleFailedPayment(
      status: "cancelled",
    );
  }

  // process checkout payment failed
  void _handleFailedPayment({
    String status = "failed",
  }) async {
    dialogData.title = CheckoutStrings.title;
    dialogData.body = CheckoutStrings.processTitle;
    dialogData.dialogType = DialogType.loading;
    dialogData.isDismissible = false;

    //show loading
    CustomDialog.showAlertDialog(viewContext, dialogData);
    dialogData = await checkOutRepository.updateStatus(
      newOrder.id,
      status: status,
      paymentStatus: "failed",
    );

    //show loading
    CustomDialog.dismissDialog(viewContext);

    dialogData.isDismissible = true;
    //notify the ui with the newly gotten dialogdata model
    CustomDialog.showAlertDialog(viewContext, dialogData);
  }

  //process payment succefull checkout
  void _handleSuccessfulPayment() {
    dialogData.title = GeneralStrings.successfulTitle;
    dialogData.body = CheckoutStrings.processCompleteBody;
    dialogData.dialogType = DialogType.successThenClosePage;
    dialogData.isDismissible = true;
    CustomDialog.showAlertDialog(viewContext, dialogData);
  }
}
