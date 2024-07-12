import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/data/database/app_database_singleton.dart';
import 'package:foodie/my_app.dart';
import 'package:foodie/services/firebase_messaging.dart';
import 'package:i18n_extension/i18n_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //
  await Firebase.initializeApp();
  //Initialize App Database
  await AppDatabaseSingleton().prepareDatabase();
  //start notification listening
  AppNotification.setUpFirebaseMessaging();

  //initiating tellam

  //clear user records if any
  // await AppDatabaseSingleton.database.userDao.deleteAll();
  // await AppDatabaseSingleton.database.productDao.deleteAll();
  // await AppDatabaseSingleton.database.productExtraDao.deleteAll();

  // Set default home.
  String startRoute = AppRoutes.welcomeRoute;

  //check if user has signin before
  await AuthBloc.getPrefs();

  if (AuthBloc.firstTimeOnApp()) {
    AuthBloc.prefs.setBool(AppStrings.firstTimeOnApp, false);
  } else {
    startRoute = AppRoutes.homeRoute;
  }

  // Run app!
  runApp(
    I18n(
      child: MyApp(
        startRoute: startRoute,
      ),
      initialLocale: Locale(
        AuthBloc.prefs.getString(AppStrings.localeKey) ?? "en",
      ),
    ),
  );
}
