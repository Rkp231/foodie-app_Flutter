import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_paddings.dart';
import 'package:foodie/constants/app_text_styles.dart';

class MenuItem extends StatefulWidget {
  MenuItem({
    Key key,
    this.iconData,
    this.suffix,
    this.title,
    this.onPressed,
  }) : super(key: key);

  final Function onPressed;
  final IconData iconData;
  final Widget suffix;
  final String title;
  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
      ),
      onPressed: widget.onPressed,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          0,
          AppPaddings.contentPaddingSize,
          0,
          AppPaddings.contentPaddingSize,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child:  widget.suffix ?? Icon(
                widget.iconData,
                color: AppColor.textColor(context),
                size: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: Text(
                widget.title,
                style: AppTextStyle.h5TitleTextStyle(
                  color: AppColor.textColor(context),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Icon(
                SimpleLineIcons.arrow_right,
                size: 18,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
