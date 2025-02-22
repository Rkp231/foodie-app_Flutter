import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:foodie/views/base.page.dart';
import 'package:foodie/widgets/menu/menu_item.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodie/translations/home/profile.i18n.dart';

class AppLanguageSelector extends StatelessWidget {
  const AppLanguageSelector({this.onSelected, Key key}) : super(key: key);

  //
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BasePage(
        body: VStack(
          [
            //
            "Select your preferred language".i18n
                .text.color(context.textTheme.bodyText1.color)
                .xl
                .semiBold
                .make()
                .py20(),

            //Arabic
            MenuItem(
              title: "Arabic",
              suffix: Flag('AE', height: 24, width: 24),
              onPressed: () => onSelected('ar'),
            ),
            //English
            MenuItem(
              title: "English",
              suffix: Flag('US', height: 24, width: 24),
              onPressed: () => onSelected('en'),
            ),
            //French
            MenuItem(
              title: "French",
              suffix: Flag('FR', height: 24, width: 24),
              onPressed: () => onSelected('fr'),
            ),
            //Spanish
            MenuItem(
              title: "Spanish",
              suffix: Flag('ES', height: 24, width: 24),
              onPressed: () => onSelected('es'),
            ),
            //German
            MenuItem(
              title: "German",
              suffix: Flag('DE', height: 24, width: 24),
              onPressed: () => onSelected('de'),
            ),
            //Portuguese
            MenuItem(
              title: "Portuguese",
              suffix: Flag('PT', height: 24, width: 24),
              onPressed: () => onSelected('pt'),
            ),
            //Korean
            MenuItem(
              title: "Korean",
              suffix: Flag('KR', height: 24, width: 24),
              onPressed: () => onSelected('ko'),
            ),

            //ADD YOUR CUSTOM LANGUAGE HERE
            // MenuItem(
            //   title: "LANGUAGE_NAME",
            //   suffix: Flag('COUNRTY_CODE', height: 24, width: 24),
            //   onPressed: () => onSelected('LANGUAGE_CODE'),
            // ),
          ],
        ).p20().scrollVertical(),
      ),
    ).box.color(context.backgroundColor).make();
  }
}
