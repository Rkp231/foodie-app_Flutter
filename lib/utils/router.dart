import 'package:flutter/material.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/data/models/page_arguments.dart';
import 'package:foodie/views/auth/forgot_password_page.dart';
import 'package:foodie/views/auth/login_page.dart';
import 'package:foodie/views/auth/onboarding_page.dart';
import 'package:foodie/views/auth/otp/otp_login.page.dart';
import 'package:foodie/views/auth/register_page.dart';
import 'package:foodie/views/category_vendors_page.dart';
import 'package:foodie/views/chat_page.dart';
import 'package:foodie/views/checkout_page.dart';
import 'package:foodie/views/delivery_address/delivery_addresses_page.dart';
import 'package:foodie/views/delivery_address/edit_delivery_address_page.dart';
import 'package:foodie/views/delivery_address/new_delivery_address_page.dart';
import 'package:foodie/views/home_page.dart';
import 'package:foodie/views/product_page.dart';
import 'package:foodie/views/profile/change_password_page.dart';
import 'package:foodie/views/profile/edit_profile_page.dart';
import 'package:foodie/views/profile/notifications_page.dart';
import 'package:foodie/views/search_vendors_page.dart';
import 'package:foodie/views/track_order_page.dart';
import 'package:foodie/views/vendor_page.dart';
import 'package:foodie/views/wallet/wallet.page.dart';
import 'package:foodie/views/webview.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.welcomeRoute:
      return MaterialPageRoute(builder: (context) => OnboardingPage());

    case AppRoutes.loginOTPRoute:
      return MaterialPageRoute(builder: (context) => OTPLoginpage());

    case AppRoutes.loginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());

    case AppRoutes.registerRoute:
      return MaterialPageRoute(builder: (context) => RegisterPage());

    case AppRoutes.forgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPasswordPage());

    case AppRoutes.homeRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.homeRoute, arguments: Map()),
        builder: (context) => HomePage(),
      );

    case AppRoutes.searchVendorsPage:
      return MaterialPageRoute(builder: (context) => SearchVendorsPage());

    case AppRoutes.productRoute:
      final PageArguments pageArguments = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => ProductPage(
          product: pageArguments.product,
          vendor: pageArguments.vendor,
        ),
      );

    case AppRoutes.vendorRoute:
      return MaterialPageRoute(
        builder: (context) => VendorPage(
          vendor: settings.arguments,
        ),
      );

    case AppRoutes.categoryVendorsRoute:
      return MaterialPageRoute(
        builder: (context) => CategoryVendorsPage(
          category: settings.arguments,
        ),
      );

    case AppRoutes.newDeliveryAddressRoute:
      return MaterialPageRoute(builder: (context) => NewDeliveryAddressPage());

    case AppRoutes.editDeliveryAddressRoute:
      return MaterialPageRoute(
        builder: (context) => EditDeliveryAddressPage(
          deliveryAddress: settings.arguments,
        ),
      );

    case AppRoutes.deliveryAddressesRoute:
      return MaterialPageRoute(builder: (context) => DeliveryAddressesPage());

    case AppRoutes.trackOrderRoute:
      return MaterialPageRoute(
        builder: (context) => TrackOrderPage(
          order: settings.arguments,
        ),
      );

    case AppRoutes.checkOutRoute:
      return MaterialPageRoute(
        builder: (context) => CheckoutPage(
          order: settings.arguments,
        ),
      );

    case AppRoutes.editProfileRoute:
      return MaterialPageRoute(builder: (context) => EditProfilePage());

    case AppRoutes.changePasswordRoute:
      return MaterialPageRoute(builder: (context) => ChangePasswordPage());

    case AppRoutes.notificationsRoute:
      return MaterialPageRoute(builder: (context) => NotificationsPage());

    case AppRoutes.webViewRoute:
      return MaterialPageRoute(
        builder: (context) => WebView(
          url: settings.arguments,
        ),
      );

    //
    case AppRoutes.chatRoute:
      return MaterialPageRoute(
        builder: (context) => ChatPage(
          order: (settings.arguments as List)[0],
          vendor: (settings.arguments as List)[1],
        ),
      );
    case AppRoutes.walletRoute:
      return MaterialPageRoute(
        builder: (context) => WalletPage(),
      );

    default:
      return MaterialPageRoute(builder: (context) => OnboardingPage());
  }
}
