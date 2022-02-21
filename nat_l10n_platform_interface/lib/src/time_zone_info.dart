import 'dart:ui';

import '../nat_l10n_platform_interface.dart';

class TimeZoneInfo {
  const TimeZoneInfo(this.id, {this.translation, this.offset});

  factory TimeZoneInfo.fromJson(Map<String, dynamic> json) {
    return TimeZoneInfo(json['id'],
        translation: json['translation'], offset: json['offset']);
  }

  /// The time zone ID, e.g. 'America/Los_Angeles'.
  final String id;

  /// Localized version of the time zone, according to specified locale
  /// and [TimeZoneStyle] when calling 'localizedTimeZones'.
  final String? translation;

  /// The offset of this time zone from GMT+00:00 in milliseconds.
  /// If [TimeZoneStyle.shortWithDst], [TimeZoneStyle.longWithDst] or
  /// [TimeZoneStyle.genericWithDst] is specified, the offset also includes the
  /// duration of the day saving time, but only if the time zone observes DST.
  final int? offset;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'translation': translation,
      'offset': offset
    };
    return data;
  }

  @override
  int get hashCode {
    return hashList([id, translation, offset]);
  }

  @override
  bool operator ==(Object other) {
    return other is TimeZoneInfo &&
        other.id == id &&
        other.translation == translation &&
        other.offset == offset;
  }
}
