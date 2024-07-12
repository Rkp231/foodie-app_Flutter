import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/bloc/home.bloc.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/database/app_database_singleton.dart';
import 'package:foodie/data/models/product.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';

class FloatingCartButton extends StatefulWidget {
  FloatingCartButton({Key key}) : super(key: key);

  @override
  _FloatingCartButtonState createState() => _FloatingCartButtonState();
}

class _FloatingCartButtonState extends State<FloatingCartButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 65,
      height: 65,
      child: CustomButton(
        elevation: 10,
        color: AppColor.primaryColor,
        child: StreamBuilder<List<Product>>(
          stream: AppDatabaseSingleton.database.productDao
              .findAllProductsAsStream(),
          builder: (context, snapshot) {
            return Badge(
              badgeContent: Text(
                //if no item in cart, don't even bother showing the cart item count
                snapshot.hasData ? "${snapshot.data.length}" : "0",
                style: AppTextStyle.h5TitleTextStyle(
                  color: Colors.black,
                ),
              ),
              badgeColor: Colors.white,
              //if no item in cart, don't even bother showing the badge
              showBadge: snapshot.hasData && snapshot.data.length > 0,
              // position: BadgePosition.topRight(top: -10, right: -10),
              position: BadgePosition.bottomEnd(bottom: -10, end: -5),
              child: Icon(
                AntDesign.shoppingcart,
                color: Colors.white,
              ),
            );
          },
        ),
        onPressed: () {
          //tell the home bloc to switch to cart page
          HomeBloc.switchPageToCart();
          //then close all pages until the last page, which is the home page
          Navigator.popUntil(
            context,
            (route) {
              if (route.settings.name == AppRoutes.homeRoute ||
                  route.settings.name == "/") {
                try {
                  (route.settings.arguments as Map)['index'] = 2;
                } catch (error) {
                  print("Poopuntil Error ==> $error");
                }
                return true;
              } else {
                return false;
              }
            },
          );
        },
      ),
    );
  }
}
