/// Formatting style for displaying time zones.
/// Not every style is supported by every platform.
/// Not every style is supported by every time zone, in which case a back-up
/// style is returned automatically by the platform.
enum TimeZoneStyle {
  /// Short form, e.g. 'GMT+/-HH:MM' (time offset).
  short,

  /// Short form, e.g. 'GMT+/-HH:MM' (time offset with day saving time offset)'.
  shortWithDst,

  /// Long form, e.g. 'Central European Standard Time'.
  long,

  /// Long form, e.g. 'Central European Summer Time'.
  longWithDst,

  /// Generic form, e.g. 'Mountain Time'.
  /// Does not exist in Android, therefore 'long' is returned.
  generic,

  /// Short Generic form, e.g. 'MT' (for Mountain Time).
  /// Does not exist in Android, therefore 'short' is returned.
  shortGeneric
}
