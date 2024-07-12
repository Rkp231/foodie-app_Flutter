import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/user.dart';
import 'package:foodie/widgets/menu/menu_item.dart';
import 'package:foodie/widgets/profile/user_profile_photo.dart';
import 'package:foodie/widgets/state/unauthenticated.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/home/profile.i18n.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    Key key,
    @required this.user,
    this.processLogout,
  }) : super(key: key);

  final User user;
  final Function processLogout;

  @override
  Widget build(BuildContext context) {
    return user == null
        ? UnauthenticatedPage()
        : VStack(
            [
              //
              HStack(
                [
                  //user profile photo
                  UserProfilePhoto(
                    userProfileImageUrl: user != null ? user.photo : "",
                  ),

                  //
                  VStack(
                    [
                      Text(
                        user != null ? user.name : "",
                        style: AppTextStyle.h3TitleTextStyle(
                          color: Colors.white,
                        ),
                      ),
                      //user email/phone
                      Text(
                        user != null ? user.email : "",
                        style: AppTextStyle.h5TitleTextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ).px12().expand(),
                ],
              )
                  .p12()
                  .box
                  .roundedSM
                  .color(AppColor.primaryColor)
                  .make()
                  .wFull(context),

              //
              //options
              // My Details menu item
              MenuItem(
                iconData: FlutterIcons.user_ant,
                title: "Update Details".i18n,
                onPressed: () {
                  // Edit profile
                  Navigator.pushNamed(
                    context,
                    AppRoutes.editProfileRoute,
                  );
                },
              ),
              Divider(
                height: 1,
              ),

              // Chnage password menu item
              MenuItem(
                iconData: FlutterIcons.lock_ant,
                title: "Change Password".i18n,
                onPressed: () {
                  // Edit profile
                  Navigator.pushNamed(
                    context,
                    AppRoutes.changePasswordRoute,
                  );
                },
              ),
              Divider(
                height: 1,
              ),

              //Wallet menu item
              MenuItem(
                iconData: SimpleLineIcons.wallet,
                title: "Wallet".i18n,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.walletRoute,
                  );
                },
              ),
              Divider(
                height: 1,
              ),

              //Delivery Addresses menu item
              MenuItem(
                iconData: SimpleLineIcons.location_pin,
                title: "Delivery Addresses".i18n,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.deliveryAddressesRoute,
                  );
                },
              ),
              Divider(
                height: 1,
              ),
              MenuItem(
                iconData: AntDesign.logout,
                title: "Logout".i18n,
                onPressed: processLogout,
              ),
            ],
          ).box.roundedSM.outerShadow.color(context.cardColor).make();
  }
}
