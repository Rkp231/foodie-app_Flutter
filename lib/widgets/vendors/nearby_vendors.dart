import 'package:flutter/material.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/constants/strings/home/vendors.strings.dart';
import 'package:foodie/data/models/state_data_model.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/viewmodels/main_home.viewmodel.dart';
import 'package:foodie/widgets/listview/animated_vendor_list_view_item.dart';
import 'package:foodie/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:foodie/widgets/state/state_loading_data.dart';
import 'package:foodie/widgets/vendors/widget/no_location_permission.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/home/home.i18n.dart';

class NearByVendors extends StatelessWidget {
  final MainHomeViewModel model;
  const NearByVendors({
    this.model,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      //check if location is avalilable
      child: model.isLocationAvailable
          ? Container(
              width: double.infinity,
              height: model.busy(model.nearbyVendors)
                  ? 180
                  : model.hasErrorForKey(model.nearbyVendors)
                      ? 250
                      : 350,
              child: model.busy(model.nearbyVendors)
                  //the loadinng shimmer
                  ? Padding(
                      padding: AppPaddings.defaultPadding(),
                      child: VendorShimmerListViewItem(),
                    )
                  // the faild view
                  : model.hasErrorForKey(model.nearbyVendors)
                      ? LoadingStateDataView(
                          stateDataModel: StateDataModel(
                            showActionButton: true,
                            actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                              color: Colors.red,
                            ),
                            actionFunction: () => model.getNearbyVendors(),
                          ),
                        )
                      // the vendors list
                      : model.nearbyVendors.length > 0
                          ? ListView.separated(
                              padding: AppPaddings.defaultPadding(),
                              separatorBuilder: (context, index) =>
                                  UiSpacer.horizontalSpace(),
                              scrollDirection: Axis.horizontal,
                              itemCount: model.nearbyVendors.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.80,
                                  // width: double.infinity,
                                  child: AnimatedVendorListViewItem(
                                    index: index,
                                    vendor: model.nearbyVendors[index],
                                  ),
                                );
                              },
                            )
                          : LoadingStateDataView(
                              stateDataModel: StateDataModel(
                                title: VendorsStrings.noNearbyVendorsTitle.i18n,
                                titleStyle: AppTextStyle.h3TitleTextStyle(
                                  color: context.textTheme.bodyText1.color
                                ),
                                description:
                                    VendorsStrings.noNearbyVendorsDescription.i18n,
                                descriptionStyle:
                                    AppTextStyle.h5TitleTextStyle(
                                      color: context.textTheme.bodyText1.color
                                    ),
                                showActionButton: false,
                                imageAssetPath: AppImages.ic_location,
                              ),
                            ),
            )
          : NoLocationPermission(model: model),
    );
  }
}
