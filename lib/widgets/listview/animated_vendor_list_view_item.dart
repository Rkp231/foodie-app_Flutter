import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/widgets/listview/vendor_item_view.dart';

class AnimatedVendorListViewItem extends StatelessWidget {
  final int index;
  final Vendor vendor;
  final Widget listViewItem;
  const AnimatedVendorListViewItem(
      {this.index, this.vendor, this.listViewItem, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 100),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: listViewItem ??
              VendorListViewItem(
                vendor: vendor,
              ),
        ),
      ),
    );
  }
}
