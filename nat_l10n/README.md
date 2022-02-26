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
    - [`nat_l10n/example/lib/src/time_zone_ids.dart`](https://github.com/GoldenSoju/nat_l10n/blob/master/nat_l10n/example/lib/src/time_zone_ids.dart)
- Locales (e.g. `Locale('en', 'US')`),
    - [`nat_l10n/example/lib/src/locales.dart`](https://github.com/GoldenSoju/nat_l10n/blob/master/nat_l10n/example/lib/src/locales.dart)
- ISO 4217 Currency Codes (e.g. `'USD'`)
    - [`nat_l10n/example/lib/src/currencies.dart`](https://github.com/GoldenSoju/nat_l10n/blob/master/nat_l10n/example/lib/src/currencies.dart)

#### a) Android/Kotlin
[All supported Identifiers, Locales, Currency Codes](https://pl.kotl.in/_JBYkw3B3)

<details>
  <summary>Show Code</summary>

```kotlin
import java.util.*

fun main() {
    printTimeZones()
    printLocales()
    printCurrencies()
}

private fun printTimeZones() {
    val timeZones = TimeZone.getAvailableIDs()
    timeZones.forEach {
       println("$it") 
    }
}

private fun printLocales() {
    val locales = Locale.getAvailableLocales()
    locales.forEach {
       println("$it") 
    }
}

private fun printCurrencies() {
    val currencies = Currency.getAvailableCurrencies()
    currencies.forEach {
       println("$it") 
    }
}
```
</details>

#### b) iOS/Swift
[All supported Identifiers, Locales, Currency Codes](https://swiftfiddle.com/gk3wbhklijd3nn22mjlboe2owu)

<details>
  <summary>Show Code</summary>

```swift
import Foundation

printTimeZones()
printLocales()
printCurrencies()

private func printTimeZones() {
  let timeZones = TimeZone.knownTimeZoneIdentifiers
  timeZones.forEach {
    print("\($0 as String?)")
  }
}

private func printLocales() {
  let locales = Locale.availableIdentifiers
  locales.forEach {
    print("\($0 as String?)")
  }
}

private func printCurrencies() {
  let currencies = Locale.isoCurrencyCodes
  // let currencies = Locale.commonISOCurrencyCodes
  currencies.forEach {
    print("\($0 as String?)")
  }
}
```
</details>

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
