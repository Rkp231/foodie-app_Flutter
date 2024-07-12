import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/constants/strings/product.strings.dart';
import 'package:foodie/data/database/app_database_singleton.dart';
import 'package:foodie/data/models/dialog_data.dart';
import 'package:foodie/data/models/food_extra.dart';
import 'package:foodie/data/models/product.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/utils/price.utils.dart';
import 'package:foodie/viewmodels/base.viewmodel.dart';
import 'package:foodie/widgets/listview/product_extra_list_view_item.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductPageViewModel extends MyBaseViewModel {
  //selected product and vendor model
  Product product;
  Vendor vendor;
  List<ProductExtra> extras = [];

  int quantity = 1;
  String totalAmount = "0.00";
  double productPrice = 0.00;

  ProductPageViewModel(BuildContext context, this.vendor, this.product) {
    this.viewContext = context;
    productPrice = product.hasDiscount ? product.discountPrice : product.price;
    this.totalAmount = PriceUtils.intoDecimalPlaces(productPrice);
  }

  void increaseFoodQuantity() {
    quantity++;
    updateTotalFoodAmount();
  }

  void decreaseFoodQuantity() {
    final newQty = quantity - 1;
    if (newQty >= 1) {
      quantity = newQty;
      updateTotalFoodAmount();
    }
  }

  //method to update the total amount
  void updateTotalFoodAmount() {
    final productPrice =
        product.hasDiscount ? product.discountPrice : product.price;
    final subTotalFoodPrice = productPrice * quantity;

    final totalFoodPrice = subTotalFoodPrice + (totalExtrasPrice() * quantity);
    totalAmount = PriceUtils.intoDecimalPlaces(totalFoodPrice);
    notifyListeners();
  }

  //getting the total amount of extras
  double totalExtrasPrice() {
    var extrasPrice = 0.0;
    //calculate all the prices from selected product extras
    extras.forEach((foodExtra) {
      extrasPrice += foodExtra.price;
    });
    return extrasPrice;
  }

  void updateSelectedFoodExtras(
    ProductExtra selectedProductExtra,
    bool selected,
  ) {
    if (selected) {
      extras.add(selectedProductExtra);
    } else {
      extras.removeWhere(
        (productExtra) => productExtra.id == selectedProductExtra.id,
      );
    }

    updateTotalFoodAmount();
  }

  //saving the product to database/cart
  void addToCart({bool override = false}) async {
    //update product selected quantity
    product.selectedQuantity = quantity;
    product.priceWithExtras = product.hasDiscount
        ? product.discountPrice
        : product.price + totalExtrasPrice();

    //saving the product and options to database
    //if product with same id has been saved before, it will update the record instead of creat new one
    final database = AppDatabaseSingleton.database;
    final productsFound = await database.productDao.findAllByVendorWhereNot(
      product.vendorId,
    );
    //first check if user selcted product from same vendor as any item already in the cart
    if (productsFound.length > 0 && !override) {
      //prepare the data model to be used to show the alert on the view
      DialogData dialogData = DialogData();
      dialogData.title = ProductStrings.changeVendorTitle;
      dialogData.body = ProductStrings.changeVendorBody;
      dialogData.negativeButtonTitle = GeneralStrings.cancel;
      dialogData.positiveButtonTitle = GeneralStrings.yesClear;
      //show dialog alert
      showDialogAlert(
        dialogData: dialogData,
        onPositivePressed: () => addToCart(override: true),
      );
      return;
    } else if (override) {
      await database.productDao.deleteAllByVendorWhereNot(
        product.vendorId,
      );
    }

    //save the vendor entity
    database.vendorDao.insertItem(vendor);
    //save the product entity
    database.productDao.insertItem(product);
    //delete all added product extras link to this product
    database.productExtraDao.deleteAllByProductId(product.id);
    //save the product options entity
    database.productExtraDao.insertItems(extras);

    //show success alert
    showAlert(
      title: ProductStrings.addedToCart,
      description: '${product.name} ${ProductStrings.addedToCartMessage}',
    );
  }

  //extras view
  List<Widget> buildProductExtrasWidgetList() {
    List<Widget> productExtrasWidget = [];

    //create food widget out of the vendors data available
    if (product.extras.length > 0) {
      product.extras.asMap().forEach(
        (index, productExtra) {
          //prepare the vendor widget
          final extraWidget = AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ProductExtraListViewItem(
                  productExtra: productExtra,
                  currency: vendor.currency,
                  onPressed: updateSelectedFoodExtras,
                ),
              ),
            ),
          );

          productExtrasWidget.add(extraWidget);
        },
      );
    } else {
      //return a text widget informating the user of no extra option
      productExtrasWidget.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.contentPaddingSize,
          ),
          child: Text(
            ProductStrings.emptyBody,
            style: AppTextStyle.h5TitleTextStyle(
              fontWeight: FontWeight.w400,
              color: viewContext.textTheme.bodyText1.color,
            ),
          ),
        ),
      );
    }

    return productExtrasWidget;
  }

  //
}
