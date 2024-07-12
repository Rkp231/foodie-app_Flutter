import 'package:flutter/material.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/utils/router.dart' as router;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foodie/views/auth/onboarding_page.dart';
import 'package:foodie/views/home_page.dart';
import 'package:i18n_extension/i18n_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({this.startRoute, Key key}) : super(key: key);

  final String startRoute;
  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      onGenerateRoute: router.generateRoute,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('fr'),
        const Locale('es'),
        const Locale('de'),
        const Locale('pt'),
        const Locale('ar'),
        const Locale('ko'),
      ],
      home: I18n(
        child:
            startRoute == AppRoutes.homeRoute ? HomePage() : OnboardingPage(),
        initialLocale: Locale(
          AuthBloc.prefs.getString(AppStrings.localeKey) ?? "en",
        ),
      ),
      theme: ThemeData(
        backgroundColor: Colors.white,
        accentColor: AppColor.accentColor,
        primaryColor: AppColor.primaryColor,
        primaryColorDark: AppColor.primaryColorDark,
        cardColor: Colors.grey[100],
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.cursorColor,
        ),
        textTheme: TextTheme(
          headline3: TextStyle(
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        backgroundColor: Colors.grey[700],
        accentColor: AppColor.accentColor,
        primaryColor: AppColor.primaryColor,
        primaryColorDark: AppColor.primaryColorDark,
        cardColor: Colors.grey[600],
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.cursorColor,
        ),
        textTheme: TextTheme(
          headline3: TextStyle(
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
