import 'package:flutter/material.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/vendor.strings.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/vendor_page.viewmodel.dart';
import 'package:foodie/views/base.page.dart';
import 'package:foodie/widgets/appbar/persistent_header.dart';
import 'package:foodie/widgets/appbar/vendor_page.appbar.dart';
import 'package:foodie/widgets/buttons/floating_cart_button.dart';
import 'package:foodie/widgets/headers/vendor_page_header.dart';
import 'package:foodie/widgets/shimmers/general_shimmer_list_view_item.dart';
import 'package:foodie/widgets/vendor_menu_tab_bar_view.dart';
import 'package:stacked/stacked.dart';
import 'package:foodie/translations/home/home.i18n.dart';

class VendorPage extends StatefulWidget {
  VendorPage({
    Key key,
    this.vendor,
  }) : super(key: key);

  final Vendor vendor;

  @override
  _VendorPageState createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: ViewModelBuilder<VendorPageViewModel>.reactive(
        viewModelBuilder: () => VendorPageViewModel(widget.vendor),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return DefaultTabController(
            length: model.isBusy ? 0 : model.menus.length,
            child: Scaffold(
              backgroundColor: AppColor.appBackground(context),
              appBar: PreferredSize(
                preferredSize: Size(double.infinity,
                    model.makeAppBarTransparent ? kToolbarHeight : 80),
                child: VendorPageAppBar(
                  model: model,
                ),
              ),
              extendBodyBehindAppBar: true,
              body: Stack(
                children: [
                  // body
                  Container(
                    padding: EdgeInsets.all(0),
                    color: AppColor.appBackground(context),
                    child: NestedScrollView(
                      controller: model.vendorPageStrollController,
                      headerSliverBuilder: (context, value) {
                        return [
                          //vendor information header
                          VendorPageHeader(
                            vendor: model.vendor,
                          ),

                          SliverPersistentHeader(
                            pinned: true,
                            floating: true,
                            delegate: PersistentHeader(
                              widget: Container(
                                width: double.infinity,
                                height: 100,
                                color: AppColor.appBackground(context),
                                child: Text(
                                  VendorStrings.menu.i18n,
                                  style: AppTextStyle.h3TitleTextStyle(
                                    color: AppColor.textColor(context),
                                  ),
                                  textAlign: TextAlign.center,
                                 
                                ),
                              ),
                            ),
                          ),

                          // vendor menu types appbar with tabs
                          SliverPersistentHeader(
                            pinned: false,
                            floating: false,
                            delegate: PersistentHeader(
                              widget: Container(
                                width: double.infinity,
                                height: 100,
                                color: AppColor.appBackground(context),
                                child:
                                    model.isBusy || !model.makeAppBarTransparent
                                        ? UiSpacer.horizontalSpace()
                                        : TabBar(
                                            labelColor: AppColor.primaryColor,
                                            unselectedLabelColor:
                                                AppColor.hintTextColor(context),
                                            isScrollable: true,
                                            indicatorWeight: 3.0,
                                            indicatorPadding: EdgeInsets.all(0),
                                            labelStyle:
                                                AppTextStyle.h4TitleTextStyle(),
                                            unselectedLabelStyle:
                                                AppTextStyle.h5TitleTextStyle(),
                                            tabs: model.menus.map(
                                              (menu) {
                                                return Tab(
                                                  text: menu.name,
                                                );
                                              },
                                            ).toList(),
                                          ),
                              ),
                            ),
                          ),
                        ];
                      },
                      body: model.isBusy
                          ? GeneralShimmerListViewItem()
                          : TabBarView(
                              children: model.menus.map(
                                (menu) {
                                  return VendorMenuTabBarView(
                                    menu: menu,
                                    vendor: model.vendor,
                                  );
                                },
                              ).toList(),
                            ),
                    ),
                  ),

                  // floating cart button
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.20,
                    right: AuthBloc.prefs.getString(AppStrings.localeKey) != "ar"
                      ? AppPaddings.contentPaddingSize
                      : null,
                  left: AuthBloc.prefs.getString(AppStrings.localeKey) == "ar"
                      ? AppPaddings.contentPaddingSize
                      : null,
                    child: FloatingCartButton(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
