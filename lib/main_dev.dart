import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guten_app/run_app.dart';

import 'config/url_scheme_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runGutenApp(
      baseUrlConfig: DevUrlConfig());
}