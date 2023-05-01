class CurrencyInfo {
  const CurrencyInfo(this.currencyCode, {this.translated, this.symbol});

  factory CurrencyInfo.fromJson(Map<String, dynamic> json) {
    return CurrencyInfo(json['currencyCode'],
        translated: json['translated'], symbol: json['symbol']);
  }

  /// ISO 4217 currency code, e.g. 'USD'.
  final String currencyCode;

  /// Localized currency, e.g. 'US Dollar'.
  final String? translated;

  /// Symbol that represents the currency, e.g. '$'. Returns simply
  /// the currency code for most currencies.
  final String? symbol;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'currencyCode': currencyCode,
      'translated': translated,
      'symbol': symbol
    };
    return data;
  }

  @override
  int get hashCode => Object.hash(currencyCode, translated, symbol);

  @override
  bool operator ==(Object other) {
    return other is CurrencyInfo &&
        other.currencyCode == currencyCode &&
        other.translated == translated &&
        other.symbol == symbol;
  }
}
