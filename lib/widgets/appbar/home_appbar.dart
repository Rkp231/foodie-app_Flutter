import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/bloc/vendors.bloc.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/data/models/deliver_address.dart';
import 'package:foodie/utils/custom_dialog.dart';
import 'package:foodie/widgets/deliver_to_bottom_sheet_content.dart';
import 'package:foodie/widgets/search/search_bar.dart';
import 'package:foodie/widgets/vendor_filter.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key key,
    this.backgroundColor,
    this.vendorsBloc,
  }) : super(key: key);

  final Color backgroundColor;
  final VendorsBloc vendorsBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.secondCustomAppBarHeight,
      padding: AppPaddings.defaultPadding(),
      child: Row(
        
        children: <Widget>[
          //search bar
          Expanded(
            flex: 8,
            child: SearchBar(
              onSearchBarPressed: () => _openSearchPage(context),
              readOnly: true,
            ),
          ),

          SizedBox(
            width: 10,
          ),
          //Delivery location
          Expanded(
            child: TextButton(
              onPressed: () => _changeDeliveryAddress(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0),
              ),
              child: Icon(
                FlutterIcons.location_arrow_faw,
                size: 16,
                color: AppColor.iconHintColor,
              ),
            ),
          ),
          //filter action
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0),
              ),
              onPressed: () => _openFilterResults(context),
              child: Icon(
                FlutterIcons.sound_mix_ent,
                size: 16,
                color: AppColor.iconHintColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //ui actions
  void _openSearchPage(context) {
    //navigate to search vendors page
    Navigator.pushNamed(
      context,
      AppRoutes.searchVendorsPage,
    );
  }

  void _openFilterResults(context) {
    //show bottomsheet with vendor filter container
    CustomDialog.showCustomBottomSheet(
      context,
      contentPadding: EdgeInsets.all(20),
      content: VendorFilter(
        vendorsBloc: this.vendorsBloc,
      ),
    );
  }

  void _changeDeliveryAddress(context) {
    //show bottomsheet with delivery addresses container
    CustomDialog.showCustomBottomSheet(
      context,
      contentPadding: EdgeInsets.all(20),
      content: DeliverTo(
        onSubmit: (DeliveryAddress selectedDeliveryAddres) {
          print("Selected Delivery ==> ${selectedDeliveryAddres.address}");
        },
      ),
    );
  }
}
