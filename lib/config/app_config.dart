import 'url_scheme_config.dart';

class AppConfig {
  AppConfig({
    required this.baseUrlConfig,
  });

  final UrlSchemeConfig baseUrlConfig;

  Future<String> getBaseUrl() async {
    return baseUrlConfig.domainUrl;
  }

}