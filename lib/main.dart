import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(

    const ProviderScope(

      child: MyApp(),

    ),

  );

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(

  debugShowCheckedModeBanner: false,

  theme: AppTheme.lightTheme,

  routerConfig: appRouter,

  locale: const Locale('ar'),

  supportedLocales: const [

    Locale('ar'),
    Locale('en'),

  ],

  localizationsDelegates: const [

    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,

  ],

  builder: (context, child) {

    return Directionality(

      textDirection: TextDirection.rtl,

      child: child!,

    );

  },

);

  }

}