import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/viewmodels/profile.viewmodel.dart';
import 'package:foodie/widgets/menu/menu_item.dart';
import 'package:foodie/widgets/profile/user_profile_card.dart';
import 'package:foodie/widgets/state/busy_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/home/profile.i18n.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return VStack(
          [
            //profile
            vm.isBusy
                ? BusyIndicator()
                : UserProfileCard(
                    user: vm.user,
                    processLogout: vm.processLogout,
                  ).wFull(context),

            //others menus
            VStack(
              [
                // Notifications menu item
                MenuItem(
                  iconData: FlutterIcons.bells_ant,
                  title: "Notifications".i18n,
                  onPressed: () {
                    // Edit profile
                    Navigator.pushNamed(
                      context,
                      AppRoutes.notificationsRoute,
                    );
                  },
                ),
                Divider(
                  height: 1,
                ),

                // Chat and faq menu item
                MenuItem(
                  iconData: FlutterIcons.chat_bubble_outline_mdi,
                  title: "FAQ's & Support".i18n,
                  onPressed: null,
                ),
                Divider(
                  height: 1,
                ),
                // language
                MenuItem(
                  iconData: FlutterIcons.language_ent,
                  title: "Language".i18n,
                  onPressed: vm.changeLanguage,
                ),
                Divider(
                  height: 1,
                ),
              ],
            ).box.roundedSM.outerShadow.color(context.cardColor).make().py12(),
          ],
        ).p20().scrollVertical();
      },
    );
  }
}
