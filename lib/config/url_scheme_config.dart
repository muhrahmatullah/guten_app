abstract class UrlSchemeConfig {
  late String domainUrl;
}

class ProdUrlConfig extends UrlSchemeConfig {
  ProdUrlConfig() {
    domainUrl = 'https://gutendex.com/';
  }
}

class DevUrlConfig extends UrlSchemeConfig {
  DevUrlConfig() {
    domainUrl = 'https://gutendex.com/';
  }
}