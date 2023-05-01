import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nat_l10n/nat_l10n.dart';

import '../src/constants.dart';
import '../src/locales.dart';
import '../widgets/detail_card.dart';
import 'drop_down_row.dart';

class CurrenciesView extends StatefulWidget {
  const CurrenciesView(this.natL10n, this.updateHeader, {Key? key})
      : super(key: key);

  final NatL10n natL10n;
  final void Function(String) updateHeader;

  @override
  State<CurrenciesView> createState() => _CurrenciesViewState();
}

class _CurrenciesViewState extends State<CurrenciesView> {
  List<CurrencyInfo> _localizedCurrencies = [];
  Locale _selectedLocale = Locales.enUS;

  @override
  void initState() {
    super.initState();
    loadTranslations();
  }

  Future<void> loadTranslations([Locale? locale]) async {
    if (locale != null) {
      _selectedLocale = locale;
    }
    List<CurrencyInfo> localizedCurrencies;
    try {
      localizedCurrencies = await widget.natL10n
          .localizedCurrencies(_selectedLocale, allCurrencies);
    } on PlatformException {
      localizedCurrencies = [];
    }
    if (!mounted) return;
    setState(() {
      _localizedCurrencies = localizedCurrencies;
    });
    widget.updateHeader(
        'Localized Currencies (Count: ${allCurrencies.length}/${localizedCurrencies.length})');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 10),
        DropDownRow(
            selectedLocale: _selectedLocale,
            onChangeLocale: (loc) => loadTranslations(loc)),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: _localizedCurrencies.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => DetailCard(
                firstLine:
                    '${_localizedCurrencies[index].translated} / Symbol: ${_localizedCurrencies[index].symbol}',
                secondLine:
                    'Currency Code: ${_localizedCurrencies[index].currencyCode}'),
          ),
        ),
      ],
    );
  }
}
