import 'package:asthma_monitor/utill/routes.dart';
import 'package:asthma_monitor/view/screens/analize/body_screen.dart';
import 'package:asthma_monitor/view/screens/analize/environment_screen.dart';
import 'package:asthma_monitor/view/screens/analize/mind_screen.dart';
import 'package:asthma_monitor/view/screens/auth/login_screen.dart';
import 'package:asthma_monitor/view/screens/auth/register_screen.dart';
import 'package:asthma_monitor/view/screens/home/dashboard_screen.dart';
import 'package:asthma_monitor/view/screens/option/option_screen.dart';
import 'package:asthma_monitor/view/screens/profile/profile_screen.dart';
import 'package:asthma_monitor/view/screens/result/result_screen.dart';
import 'package:fluro/fluro.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  static Handler _registerHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => RegisterScreen());
  static Handler _loginHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => LoginScreen());
  static Handler _dashScreenBoardHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return DashboardScreen(
        pageIndex: params['page'][0] == 'analyze'
            ? 0
            : params['page'][0] == 'profile'
                ? 1
                : params['page'][0] == 'history'
                    ? 2
                    : 0);
  });
  static Handler _deshboardHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          DashboardScreen(pageIndex: 0));
  static Handler _optionHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => OptionScreen());
  static Handler _bodyHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => BodyScreen());
  static Handler _environmentHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          EnvironmentScreen());
  static Handler _mindHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => MindScreen());
  static Handler _resultHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ResultScreen());

  static void setupRouter() {
    router.define(Routes.REGISTER_SCREEN,
        handler: _registerHandler, transitionType: TransitionType.inFromRight);
    router.define(Routes.LOGIN_SCREEN,
        handler: _loginHandler, transitionType: TransitionType.inFromRight);
    router.define(Routes.DASHBOARD_SCREEN,
        handler: _dashScreenBoardHandler,
        transitionType: TransitionType.fadeIn); // ?page=home
    router.define(Routes.DASHBOARD,
        handler: _deshboardHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.OPTION_SCREEN,
        handler: _optionHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.BODY_SCREEN,
        handler: _bodyHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ENVIRONMENT_SCREEN,
        handler: _environmentHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.MIND_SCREEN,
        handler: _mindHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.RESULT_SCREEN,
        handler: _resultHandler, transitionType: TransitionType.fadeIn);
  }
}
