import 'package:foodie/translations/product.i18n.dart';

class ProductStrings {
  static String get addToCart => "Add to cart".i18n;
  static String get extras => "Extras".i18n;
  static String get quantity => "Quantity".i18n;
  static String get title => "My Cart".i18n;

  static String get emptyBody => "No Extras available for selection".i18n;
  static String get changeVendorTitle => 'Reset Cart?'.i18n;
  static String get changeVendorBody =>
      'You are about to add food from a different vendor/restaurant. Product(s) in cart will be cleard. Are you sure you want to continue?'
          .i18n;

  static String get addedToCart => 'Added To Cart'.i18n;
  static String get addedToCartMessage => 'has been added to cart'.i18n;
}
