import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/category.dart';
import 'package:foodie/extension/color.dart';
import 'package:foodie/utils/ui_spacer.dart';

class CategoryListViewItem extends StatelessWidget {
  final Category category;
  final Function(Category) onPressed;
  const CategoryListViewItem({
    this.category,
    this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onPressed(this.category),
      highlightColor: Colors.transparent,
      splashColor: AppColor.accentColor.withOpacity(0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: AppPaddings.buttonPadding(),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: HexColor.fromHex(
                this.category.colour,
              ),
              borderRadius: AppSizes.containerBorderRadiusShape(radius: 5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(0, 1.0),
                  spreadRadius: 2.0,
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: this.category.photo,
              height: 30,
              width: 30,
            ),
          ),
          //
          UiSpacer.verticalSpace(space: 5),
          Text(
            this.category.name,
            style: AppTextStyle.h4TitleTextStyle(
              color: AppColor.textColor(context),
            ),
          ),
        ],
      ),
    );
  }
}
