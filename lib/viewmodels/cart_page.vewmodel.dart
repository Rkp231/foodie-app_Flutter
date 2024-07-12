import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/data/database/app_database_singleton.dart';
import 'package:foodie/data/models/coupon.dart';
import 'package:foodie/data/models/currency.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/data/models/product.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/data/repositories/checkout.repository.dart';
import 'package:foodie/viewmodels/base.viewmodel.dart';

class CartPageViewModel extends MyBaseViewModel {
  //
  CheckOutRepository checkOutRepository = new CheckOutRepository();

  //getting the currency
  Currency currency;
  List<Product> products = [];
  Vendor vendor;
  Coupon coupon;
  TextEditingController couponCodeTEC = new TextEditingController();

  //subtotal food amount
  double subTotalAmount = 0.0;
  double deliveryFee = 0.0;
  double discountAmount = 0.0;
  double totalAmount = 0.0;

  CartPageViewModel(BuildContext context) {
    this.viewContext = context;
  }

  initialize() async {
    currency =
        await AppDatabaseSingleton.database.currencyDao.findLatestCurrency();
    products = await AppDatabaseSingleton.database.productDao.findAllProducts();
    notifyListeners();

    //hanlde changes in values of database data
    startDataValueListener();
  }

  //validate the coupon code from the user
  void applyCoupon(String couponCode) async {
    if (couponCode.isNotEmpty) {
      setBusyForObject(coupon, true);

      try {
        coupon = await checkOutRepository.getCouponDetails(
          code: couponCode,
        );

        //
        updateTotalOrderAmount();
      } catch (error) {
        setErrorForObject(coupon, error);
      }

      setBusyForObject(coupon, false);
    }
  }

  void checkoutPressed() {
    if (vendor.minimumOrder > subTotalAmount) {
      //
      EdgeAlert.show(
        this.viewContext,
        title: "Checkout",
        description:
            "Total order amount is less than vendor minimum order amount",
        backgroundColor: Colors.red,
      );
    } else if (AuthBloc.authenticated()) {
      //prepare order
      Order order = new Order();
      order.products = products;
      order.vendor = vendor;
      order.currency = currency;
      order.discountAmount = discountAmount;
      order.deliveryFee = deliveryFee;
      order.subTotalAmount = subTotalAmount;
      order.totalAmount = totalAmount;
      order.coupon = coupon;

      //open checkout page
      Navigator.pushNamed(
        viewContext,
        AppRoutes.checkOutRoute,
        arguments: order,
      );
    } else {
      //navigate to login page
      Navigator.pushNamed(
        viewContext,
        AppRoutes.loginOTPRoute,
      );
    }
  }

  void startDataValueListener() {
    AppDatabaseSingleton.database.productDao
        .findAllProductsAsStream()
        .listen((mProducts) {
      products = mProducts;
      notifyListeners();
    });

    //listen to food items in cart
    AppDatabaseSingleton.database.productDao.findAllProductsAsStream().listen(
      (products) {
        //set the subtotal amount to 0 before recalculating the subtotal amount
        subTotalAmount = 0.0;
        //loop through the foods to calculate the subtotal amount
        products.forEach(
          (product) {
            subTotalAmount +=
                product.priceWithExtras * product.selectedQuantity;
          },
        );
        //update the total order amount
        updateTotalOrderAmount();
      },
    );

    //listen to food items in cart
    AppDatabaseSingleton.database.vendorDao.findAllVendorsAsStream().listen(
      (vendors) {
        //to avoid error when cart items are cleared
        if (vendors != null && vendors.length > 0) {
          //set the subtotal amount to 0 before recalculating the subtotal amount
          vendor = vendors[0];
          deliveryFee = vendor.deliveryFee;
          //update the total order amount
          updateTotalOrderAmount();
        }
      },
    );
  }

  //update total order amount
  void updateTotalOrderAmount() {
    subTotalAmount = subTotalAmount;
    deliveryFee = deliveryFee;
    //calculate the discount amount
    discountAmount = _calculateDiscountAmount();
    totalAmount = (subTotalAmount - discountAmount) + deliveryFee;
    notifyListeners();
  }

  double _calculateDiscountAmount() {
    //if the coupon is innvalid or the discount is equals zero
    if (coupon == null || (coupon.discount ?? 0) <= 0.00) {
      return 0.00;
    }

    //checking if coupon is general purpose
    if (coupon.productsIds.length == 0 && coupon.vendorsIds.length == 0) {
      return _calculateSubTotalAmountDiscount();
    }
    //checking if vendor can use this coupon
    final productsVendorId = products[0].vendorId;

    if (coupon.vendorsIds.length > 0 &&
        coupon.vendorsIds.contains(productsVendorId)) {
      return _calculateSubTotalAmountDiscount();
    }

    //checking if product can use this coupon
    if (coupon.productsIds.length > 0) {
      var totalDiscount = 0.00;

      //loop through the products inn cart to find the one that the discount can apply to
      for (var product in products) {
        if (coupon.productsIds.contains(product.id)) {
          if (coupon.isPercentage) {
            totalDiscount += product.price * (coupon.discount / 100);
          } else {
            totalDiscount += coupon.discount;
          }
        }
      }

      return totalDiscount;
    }

    return 0.00;
  }

  //this is for calculating price of discount on subtotal amount
  double _calculateSubTotalAmountDiscount() {
    if (coupon.isPercentage) {
      return totalAmount * (coupon.discount / 100);
    } else {
      return coupon.discount;
    }
  }
}
