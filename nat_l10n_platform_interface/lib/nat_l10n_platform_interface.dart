library nat_l10n_platform_interface;

import 'dart:async';
import 'dart:ui';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_nat_l10n.dart';
import 'src/src.dart';

export 'src/src.dart';

/// Platform implementations should extend this class rather than implement it.
abstract class Natl10nPlatform extends PlatformInterface {
  Natl10nPlatform() : super(token: _token);
  static final Object _token = Object();

  static Natl10nPlatform _instance = MethodChannelNatl10n();

  /// The default instance of [Natl10nPlatform] to use.
  ///
  /// Defaults to [MethodChannelNatl10n].
  static Natl10nPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [Natl10nPlatform] when they register themselves.
  static set instance(Natl10nPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns a list of TimeZoneInfo, localized in the specified Locale.
  /// The formatting style is optional.
  Future<List<TimeZoneInfo>> localizedTimeZones(
      Locale locale, List<String> timeZones,
      {TimeZoneStyle? style}) {
    throw UnimplementedError('localizedTimeZones() has not been implemented.');
  }

  /// Returns a list of LocaleInfo, localized in the specified Locale.
  Future<List<LocaleInfo>> localizedLocales(
    Locale locale,
    List<Locale> locales,
  ) {
    throw UnimplementedError('localizedLocales() has not been implemented.');
  }

  /// Returns a list of LocaleInfo, localized in each own Locale respectively.
  Future<List<LocaleInfo>> respectivelyLocalizedLocales(
    List<Locale> locales,
  ) {
    throw UnimplementedError('localizedLocales() has not been implemented.');
  }

  /// Returns a list of CurrencyInfo, localized in the specified Locale.
  Future<List<CurrencyInfo>> localizedCurrencies(
    Locale locale,
    List<String> currencies,
  ) {
    throw UnimplementedError('localizedCurrencies() has not been implemented.');
  }
}
