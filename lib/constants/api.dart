class Api {
  static const baseUrl = "https://foodie.edentech.online/api";
  // static const baseUrl = "http://192.168.8.145:8000/api";

  static const phoneValidation = "/phone/verify";
  static const otpLogin = "/phone/login";

  static const login = "/login";
  static const loginSocial = "/login/social";
  static const register = "/register";
  static const logout = "/logout";
  static const forgotPassword = "/password/reset/init";

  static const changePassword = "/password/change";
  static const updateProfile = "/user/update";

  static const banners = "/banners";
  static const categories = "/categories";
  static const vendors = "/v2/vendors";
  static const deliveryAddress = "/delivery/addresses";
  static const defaultDeliveryAddress = "/default/delivery/address";

  static const paymentOptions = "/payment/options";

  static const initiateCheckout = "/checkout/initiate";
  static const finalizecheckout = "/checkout/finalize";

  static const orders = "/orders";
  static const orderUpdate = '/order/status/update';

  static const coupons = "/coupons";

  //
  static const fcmServer = 'https://fcm.googleapis.com/fcm/send';
  static const wallet = "/wallet";

  static const searchProducts = "/search/products";
}
