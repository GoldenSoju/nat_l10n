import 'dart:ui';

class LocaleInfo {
  const LocaleInfo(this.localeTag,
      {this.translatedLocale, this.translatedLanguage, this.translatedRegion});

  factory LocaleInfo.fromJson(Map<String, dynamic> json) {
    return LocaleInfo(json['localeTag'],
        translatedLocale: json['translatedLocale'],
        translatedLanguage: json['translatedLanguage'],
        translatedRegion: json['translatedRegion']);
  }

  /// IETF BCP 47 language tag, e.g. 'en-US'
  final String localeTag;

  /// Localized locale, e.g. 'English (United Stated)'
  final String? translatedLocale;

  /// Localized language, e.g. 'English'
  final String? translatedLanguage;

  /// Localized country/region, e.g. 'United States'
  final String? translatedRegion;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'localeTag': localeTag,
      'translatedLocale': translatedLocale,
      'translatedLanguage': translatedLanguage,
      'translatedRegion': translatedRegion
    };
    return data;
  }

  @override
  int get hashCode {
    return hashList(
        [localeTag, translatedLocale, translatedLanguage, translatedRegion]);
  }

  @override
  bool operator ==(Object other) {
    return other is LocaleInfo &&
        other.localeTag == localeTag &&
        other.translatedLocale == translatedLocale &&
        other.translatedLanguage == translatedLanguage &&
        other.translatedRegion == translatedRegion;
  }
}
