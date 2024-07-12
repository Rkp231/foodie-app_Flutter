import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/general.strings.dart';
import 'package:foodie/constants/strings/search.strings.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/search.viewmodel.dart';
import 'package:foodie/views/base.page.dart';
import 'package:foodie/widgets/appbar/empty_appbar.dart';
import 'package:foodie/widgets/buttons/custom_button.dart';
import 'package:foodie/widgets/listview/product_list_view_item.dart';
import 'package:foodie/widgets/state/busy_indicator.dart';
import 'package:foodie/widgets/vendors/grouped_vendors_listview.dart';
import 'package:foodie/widgets/search/search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/general.i18n.dart';

class SearchVendorsPage extends StatelessWidget {
  SearchVendorsPage({this.categoryId, Key key}) : super(key: key);

  final int categoryId;

  @override
  Widget build(
    BuildContext context,
  ) {
    return BasePage(
      body: ViewModelBuilder<SearchViewModel>.reactive(
        viewModelBuilder: () => SearchViewModel(context, categoryId),
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: AppColor.appBackground(context),
            appBar: EmptyAppBar(
              backgroundColor: AppColor.appBackground(context),
              brightness: MediaQuery.of(context).platformBrightness,
            ),
            body: Container(
              child: Stack(
                children: <Widget>[
                  //vendors
                  Positioned(
                    //if you are using CustomAppbar
                    //use this AppSizes.customAppBarHeight
                    //or this AppSizes.secondCustomAppBarHeight, if you are using the second custom appbar
                    top: AppSizes.secondCustomAppBarHeight,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: VStack(
                      [
                        //
                        "${GeneralStrings.result}(${vm.vendors.length})"
                            .text
                            .xl2
                            .medium
                            .make()
                            .pOnly(
                                bottom: Vx.dp24,
                                top: context.percentHeight * 13),
                        //loading
                        vm.isBusy
                            ? BusyIndicator().centered()
                            : UiSpacer.empty(),

                        //products
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            //
                            final product = vm.products[index];
                            final vendor = Vendor();
                            vendor.currency = product.currency;
                            return ProductListViewItem(
                              vendor: vendor,
                              product: product,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              UiSpacer.verticalSpace(),
                          itemCount: vm.products.length,
                        ),
                        //vendors
                        GroupedVendorsListView(
                          titleTextStyle: AppTextStyle.h3TitleTextStyle(
                            color: AppColor.textColor(context),
                          ),
                          vendors: vm.vendors,
                        ),

                        //
                      ],
                    ).px20().scrollVertical(),
                  ),

                  //filter and search header/bar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    //normal
                    child: Container(
                      // height: AppSizes.secondCustomAppBarHeight,
                      padding: AppPaddings.defaultPadding(),
                      color: AppColor.appBackground(context),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          //top view
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  SearchStrings.title.i18n,
                                  style: AppTextStyle.h2TitleTextStyle(
                                    color: AppColor.textColor(context),
                                  ),
                                ),
                              ),

                              //close button
                              CustomButton(
                                color: context.cardColor,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: context.textTheme.bodyText1.color,
                                ),
                              ),
                            ],
                          ),

                          UiSpacer.verticalSpace(),
                          SearchBar(
                            onSearchBarPressed: null,
                            onSubmit: vm.initSearch,
                          ),
                          //
                          HStack(
                            [
                              //product
                              HStack(
                                [
                                  Checkbox(
                                    value: vm.loadProduct,
                                    onChanged: vm.toggleLoadProduct,
                                  ),
                                  //
                                  "Product".text.make(),
                                ],
                              )
                                  .onInkTap(() =>
                                      vm.toggleLoadProduct(!vm.loadProduct))
                                  .expand(),
                              //vendor
                              HStack(
                                [
                                  Checkbox(
                                    value: vm.loadVendor,
                                    onChanged: vm.toggleLoadVendor,
                                  ),
                                  //
                                  "Vendor".text.make(),
                                ],
                              )
                                  .onInkTap(
                                      () => vm.toggleLoadVendor(!vm.loadVendor))
                                  .expand(),
                            ],
                          )
                        ],
                      ),
                    ),
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
