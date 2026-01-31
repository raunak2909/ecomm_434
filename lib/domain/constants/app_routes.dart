import 'package:ecomm_434/ui/on_boarding/login_page.dart';
import 'package:ecomm_434/ui/on_boarding/sign_up_page.dart';
import 'package:flutter/cupertino.dart';

import '../../ui/splash/splash_page.dart';

class AppRoutes{
  static final String route_splash = "/";
  static final String route_login = "/login";
  static final String route_sign_up = "/sign_up";
  static final String route_dashboard = "/dashboard";

  static Map<String, WidgetBuilder> mRoutes = {
    route_splash: (context) => SplashPage(),
    route_login: (context) => LoginPage(),
    route_sign_up: (context) => SignUpPage(),
  };

}