import 'package:fluro/fluro.dart';
import 'package:webtrc_app/middlewares/auth_middleware.dart';
import 'package:webtrc_app/screens/home1_screen.dart';
import 'package:webtrc_app/screens/home_screen.dart';
import 'package:webtrc_app/screens/login_screen.dart';
import 'package:webtrc_app/screens/register_screen.dart';

class AppRouter {
  static final FluroRouter router = FluroRouter();

  static void setupRouter() {
    final authMiddleware = AuthMiddleware();

    router.define(
      "/",
      handler: Handler(handlerFunc: (context, params) => HomeScreen()),
    );
    router.define("/sign-in",
        handler: Handler(handlerFunc: (context, params) => LoginScreen()));
    router.define("/",
        handler: Handler(handlerFunc: (context, params) => RegisterScreen()));
    router.define(
      '/home',
      handler: Handler(handlerFunc: (context, params) => Home1Screen()),
    );
  }
}
