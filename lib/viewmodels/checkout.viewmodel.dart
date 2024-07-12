import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/strings/checkout.strings.dart';
import 'package:foodie/constants/strings/profile/delivery_address.strings.dart';
import 'package:foodie/data/models/currency.dart';
import 'package:foodie/data/models/deliver_address.dart';
import 'package:foodie/data/models/dialog_data.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/data/models/payment_option.dart';
import 'package:foodie/data/models/product.dart';
import 'package:foodie/data/repositories/delivery_address.repository.dart';
import 'package:foodie/data/repositories/wallet.repository.dart';
import 'package:foodie/utils/custom_dialog.dart';
import 'package:foodie/viewmodels/payment.view_model.dart';
import 'package:foodie/widgets/deliver_to_bottom_sheet_content.dart';

class CheckOutPageViewModel extends PaymentViewModel {
  //delivery address repository
  DeliveryAddressRepository deliveryAddressRepository =
      DeliveryAddressRepository();
  WalletRepository walletRepository = WalletRepository();

  //
  TextEditingController noteTEC = TextEditingController();

  //View data
  DeliveryAddress selectedDeliveryAddress;
  List<PaymentOption> paymentOptions = [];

  //
  int currentDeliveryMethodSelection = 0;

  CheckOutPageViewModel(BuildContext context, Order order) {
    viewContext = context;
    newOrder = order;
  }

  get hasPaymentOptions {
    return paymentOptions != null && paymentOptions.length > 0;
  }

  //getting the title that will be used for segemented buttons
  get deliveryMethods {
    return {
      0: Text(CheckoutStrings.deliverToDeliveryMethod),
      1: Text(CheckoutStrings.pickupDeliveryMethod),
    };
  }

  //call this method on ready
  void initialise() async {
    //
    await getVendorDetails();
    await getPaymentOptions();
    await getDefaultDeliveryAddress();
  }

  //
  //getting the last used address on default delivery address
  void getVendorDetails() async {
    setBusyForObject(selectedDeliveryAddress, true);
    try {
      newOrder.vendor = await vendorRepository.getVendorDetails(
        vendorId: newOrder.vendor.id,
      );

      //
      clearErrors();
      updateSelectedDeliveryAddress(selectedDeliveryAddress);
    } catch (error) {
      setErrorForObject(selectedDeliveryAddress, error);
    }

    setBusyForObject(selectedDeliveryAddress, false);
  }

  //getting the last used address on default delivery address
  void getDefaultDeliveryAddress() async {
    setBusyForObject(selectedDeliveryAddress, true);
    try {
      selectedDeliveryAddress =
          await deliveryAddressRepository.preselectDeliveryAddress(
        vendorId: newOrder.vendor.id,
      );

      //
      clearErrors();
      updateSelectedDeliveryAddress(selectedDeliveryAddress);
    } catch (error) {
      // setBusyForObject(selectedDeliveryAddress, false);
      setErrorForObject(selectedDeliveryAddress, error);
    }

    setBusyForObject(selectedDeliveryAddress, false);
  }

  //getting the payment options
  void getPaymentOptions() async {
    //
    setBusyForObject(paymentOptions, true);
    try {
      //
      paymentOptions = await checkOutRepository.paymentOptions();

      clearErrors();
    } catch (error) {
      setErrorForObject(paymentOptions, error);
    }
    setBusyForObject(paymentOptions, false);
  }

  //when user change delivery address
  void changeDeliveryAddress() {
    //show bottomsheet with delivery addresses container
    CustomDialog.showCustomBottomSheet(
      viewContext,
      contentPadding: AppPaddings.defaultPadding(),
      content: DeliverTo(
        vendorId: newOrder.vendor.id,
        onSubmit: updateSelectedDeliveryAddress,
      ),
    );
  }

  void updateSelectedDeliveryAddress(DeliveryAddress deliveryAddress) {
    selectedDeliveryAddress = deliveryAddress;
    if (selectedDeliveryAddress.distance > newOrder.vendor.deliveryRange) {
      setErrorForObject(
        selectedDeliveryAddress,
        CheckoutStrings.outOfVendorRange,
      );
    }
    notifyListeners();
  }

  void updateSelectedDeliveryOption(int index) {
    currentDeliveryMethodSelection = index;
    notifyListeners();
  }

  //process checkout
  void processCheckout(
    PaymentOption selectedPaymentOption,
    BuildContext context,
  ) async {
    //checking if user has selected a delivery address
    if (currentDeliveryMethodSelection == 0 &&
        (selectedDeliveryAddress == null ||
            selectedDeliveryAddress.distance > newOrder.vendor.deliveryRange)) {
      showErrorAlert(
        title: DeliveryaAddressStrings.subTitle,
        description: DeliveryaAddressStrings.selectionRequired,
      );
    }
    //process the initiate checkout order
    else {
      //
      prepareOrderAmounts(
        includeDeliveryFee: currentDeliveryMethodSelection == 0,
      );

      //process the checkout
      var dialogData = DialogData();
      dialogData.title = CheckoutStrings.title;
      dialogData.body = CheckoutStrings.processTitle;
      dialogData.dialogType = DialogType.loading;
      dialogData.isDismissible = false;

      //preparing data to be sent to server
      CustomDialog.showAlertDialog(viewContext, dialogData,
          isDismissible: false);

      //make the http request
      dialogData = await checkOutRepository.initiateCheckout(
        paymentOption: selectedPaymentOption,
        deliveryAddress: currentDeliveryMethodSelection == 0
            ? selectedDeliveryAddress
            : null,
        vendor: newOrder.vendor,
        currency: newOrder.currency,
        coupon: newOrder.coupon,
        totalAmount: newOrder.totalAmount,
        subTotalAmount: newOrder.subTotalAmount,
        deliveryFee: newOrder.deliveryFee,
        discountAmount: newOrder.discountAmount,
        note: noteTEC.text,
        products: await _fetchCartProductsAndExtras(newOrder.currency),
      );

      //dismiss dialog
      CustomDialog.dismissDialog(viewContext);

      //if request was successful then remove all item related to cart in the database
      if (dialogData.dialogType == DialogType.success) {
        //remove all item related to cart in the database
        await appDatabase.productDao
            .deleteItems(await appDatabase.productDao.findAllProducts());
        await appDatabase.vendorDao
            .deleteItems(await appDatabase.vendorDao.findAllVendors());
        await appDatabase.productExtraDao
            .deleteItems(await appDatabase.productExtraDao.findAll());
      }

      //check if we need to redirect user to payment platform
      if (dialogData.dialogType == DialogType.success &&
          selectedPaymentOption.isCard) {
        //store the refrence code for later
        final orderJSONObject = dialogData.extraData["order"];
        newOrder.id = orderJSONObject["id"];
        newOrder.code = orderJSONObject["code"];
        newOrder.transactionRef = dialogData.extraData["transaction_ref"] ?? "";

        //show the page can dismiss itself
        // setShowDialogAlert(false);
        processCardPayment(
          paymentOption: selectedPaymentOption,
          context: context,
          responseBody: dialogData.extraData,
        );
      } else {
        dialogData.isDismissible = true;
        dialogData.dialogType = DialogType.successThenClosePage;
        //notify the ui with the newly gotten dialogdata model
        CustomDialog.showAlertDialog(viewContext, dialogData);
      }
    }
  }

  //fetch foods and food extras from database
  Future<List<Map<String, dynamic>>> _fetchCartProductsAndExtras(
      Currency currency) async {
    List<Map<String, dynamic>> productsWithExtras = [];

    //fetch all food from database
    List<Product> products = await appDatabase.productDao.findAllProducts();
    for (var product in products) {
      //the food extra with be converted to a sentance
      var extrasString = "";
      //get all food extras attached to this food
      final extras =
          await appDatabase.productExtraDao.findAllByProductId(product.id);
      extras.asMap().forEach((index, extra) {
        extrasString += "${extra.name}(${currency.symbol}${extra.price})";
        if (index < extras.length - 1) {
          extrasString += ",";
        }
      });

      productsWithExtras.add({
        "id": product.id,
        "price": product.priceWithExtras,
        "quantity": product.selectedQuantity,
        "extras": extrasString,
      });
    }

    return productsWithExtras;
  }
}
