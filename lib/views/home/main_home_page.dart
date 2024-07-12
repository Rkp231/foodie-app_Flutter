import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/home/categories.strings.dart';
import 'package:foodie/constants/strings/home/vendors.strings.dart';
import 'package:foodie/data/models/loading_state.dart';
import 'package:foodie/data/models/state_data_model.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/main_home.viewmodel.dart';
import 'package:foodie/views/base.page.dart';
import 'package:foodie/widgets/banner_slider.dart';
import 'package:foodie/widgets/listview/animated_vendor_list_view_item.dart';
import 'package:foodie/widgets/listview/category_list_view_item.dart';
import 'package:foodie/widgets/listview/small_vendor_item_view.dart';
import 'package:foodie/widgets/search/search_bar.dart';
import 'package:foodie/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:foodie/widgets/state/state_loading_data.dart';
import 'package:foodie/widgets/vendors/nearby_vendors.dart';
import 'package:stacked/stacked.dart';
import 'package:foodie/translations/home/home.i18n.dart';
class MainHomePage extends StatefulWidget {
  const MainHomePage({Key key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with AutomaticKeepAliveClientMixin<MainHomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<MainHomeViewModel>.reactive(
      viewModelBuilder: () => MainHomeViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => BasePage(
        body: CustomScrollView(
          slivers: [
            //
            SliverToBoxAdapter(
              child: UiSpacer.verticalSpace(),
            ),
            //search bar
            SliverAppBar(
              floating: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: AppColor.appBackground(context),
              title: SearchBar(
                onSearchBarPressed: model.openSearchPage,
                readOnly: true,
              ),
            ),

            //banners
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                  top: AppPaddings.contentPaddingSize,
                ),
                child: BannerSlider(
                  //search base on the category select from the banner
                  onBannerTapped: model.openCategorySearchPage,
                ),
              ),
            ),

            //category title
            _getSectionTitle(
              CategoriesStrings.name.i18n,
              context,
            ),
            //categories
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: 160,
                child: model.categoriesLoadingState == LoadingState.Loading
                    //the loadinng shimmer
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPaddings.contentPaddingSize,
                        ),
                        child: VendorShimmerListViewItem(),
                      )
                    // the faild view
                    : model.categoriesLoadingState == LoadingState.Failed
                        ? LoadingStateDataView(
                            stateDataModel: StateDataModel(
                              showActionButton: true,
                              actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                                color: Colors.red,
                              ),
                              actionFunction: model.getCategories,
                            ),
                          )
                        // the categories list
                        : ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: model.categories.length,
                            padding: AppPaddings.defaultPadding(),
                            separatorBuilder: (context, index) =>
                                UiSpacer.horizontalSpace(),
                            itemBuilder: (context, index) {
                              return CategoryListViewItem(
                                category: model.categories[index],
                                onPressed: model.openCategorySearchPage,
                              );
                            },
                          ),
              ),
            ),

            // Near you
            _getSectionTitle(
              VendorsStrings.nearYou.i18n,
              context,
            ),

            //near by horizontal list
            NearByVendors(
              model: model,
            ),

            //Popular
            SliverToBoxAdapter(
              child: Padding(
                padding: AppPaddings.defaultPadding(),
                child: Row(
                  children: [
                    //title
                    Expanded(
                      child: Text(
                        VendorsStrings.popular.i18n,
                        style: AppTextStyle.h3TitleTextStyle(
                          color: AppColor.textColor(context),
                        ),
                      ),
                    ),

                    //listing style
                    IconButton(
                      icon: Icon(
                        Icons.list,
                        color: AppColor.textColor(context),
                      ),
                      onPressed: () => model.changeListingStyle(1),
                    ),
                    //grind listing style
                    IconButton(
                      icon: Icon(
                        Icons.grid_view,
                        color: AppColor.textColor(context),
                      ),
                      onPressed: () => model.changeListingStyle(2),
                    ),
                  ],
                ),
              ),
            ),

            //Popular list
            SliverPadding(
              padding: AppPaddings.defaultPadding(),
              sliver: model.categoriesLoadingState == LoadingState.Loading
                  //the loadinng shimmer
                  ? SliverToBoxAdapter(
                      child: VendorShimmerListViewItem(),
                    )
                  // the faild view
                  : model.categoriesLoadingState == LoadingState.Failed
                      ? SliverToBoxAdapter(
                          child: LoadingStateDataView(
                            stateDataModel: StateDataModel(
                              showActionButton: true,
                              actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                                color: Colors.red,
                              ),
                              actionFunction: () => model.getPopularVendors,
                            ),
                          ),
                        )
                      // the vendors list
                      : model.listingStyle == 2
                          ?
                          //grid listing type
                          SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.67,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return AnimatedVendorListViewItem(
                                    index: index,
                                    vendor: model.popularVendors[index],
                                    listViewItem: SmallVendorListViewItem(
                                      vendor: model.popularVendors[index],
                                    ),
                                  );
                                },
                                childCount: model.popularVendors.length,
                              ),
                            )
                          :
                          //listing type
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return AnimatedVendorListViewItem(
                                    index: index,
                                    vendor: model.popularVendors[index],
                                  );
                                },
                                childCount: model.popularVendors.length,
                              ),
                            ),
            ),

            //
          ],
        ),
      ),
    );
  }

  Widget _getSectionTitle(String title, context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.contentPaddingSize,
        ),
        child: Text(
          title,
          style: AppTextStyle.h3TitleTextStyle(
            color: AppColor.textColor(context),
          ),
        ),
      ),
    );
  }
}
