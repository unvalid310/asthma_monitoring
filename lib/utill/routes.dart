class Routes {
  static const String REGISTER_SCREEN = '/register-screen';
  static const String LOGIN_SCREEN = '/login';
  static const String DASHBOARD = '/';
  static const String DASHBOARD_SCREEN = '/main';
  static const String OPTION_SCREEN = '/option';
  static const String BODY_SCREEN = '/body';
  static const String ENVIRONMENT_SCREEN = '/envi';
  static const String MIND_SCREEN = '/mind';
  static const String RESULT_SCREEN = '/result';

  static String getRegisterRoute() => REGISTER_SCREEN;
  static String getLoginRoute() => LOGIN_SCREEN;
  static String getMainRoute() => DASHBOARD;
  static String getDashboardRoute(String page) =>
      '$DASHBOARD_SCREEN?page=$page';
  static String getOptionRoute() => OPTION_SCREEN;
  static String getBodyRoute() => BODY_SCREEN;
  static String getEnvironmentRoute() => ENVIRONMENT_SCREEN;
  static String getMindRoute() => MIND_SCREEN;
  static String getResultRoute() => RESULT_SCREEN;
}
