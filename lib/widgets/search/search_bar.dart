import 'package:flutter/material.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/constants/app_text_styles.dart';
import 'package:foodie/widgets/inputs/custom_text_form_field.dart';
import 'package:foodie/translations/home/home.i18n.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required this.onSearchBarPressed,
    this.onSubmit,
    this.readOnly = false,
    this.focusNode,
  }) : super(key: key);

  final Function onSearchBarPressed;
  final Function onSubmit;
  final bool readOnly;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    //
    //
    return CustomTextFormField(
      isReadOnly: readOnly,
      focusNode: this.focusNode,
      hintText: "Search on ".i18n + "${AppStrings.appName}",
      fillColor: AppColor.textFieldBackground(context),
      hintTextStyle: AppTextStyle.h5TitleTextStyle(
        color: AppColor.hintTextColor(context),
      ),
      prefixWidget: Icon(
        Icons.search,
        color: Colors.grey[500],
      ),
      onTap: this.onSearchBarPressed,
      onFieldSubmitted: this.onSubmit,
    );
  }
}
