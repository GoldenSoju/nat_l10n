import 'dart:ui';

import 'package:nat_l10n_platform_interface/nat_l10n_platform_interface.dart';

export 'package:nat_l10n_platform_interface/nat_l10n_platform_interface.dart'
    show TimeZoneStyle, TimeZoneInfo, LocaleInfo, CurrencyInfo;

class NatL10n {
  static Natl10nPlatform get _platform {
    return Natl10nPlatform.instance;
  }

  /// Returns a list of TimeZoneInfo, localized in the specified Locale.
  /// The formatting style is optional.
  Future<List<TimeZoneInfo>> localizedTimeZones(
      Locale locale, List<String> timeZones,
      {TimeZoneStyle style = TimeZoneStyle.long}) {
    return _platform.localizedTimeZones(locale, timeZones, style: style);
  }

  /// Returns a list of LocaleInfo, localized in the specified Locale.
  Future<List<LocaleInfo>> localizedLocales(
      Locale locale, List<Locale> locales) {
    return _platform.localizedLocales(locale, locales);
  }

  /// Returns a list of LocaleInfo, localized in each own Locale respectively.
  Future<List<LocaleInfo>> respectivelyLocalizedLocales(List<Locale> locales) {
    return _platform.respectivelyLocalizedLocales(locales);
  }

  /// Returns a list of CurrencyInfo, localized in the specified Locale.
  Future<List<CurrencyInfo>> localizedCurrencies(
      Locale locale, List<String> currencies) {
    return _platform.localizedCurrencies(locale, currencies);
  }
}
