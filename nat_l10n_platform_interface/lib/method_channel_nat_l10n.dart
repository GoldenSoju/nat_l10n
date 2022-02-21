import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'nat_l10n_platform_interface.dart';

class MethodChannelNatl10n extends Natl10nPlatform {
  @visibleForTesting
  MethodChannel methodChannel = const MethodChannel('com.cloudia9/nat_l10n');

  /// Returns a list of TimeZoneInfo, localized in the specified Locale.
  /// The formatting style is optional.
  @override
  Future<List<TimeZoneInfo>> localizedTimeZones(
      Locale locale, List<String> timeZones,
      {TimeZoneStyle? style}) async {
    final result =
        await methodChannel.invokeListMethod<dynamic>('localizedTimeZones', {
      'locale': locale.toLanguageTag(),
      'timeZone': timeZones,
      'style': style?.toShortString(),
    });
    return result
            ?.map((e) => TimeZoneInfo.fromJson(e.cast<String, dynamic>()))
            .toList() ??
        [];
  }

  /// Returns a list of LocaleInfo, localized in the specified Locale.
  @override
  Future<List<LocaleInfo>> localizedLocales(
      Locale locale, List<Locale> locales) async {
    final result =
        await methodChannel.invokeListMethod<dynamic>('localizedLocales', {
      'locale': locale.toLanguageTag(),
      'locales': locales.map((e) => e.toLanguageTag()).toList(),
    });
    return result
            ?.map((e) => LocaleInfo.fromJson(e.cast<String, dynamic>()))
            .toList() ??
        [];
  }

  /// Returns a list of LocaleInfo, localized in each own Locale respectively.
  @override
  Future<List<LocaleInfo>> respectivelyLocalizedLocales(
      List<Locale> locales) async {
    final result = await methodChannel
        .invokeListMethod<dynamic>('respectivelyLocalizedLocales', {
      'locales': locales.map((e) => e.toLanguageTag()).toList(),
    });
    return result
            ?.map((e) => LocaleInfo.fromJson(e.cast<String, dynamic>()))
            .toList() ??
        [];
  }

  /// Returns a list of CurrencyInfo, localized in the specified Locale.
  @override
  Future<List<CurrencyInfo>> localizedCurrencies(
      Locale locale, List<String> currencies) async {
    final result =
        await methodChannel.invokeListMethod<dynamic>('localizedCurrencies', {
      'locale': locale.toLanguageTag(),
      'currencies': currencies,
    });
    return result
            ?.map((e) => CurrencyInfo.fromJson(e.cast<String, dynamic>()))
            .toList() ??
        [];
  }
}

extension EnumValueOnlyString on Enum {
  String toShortString() {
    return toString().split('.').last;
  }
}
