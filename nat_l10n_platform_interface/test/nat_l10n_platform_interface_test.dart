import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nat_l10n_platform_interface/method_channel_nat_l10n.dart';
import 'package:nat_l10n_platform_interface/src/currency_info.dart';
import 'package:nat_l10n_platform_interface/src/locale_info.dart';
import 'package:nat_l10n_platform_interface/src/time_zone_info.dart';

const List<TimeZoneInfo> _tzTestResult = [
  TimeZoneInfo('Europe/Berlin',
      translation: '중부 유럽 표준시', offset: Duration.millisecondsPerHour),
  TimeZoneInfo('America/Denver',
      translation: '미 산악 표준시', offset: -Duration.millisecondsPerHour * 7),
];

const List<LocaleInfo> _localesTestResult = [
  LocaleInfo('en-US',
      translatedLocale: '영어 (미국)',
      translatedLanguage: '영어',
      translatedRegion: '미국'),
  LocaleInfo('de-DE',
      translatedLocale: '독일어 (독일)',
      translatedLanguage: '독일어',
      translatedRegion: '독일'),
];

const List<LocaleInfo> _respectiveLocalesTestResult = [
  LocaleInfo('en-US',
      translatedLocale: 'English (United States)',
      translatedLanguage: 'English',
      translatedRegion: 'United States'),
  LocaleInfo('de-DE',
      translatedLocale: 'Deutsch (Deutschland)',
      translatedLanguage: 'Deutsch',
      translatedRegion: 'Deutschland'),
];

const List<CurrencyInfo> _currenciesTestResult = [
  CurrencyInfo('EUR', translated: '유로', symbol: r'€'),
  CurrencyInfo('USD', translated: '미국 달러', symbol: r'US$'),
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$MethodChannelNatl10n', () {
    final log = <MethodCall>[];
    late MethodChannelNatl10n methodChannelNatl10n;

    setUp(() async {
      methodChannelNatl10n = MethodChannelNatl10n();
      methodChannelNatl10n.methodChannel
          .setMockMethodCallHandler((methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'localizedTimeZones':
            return _tzTestResult.map((e) => e.toJson()).toList();
          case 'localizedLocales':
            return _localesTestResult.map((e) => e.toJson()).toList();
          case 'respectivelyLocalizedLocales':
            return _respectiveLocalesTestResult.map((e) => e.toJson()).toList();
          case 'localizedCurrencies':
            return _currenciesTestResult.map((e) => e.toJson()).toList();
          default:
            return null;
        }
      });
      log.clear();
    });

    test('localizedTimeZones', () async {
      final result = await methodChannelNatl10n.localizedTimeZones(
          const Locale('ko', 'KR'), ['Europe/Berlin', 'America/Denver']);
      expect(result, _tzTestResult);
    });

    test('localizedLocales', () async {
      final result = await methodChannelNatl10n.localizedLocales(
          const Locale('ko', 'KR'),
          const [Locale('en', 'US'), Locale('de', 'DE')]);
      expect(result, _localesTestResult);
    });

    test('respectivelyLocalizedLocales', () async {
      final result = await methodChannelNatl10n.respectivelyLocalizedLocales(
          const [Locale('en', 'US'), Locale('de', 'DE')]);
      expect(result, _respectiveLocalesTestResult);
    });

    test('localizedCurrencies', () async {
      final result = await methodChannelNatl10n
          .localizedCurrencies(const Locale('ko', 'KR'), ['EUR', 'USD']);
      expect(result, _currenciesTestResult);
    });
  });
}
