import 'package:flutter/material.dart';
import 'package:guten_app/routes.dart';
import 'package:guten_app/screens/list/book_list_screen.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';

Widget buildApp({required AppConfig appConfig}) {
  return MultiProvider(
    providers: [
      Provider<AppConfig>.value(value: appConfig),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => 'Guten App',
      routes: GutenRoutes.get(),
      initialRoute: GutenBookListScreen.route,
    ),
  );
}
