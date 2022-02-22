<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Native Localization (nat_l10n)

This plugin helps to make use of localization utilities provided by the native platforms.

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :----: |
|   ✔️    | ✔️  |  ➖️   | ➖️  |  ➖️   |   ➖️   |

## Features

Receive localized
- time zone entries
- locale entries
- currency entries

## Getting started

Add the following dependency to the `pubspec.yaml` file:

```yaml
dependencies:
  nat_l10n: ^0.0.1
```

## Usage

### General

```dart
// Import package
import 'package:nat_l10n/nat_l10n.dart';

// Instantiate it
final NatL10n natL10n = NatL10n();
```

### Localize Time Zones

```dart
// Required: Target Locale, Time Zone Ids (List), Optional: Formatting Style
List<TimeZoneInfo> localizedTimeZones = await natL10n.localizedTimeZones(
      Locale('en', 'US'), ['America/Denver', 'Europe/Berlin'], style: TimeZoneStyle.long);
});

// Returns:
// 1. {id: America/Denver, translation: Mountain Standard Time, offset: -25200}
// 2. {id: Europe/Berlin, translation: Central European Standard Time, offset: 3600}
```

### Localize Locales

```dart
// Required: Target Locale, Locales to localize (List)
List<LocaleInfo> localizedLocales = await natL10n.localizedLocales(
      Locale('en', 'US'), [ Locale('de', 'DE'),  Locale('ko', 'KR')]);
});

// Returns:
// 1. {localeTag: de-DE, translatedLocale: German (Germany), translatedLanguage: German, translatedRegion: Germany}
// 2. {localeTag: ko-KR, translatedLocale: Korean (South Korea), translatedLanguage: Korean, translatedRegion: South Korea}
```

### Respectively localize Locales

```dart
// Required: Locales to localize (List) into each locale respectively
List<LocaleInfo> localizedLocales = await natL10n.respectivelyLocalizedLocales(
      [ Locale('de', 'DE'),  Locale('ko', 'KR')]);
});
// Returns:
// 1. {localeTag: de-DE, translatedLocale: Deutsch (Deutschland), translatedLanguage: Deutsch, translatedRegion: Deutschland}
// 2. {localeTag: ko-KR, translatedLocale: 한국어 (대한민국), translatedLanguage: 한국어, translatedRegion: 대한민국}
```

### Localize Currencies

```dart
// Required: Target Locale, Currency codes to localize
List<CurrencyInfo> localizedCurrencies = await natL10n.localizedCurrencies(
    Locale('en', 'US'), [ 'USD', 'EUR']);
});
// Returns:
// 1. {currencyCode: USD, translated: US Dollar, symbol: $}
// 2. {currencyCode: EUR, translated: Euro, symbol: €}
```


## Additional information

### 1. Help Utils
The example app includes a list of:
- Time Zone Ids (e.g. `'America/Denver'`),
    - `nat_l10n/example/lib/src/time_zone_ids.dart`
- Locales (e.g. `Locale('en', 'US')`),
    - `nat_l10n/example/lib/src/locales.dart`
- ISO 4217 Currency Codes (e.g. `'USD'`)
    - `nat_l10n/example/lib/src/currencies.dart`

#### a. Android/Kotlin
[All supported Identifiers, Locales, Currency Codes](https://pl.kotl.in/_JBYkw3B3)
<iframe src="https://pl.kotl.in/rBDKG2en5?theme=darcula"></iframe>

#### b. iOS/Swift
[All supported Identifiers, Locales, Currency Codes](https://swiftfiddle.com/gk3wbhklijd3nn22mjlboe2owu)
<iframe width="100%" height="300" frameborder="0"
src="https://swiftfiddle.com/gk3wbhklijd3nn22mjlboe2owu/embedded/">
</iframe>

### 2. Regarding Time Zone Ids
Which time zone ids are supported, depends on the underlying platform.  
The *'Area/Location'* name format for time zone Ids is preferred [(Reference)](https://en.wikipedia.org/wiki/Tz_database#Names_of_time_zones).

- [Documentation Android](https://developer.android.com/reference/java/util/TimeZone)
- [Documentation Apple](https://developer.apple.com/documentation/foundation/timezone)

### 3. Regarding Locales

- [Documentation Android](https://developer.android.com/reference/java/util/Locale)
- [Documentation Apple](https://developer.apple.com/documentation/foundation/locale)

### 4. Regarding Currencies

- [Documentation Android](https://developer.android.com/reference/java/util/Currency)
- [Documentation Apple](https://developer.apple.com/documentation/foundation/locale)
    - There is no specific "Currency" class on iOS side. Currency information has to be attained via the Locale class.

### 5. Regarding Localization Results

The results can vary on the different platforms. No guarantee is given that the results are correct.
