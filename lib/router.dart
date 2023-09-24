import 'package:boiler_plate_flutter/authentication/login_screen.dart';
import 'package:boiler_plate_flutter/authentication/repos/authentication_repo.dart';
import 'package:boiler_plate_flutter/authentication/sign_up_screen.dart';
import 'package:boiler_plate_flutter/navigation/main_navigation.dart';
import 'package:boiler_plate_flutter/tutorial/tutorial_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Routes {
  ///signUp
  static const String signUpURL = '/sign-up';
  static const String signUpName = 'signUp';

  ///login
  static const String loginURL = '/login';
  static const String loginName = 'login';

  ///tutorial
  static const String tutorialURL = '/tutorial';
  static const String tutorialName = 'tutorial';

  ///mainnavigation
  static const String mainNavigationURL = '/:tab(home|discover|inbox|profile)';
  static const String mainNavigationName = 'mainNavigation';
}

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/login",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.subloc != Routes.signUpURL &&
              state.subloc != Routes.loginURL) {
            return Routes.signUpURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: Routes.signUpName,
          path: Routes.signUpURL,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: Routes.loginName,
          path: Routes.loginURL,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: Routes.tutorialName,
          path: Routes.tutorialURL,
          builder: (context, state) => const TutorialScreen(),
        ),
        GoRoute(
          path: Routes.mainNavigationURL,
          name: Routes.mainNavigationName,
          builder: (context, state) {
            final tab = state.params["tab"]!;
            return MainNavigationScreen(tab: tab);
          },
        ),
      ],
    );
  },
);
