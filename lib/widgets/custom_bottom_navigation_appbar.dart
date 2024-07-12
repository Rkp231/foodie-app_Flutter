import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/database/app_database_singleton.dart';
import 'package:foodie/data/models/product.dart';
import 'package:foodie/translations/home/home.i18n.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key key,
    @required this.currentPageIndex,
    @required this.onItemTap,
  }) : super(key: key);

  final int currentPageIndex;
  final Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 4,
      backgroundColor: AppColor.appBackground(context),
      currentIndex: currentPageIndex,
      onTap: onItemTap,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      selectedLabelStyle: AppTextStyle.h5TitleTextStyle(
        color: AppColor.bottomNavigationItemSelectedColor(
          context,
        ),
      ),
      unselectedLabelStyle: AppTextStyle.h5TitleTextStyle(
        color: AppColor.bottomNavigationItemUnselectedColor(
          context,
        ),
      ),
      selectedItemColor: AppColor.bottomNavigationItemSelectedColor(
        context,
      ),
      unselectedItemColor: AppColor.bottomNavigationItemUnselectedColor(
        context,
      ),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            FlutterIcons.home_ant,
            size: 20,
          ),
          label: "Home".i18n,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            AntDesign.inbox,
            size: 20,
          ),
          label: "Orders".i18n,
        ),
        BottomNavigationBarItem(
          //listen to stream on list of food in cart
          icon: StreamBuilder<List<Product>>(
            stream: AppDatabaseSingleton.database.productDao
                .findAllProductsAsStream(),
            builder: (context, snapshot) {
              return Badge(
                badgeContent: Text(
                  //if no item in cart, don't even bother showing the cart item count
                  snapshot.hasData ? "${snapshot.data.length}" : "0",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                badgeColor: AppColor.accentColor,
                //if no item in cart, don't even bother showing the badge
                showBadge: snapshot.hasData && snapshot.data.length > 0,
                position: BadgePosition.topEnd(top: -5, end: -5),
                child: Icon(
                  AntDesign.shoppingcart,
                ),
              );
            },
          ),
          label: "Cart".i18n,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FlutterIcons.user_ant,
            size: 20,
          ),
          label: "Profile".i18n,
        ),
      ],
    );
  }
}
