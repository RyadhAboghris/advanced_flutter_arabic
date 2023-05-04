import 'package:advanced_flutter_arabic/pressentation/forget_password/forget_password_view.dart';
import 'package:advanced_flutter_arabic/pressentation/login/view/login_view.dart';
import 'package:advanced_flutter_arabic/pressentation/main/main_view.dart';
import 'package:advanced_flutter_arabic/pressentation/register/view/register_view.dart';
import 'package:advanced_flutter_arabic/pressentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/pressentation/splash/splash_view.dart';
import 'package:advanced_flutter_arabic/pressentation/store_details/view/store_details_view.dart';
import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../onboarding/view/onboarding_view.dart';

import 'package:easy_localization/easy_localization.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String onBoardingRoute = '/onBoarding';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound).tr(),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
