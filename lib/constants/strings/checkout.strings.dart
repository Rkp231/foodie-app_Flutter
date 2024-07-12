import 'package:foodie/translations/checkout.i18n.dart';

class CheckoutStrings {
  static String get title => "Checkout".i18n;

  static String get deliverTo => "Deliver To".i18n;

  static String get deliverToInstruction =>
      "Select your preferred delivery address".i18n;
  static String get changeAddress => "Change".i18n;

  static String get paymentOptions => "Payment Options".i18n;
  static String get paymentOptionsInstruction =>
      "Select your preferred payment option".i18n;

  static String get emptyPaymentOptionsTitle => "Payment Option".i18n;
  static String get emptyPaymentOptionsBody =>
      "There are no available payment method. please try again later or contact support"
          .i18n;

  static String get emptyDeliveryAddressTitle => "Delivery Addres".i18n;
  static String get emptyDeliveryAddressBody =>
      "Please select a delivery addres for your order".i18n;

  static String get processTitle =>
      "Please wait while we process your order...".i18n;
  static String get processCompleteTitle => "Order Placed Successfully!".i18n;
  static String get processFailedTitle => "Order Failed!".i18n;

  static String get processCompleteBody =>
      "Order Paymennt Complete. Your order would be updated shortly. Thank you"
          .i18n;

  static String get pickupDeliveryMethod => "Pickup".i18n;
  static String get deliverToDeliveryMethod => "Delivery".i18n;

  static String get pickupDeliveryMethodInstruction =>
      "Pickup your item from the vendor. Delivery fee will be excluded".i18n;

  static String get outOfVendorRange =>
      "Sorry vendor can't deliver to selected address".i18n;

  static String get checkoutNote =>
      "For extra description you can add them here e.g house number, less spice"
          .i18n;
}
