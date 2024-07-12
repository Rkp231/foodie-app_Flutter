import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/category.dart';

class GridCategoryItemView extends StatelessWidget {
  const GridCategoryItemView({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: AppPaddings.defaultPadding(),
        primary: AppColor.listItemBackground(context),
      ),
      onPressed: () {
        //show all vendors associatee with selected category
        Navigator.pushNamed(
          context,
          AppRoutes.categoryVendorsRoute,
          arguments: category,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //image
          CachedNetworkImage(
            imageUrl: category.photo ?? "",
            height: AppSizes.categoryImageHeight,
            width: AppSizes.categoryImageWidth,
          ),
          //name
          Text(
            category.name,
            style: AppTextStyle.h4TitleTextStyle(
              color: AppColor.textColor(context),
            ),
            textAlign: TextAlign.center,
            
          ),
        ],
      ),
    );
  }
}
