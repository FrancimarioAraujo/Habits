import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    ScreenUtil.init(context);
    return MaterialApp.router(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          LocalJsonLocalization.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('pt', 'BR'),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }

          // define pt_BR as default when de language code is 'pt'
          if (locale?.languageCode == 'pt') {
            return const Locale('pt', 'BR');
          }

          // default language
          return const Locale('en', 'US');
        },
        title: 'Flutter Slidy',
        routerDelegate: Modular.routerDelegate,
        routeInformationParser: Modular.routeInformationParser,
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.blue,
            secondary: Colors.orange,
            tertiary: Colors.white,
          ),
        ));
  }
}
