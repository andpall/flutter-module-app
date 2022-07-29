import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_mod_app/core/stateProviders/auth.dart';

import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_mod_app/constants/theme.dart';
import 'package:flutter_mod_app/core/navigator/navigator.dart';
import 'package:flutter_mod_app/constants/routes.dart';
import 'package:flutter_mod_app/core/stateProviders/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'flutter-module-app',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  ThemePreference darkThemePreference = ThemePreference();
  bool isDarkTheme = await darkThemePreference.getTheme();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
  ));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(isDarkTheme),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthStateProvider(),
      )
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Module App',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', ''), Locale('ru', '')],
        theme: Provider.of<ThemeProvider>(context).getDarkMode
            ? darkTheme
            : lightTheme,
        initialRoute:
            Provider.of<AuthStateProvider>(context).getUserEmail == null
                ? authRoute
                : homeRoute,
        onGenerateRoute: onGenerateGlobalRoute);
  }
}
