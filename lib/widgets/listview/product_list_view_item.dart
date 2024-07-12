import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/page_arguments.dart';
import 'package:foodie/data/models/product.dart';
import 'package:foodie/data/models/vendor.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/widgets/cornered_container.dart';

class ProductListViewItem extends StatelessWidget {
  ProductListViewItem({
    Key key,
    this.product,
    @required this.vendor,
  }) : super(key: key);

  final Product product;
  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: AppPaddings.buttonPadding(),
        primary: AppColor.listItemBackground(context),
        elevation: 0,
      ),
      onPressed: () {
        //open product page
        Navigator.pushNamed(
          context,
          AppRoutes.productRoute,
          arguments: PageArguments(
            product: product,
            vendor: vendor,
          ),
        );
      },
      child: Row(
        
        children: <Widget>[
          //product image
          //if no food image was supplied, a shrink SizedBox will be added
          if (product.photoUrl.isNotEmpty)
            Hero(
              tag: product.id,
              child: CorneredContainer(
                child: CachedNetworkImage(
                  imageUrl: product.photoUrl,
                  placeholder: (context, url) => Container(
                    height: AppSizes.productImageHeight,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: AppSizes.productImageHeight,
                  width: AppSizes.productImageWidth,
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            SizedBox.shrink(),
          UiSpacer.horizontalSpace(),
          //food info
          Expanded(
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name,
                  style: AppTextStyle.h4TitleTextStyle(
                    color: AppColor.textColor(context),
                  ),
                  
                ),
                Row(
                  children: [
                    Text(
                      "${vendor.currency.symbol} ${product.price}",
                      style: AppTextStyle.h4TitleTextStyle(
                        color: AppColor.textColor(context),
                        fontWeight:
                            product.hasDiscount ? FontWeight.w200 : null,
                        decoration: product.hasDiscount
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                      
                    ),
                    UiSpacer.horizontalSpace(space: 10),
                    product.hasDiscount
                        ? Text(
                            "${vendor.currency.symbol} ${product.discountPrice}",
                            style: AppTextStyle.h4TitleTextStyle(
                              color: AppColor.textColor(context),
                            ),
                            
                          )
                        : UiSpacer.horizontalSpace(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
