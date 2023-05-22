// import 'package:firebase_core/firebase_core.dart';
import 'package:asthma_monitor/provider/SliderProvider.dart';
import 'package:asthma_monitor/provider/result_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:asthma_monitor/helper/router_helper.dart';
import 'package:asthma_monitor/provider/analyze_provider.dart';
import 'package:asthma_monitor/provider/auth_provider.dart';
import 'package:asthma_monitor/provider/language_provider.dart';
import 'package:asthma_monitor/provider/localization_provider.dart';
import 'package:asthma_monitor/provider/profile_provider.dart';
import 'package:asthma_monitor/provider/theme_provider.dart';
import 'package:asthma_monitor/theme/dark_theme.dart';
import 'package:asthma_monitor/theme/light_theme.dart';
import 'package:asthma_monitor/utill/app_constants.dart';
import 'package:asthma_monitor/utill/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'di_container.dart' as di;
import 'localization/app_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<LocalizationProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<AnalyzeProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<SliderProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<ResultProvider>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;
  String initalRoutes;

  @override
  void initState() {
    super.initState();
    checking();
    RouterHelper.setupRouter();
  }

  Future<void> checking() async {
    // melakukan pengecekan status login
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      setState(() {
        initalRoutes = Routes.DASHBOARD;
      });
    } else {
      setState(() {
        initalRoutes = Routes.LOGIN_SCREEN;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          initialRoute: initalRoutes,
          onGenerateRoute: RouterHelper.router.generator,
          title: 'Asthma Monitoring',
          navigatorKey: MyApp.navigatorKey,
          theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
          debugShowCheckedModeBanner: false,
          locale: Provider.of<LocalizationProvider>(context).locale,
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: _locals,
        );
      },
    );
  }
}
