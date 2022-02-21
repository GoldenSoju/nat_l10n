extension EnumValueOnlyStringCapitalized on Enum {
  String toShortStringCapitalized() {
    var value = toString().split('.').last;
    value = value[0].toUpperCase() + value.substring(1);
    return value;
  }
}

extension IntToHoursString on int {
  String toFormattedOffsetString() {
    var prefix = this >= 0 ? '+' : '-';
    var formatted = 'GMT$prefix${_hourMinuteFormatted()}';
    return formatted;
  }

  String _hourMinuteFormatted() {
    Duration duration = Duration(seconds: this);
    String twoDigits(int n) => n.abs().toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes';
  }
}
