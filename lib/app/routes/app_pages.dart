import 'package:get/get.dart';
import '../../view/screens/auth/welcome_screen.dart';
import '../../view/screens/auth/sign_in_screen.dart';
import '../../view/screens/auth/sign_up_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.welcome;

  static final routes = [
    GetPage(
      name: Routes.welcome,
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => SignUpScreen(),
    ),
  ];
}
