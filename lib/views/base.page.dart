import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/constants/app_strings.dart';

class BasePage extends StatefulWidget {
  final bool showAppBar;
  final bool showLeadingAction;
  final String title;
  final Widget body;
  final Widget customAppbar;
  BasePage({
    this.showAppBar = false,
    this.showLeadingAction = false,
    this.title = "",
    this.body,
    this.customAppbar,
    Key key,
  }) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AuthBloc.prefs.getString(AppStrings.localeKey) == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: widget.customAppbar ?? widget.showAppBar
            ? AppBar(
                automaticallyImplyLeading: widget.showLeadingAction,
                leading: widget.showLeadingAction
                    ? IconButton(
                        icon: Icon(
                          FlutterIcons.arrow_left_fea,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    : null,
                title: Text(
                  widget.title,
                ),
              )
            : null,
        body: widget.body,
      ),
    );
  }
}
