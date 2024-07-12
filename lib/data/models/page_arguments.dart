import 'package:foodie/data/models/product.dart';
import 'package:foodie/data/models/vendor.dart';

class PageArguments {
  final Product product;
  final Vendor vendor;

  PageArguments({
    this.product,
    this.vendor,
  });
}
