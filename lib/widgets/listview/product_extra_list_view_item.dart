import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_sizes.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/data/models/currency.dart';
import 'package:foodie/data/models/food_extra.dart';
import 'package:foodie/utils/ui_spacer.dart';
import 'package:foodie/widgets/cornered_container.dart';

class ProductExtraListViewItem extends StatefulWidget {
  const ProductExtraListViewItem({
    Key key,
    @required this.productExtra,
    @required this.currency,
    this.onPressed,
  }) : super(key: key);

  final ProductExtra productExtra;
  final Currency currency;
  final Function(ProductExtra productExtra, bool selected) onPressed;

  @override
  _ProductExtraListViewItem createState() => _ProductExtraListViewItem();
}

class _ProductExtraListViewItem extends State<ProductExtraListViewItem> {
  //state of selected or not
  bool extraSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        //vertical: AppPaddings.contentPaddingSize,
        horizontal: AppPaddings.contentPaddingSize,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: AppPaddings.buttonPadding(),
        ),
        onPressed: () {
          setState(() {
            extraSelected = !extraSelected;
          });

          //update the bloc of this food extra state
          widget.onPressed(
            widget.productExtra,
            extraSelected,
          );
        },
        
        child: Row(
          
          children: <Widget>[
            CorneredContainer(
              height: AppSizes.productExtraImageHeight,
              width: AppSizes.productExtraImageWidth,
              child: Stack(
                children: <Widget>[
                  //food extra image
                  CachedNetworkImage(
                    imageUrl: widget.productExtra.photo,
                    placeholder: (context, url) => Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.error,
                      ),
                    ),
                    height: AppSizes.productExtraImageHeight,
                    width: AppSizes.productExtraImageWidth,
                    fit: BoxFit.cover,
                  ),

                  //selected icon/widget
                  extraSelected
                      ? Container(
                          height: AppSizes.productExtraImageHeight,
                          width: AppSizes.productExtraImageWidth,
                          color: AppColor.primaryColor.withOpacity(0.50),
                          child: Icon(
                            FlutterIcons.check_ant,
                            color: Colors.white,
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            UiSpacer.horizontalSpace(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: <Widget>[
                  Text(
                    widget.productExtra.name,
                    style: AppTextStyle.h4TitleTextStyle(
                      color: AppColor.textColor(context),
                    ),
                    
                  ),
                  Text(
                    "${widget.productExtra.name}",
                    style: AppTextStyle.h6TitleTextStyle(
                      color: AppColor.textColor(context),
                    ),
                    
                  ),
                ],
              ),
            ),
            UiSpacer.horizontalSpace(),
            //Extra price
            Text(
              "${widget.currency.symbol} ${widget.productExtra.price}",
              style: AppTextStyle.h3TitleTextStyle(
                color: AppColor.textColor(context),
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
