import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';

class DeliveryAddress {
  int id;
  String name;
  bool isDefault;
  String type;
  String address;
  String latitude;
  String longitude;
  double distance = 0.00;

  DeliveryAddress({
    this.id,
    this.name,
    this.isDefault = false,
    this.type = "",
    this.address,
    this.latitude,
    this.longitude,
    this.distance = 0.00,
  });

  Icon icon(context) {
    return Icon(
      FlutterIcons.location_arrow_faw,
      size: 18,
      color: AppColor.textColor(context),
    );
  }

  factory DeliveryAddress.fromJSON({jsonObject}) {
    final deliveryAddress = DeliveryAddress();
    deliveryAddress.id = jsonObject["id"];
    deliveryAddress.name = jsonObject["name"] ?? "Location";
    deliveryAddress.isDefault = jsonObject["is_default"] ?? false;
    deliveryAddress.address = jsonObject["address"];
    deliveryAddress.latitude = jsonObject["latitude"];
    deliveryAddress.longitude = jsonObject["longitude"];
    if (jsonObject["distance"] != null) {
      deliveryAddress.distance = double.parse(jsonObject["distance"].toString());
    }
    return deliveryAddress;
  }
}
