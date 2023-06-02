import 'package:flutter/material.dart';

import 'build_app.dart';
import 'config/app_config.dart';
import 'config/url_scheme_config.dart';

Future<void> runGutenApp({
  required UrlSchemeConfig baseUrlConfig,
}) async {
  final appConfig = AppConfig(
    baseUrlConfig: baseUrlConfig,
  );

  final app = buildApp(
    appConfig: appConfig,
  );

  try {
    runApp(app);
  } catch (error, stacktrace) {
    print('$error & $stacktrace');
  }
}
