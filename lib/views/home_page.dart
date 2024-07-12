import 'package:flutter/material.dart';
import 'package:foodie/bloc/auth.bloc.dart';
import 'package:foodie/bloc/home.bloc.dart';
import 'package:foodie/constants/app_color.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/views/cart_page.dart';
import 'package:foodie/views/home/main_home_page.dart';
import 'package:foodie/views/orders_page.dart';
import 'package:foodie/views/profile/profile_page.dart';
import 'package:foodie/widgets/appbar/empty_appbar.dart';
import 'package:foodie/widgets/custom_bottom_navigation_appbar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //current bottom navigation bar index
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    //switch page from bloc, this allow another page/bloc to determine the page for the home page
    HomeBloc.initiBloc();
    HomeBloc.currentPageIndex.listen((currentPageIndex) {
      _updateCurrentPageIndex(currentPageIndex);
    });
  }

  @override
  void dispose() {
    super.dispose();
    HomeBloc.closeListener();
  }

  @override
  Widget build(BuildContext context) {
    //

    return Directionality(
      textDirection: AuthBloc.prefs.getString(AppStrings.localeKey) == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.appBackground(context),
        appBar: EmptyAppBar(
          backgroundColor: AppColor.appBackground(context),
          brightness: MediaQuery.of(context).platformBrightness,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentPageIndex: currentPageIndex,
          onItemTap: _updateCurrentPageIndex,
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            //for normal vendors listing
            // VendorsPage(),
            //for switching between vendors and items listing
            // VendorsOrItemsPage(),
            //grid card/elevated categories card listing
            // GridCategoriesPage(),
            //new home page
            MainHomePage(),
            OrdersPage(),
            CartPage(),
            ProfilePage(),
          ],
          onPageChanged: _updateCurrentPageIndex,
        ),
      ),
    );
  }

  //update the current page index
  void _updateCurrentPageIndex(int pageIndex) {
    setState(() {
      currentPageIndex = pageIndex;
    });
    _pageController.animateToPage(
      pageIndex,
      curve: Curves.ease,
      duration: Duration(
        microseconds: 10,
      ),
    );
  }
}
