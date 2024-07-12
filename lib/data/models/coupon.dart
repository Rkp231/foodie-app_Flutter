class Coupon {
  int id;
  String code;
  double discount;
  bool isPercentage;
  String description;
  List<int> productsIds = [];
  List<int> vendorsIds = [];

  Coupon({
    this.id,
    this.code,
    this.discount,
    this.isPercentage,
    this.description,
    this.productsIds,
    this.vendorsIds,
  });

  factory Coupon.fromJSONObject(Map<String, dynamic> jsonObejct) {
    final coupon = new Coupon();
    coupon.id = jsonObejct["id"];
    coupon.code = jsonObejct["code"];
    coupon.discount = double.parse(jsonObejct["discount"].toString());
    coupon.isPercentage = jsonObejct["is_percentage"];
    coupon.description = jsonObejct["description"];
    //fetch products for the coupon
    coupon.productsIds = [];
    for (var product in (jsonObejct["products_ids"] as List)) {
      coupon.productsIds.add(product["id"]);
    }
    //fetch vendors for the coupon
    coupon.vendorsIds = [];
    for (var vendor in (jsonObejct["vendors_ids"] as List)) {
      coupon.vendorsIds.add(vendor["id"]);
    }
    return coupon;
  }
}
