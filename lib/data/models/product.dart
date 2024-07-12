import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:foodie/data/models/currency.dart';
import 'package:foodie/data/models/food_extra.dart';
import 'package:foodie/data/models/vendor.dart';

@Entity(
  tableName: "products",
)
class Product {
  @primaryKey
  int id;
  int vendorId;
  String name;
  String photoUrl;
  double price;
  double discountPrice;
  double priceWithExtras;
  int selectedQuantity;
  String description;
  @ignore
  List<ProductExtra> extras;

  @ignore
  String extrasString;
  @ignore
  Currency currency;
  @ignore
  Vendor vendor;

  Product({
    this.id,
    this.vendorId,
    this.name,
    this.description,
    this.price,
    this.discountPrice,
    this.priceWithExtras,
    this.selectedQuantity,
    this.photoUrl,
    this.extras,
    this.extrasString,
  });

  factory Product.fromJSON({
    @required jsonObject,
    bool withExtras = true,
  }) {
    final food = Product();
    food.id = jsonObject["id"];
    food.name = jsonObject["name"];
    food.photoUrl = jsonObject["image"];
    food.description = jsonObject["description"];
    food.price = double.parse(
      jsonObject["price"].toString(),
    );

    if (jsonObject["discount_price"] != null) {
      food.discountPrice = double.parse(
        jsonObject["discount_price"].toString(),
      );
    }

    if (withExtras) {
      //load extras
      final extrasJSONArray = (jsonObject["extras"] as List);
      food.extras = extrasJSONArray.map(
        (extraSONObject) {
          final foodExtra = ProductExtra.fromJSON(
            jsonObject: extraSONObject,
          );
          foodExtra.productId = food.id;
          return foodExtra;
        },
      ).toList();
    }
    return food;
  }

  double get totalPriceWithExtra {
    return this.selectedQuantity * this.priceWithExtras;
  }

  get hasDiscount {
    return this.discountPrice != null && this.discountPrice > 0;
  }
}
