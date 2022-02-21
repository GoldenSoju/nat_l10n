import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:nat_l10n/nat_l10n.dart';
import 'package:nat_l10n_platform_interface/nat_l10n_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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

class MockNatl10nPlatform
    with MockPlatformInterfaceMixin
    implements Natl10nPlatform {
  @override
  Future<List<TimeZoneInfo>> localizedTimeZones(
      Locale locale, List<String> timeZones,
      {TimeZoneStyle? style}) {
    return Future.value(_tzTestResult);
  }

  @override
  Future<List<LocaleInfo>> localizedLocales(
      Locale locale, List<Locale> locales) {
    return Future.value(_localesTestResult);
  }

  @override
  Future<List<LocaleInfo>> respectivelyLocalizedLocales(List<Locale> locales) {
    return Future.value(_respectiveLocalesTestResult);
  }

  @override
  Future<List<CurrencyInfo>> localizedCurrencies(
      Locale locale, List<String> currencies) {
    return Future.value(_currenciesTestResult);
  }
}

void main() {
  late NatL10n natL10n;
  late MockNatl10nPlatform fakePlatform;

  setUp(() {
    fakePlatform = MockNatl10nPlatform();
    Natl10nPlatform.instance = fakePlatform;
    natL10n = NatL10n();
  });

  test('localizedTimeZones', () async {
    expect(
        await natL10n.localizedTimeZones(
            const Locale('ko', 'KR'), ['Europe/Berlin', 'America/Denver']),
        _tzTestResult);
  });

  test('localizedLocales', () async {
    expect(
        await natL10n.localizedLocales(const Locale('ko', 'KR'),
            const [Locale('en', 'US'), Locale('de', 'DE')]),
        _tzTestResult);
  });

  test('localizedLocales', () async {
    expect(
        await natL10n.respectivelyLocalizedLocales(
            const [Locale('en', 'US'), Locale('de', 'DE')]),
        _tzTestResult);
  });

  test('localizedCurrencies', () async {
    expect(
        await natL10n
            .localizedCurrencies(const Locale('ko', 'KR'), ['EUR', 'USD']),
        _currenciesTestResult);
  });
}
