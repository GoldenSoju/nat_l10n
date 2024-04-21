import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nat_l10n/nat_l10n.dart';
import 'package:nat_l10n_example/src/constants.dart';
import 'package:nat_l10n_example/src/locales.dart';
import 'package:nat_l10n_example/widgets/detail_card.dart';
import 'package:nat_l10n_example/widgets/drop_down_row.dart';

class LocalesView extends StatefulWidget {
  const LocalesView(this.natL10n, this.updateHeader, {super.key});

  final NatL10n natL10n;
  final void Function(String) updateHeader;

  @override
  State<LocalesView> createState() => _LocalesViewState();
}

class _LocalesViewState extends State<LocalesView> {
  List<LocaleInfo> _localizedLocales = [];
  Locale _selectedLocale = Locales.enUS;
  bool _localizeRespectively = false;

  @override
  void initState() {
    super.initState();
    loadTranslations();
  }

  Future<void> loadTranslations([Locale? locale]) async {
    if (locale != null) {
      _selectedLocale = locale;
    }
    List<LocaleInfo> localizedLocales;
    try {
      localizedLocales = _localizeRespectively
          ? await widget.natL10n.respectivelyLocalizedLocales(allLocales)
          : await widget.natL10n.localizedLocales(_selectedLocale, allLocales);
    } on PlatformException {
      localizedLocales = [];
    }
    if (!mounted) return;
    setState(() {
      _localizedLocales = localizedLocales;
    });
    widget.updateHeader(
        'Localized Locales (Count: ${allLocales.length}/${localizedLocales.length})');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 10),
        DropDownRow(
          selectedLocale: _selectedLocale,
          onChangeLocale: (loc) => loadTranslations(loc),
          enabled: _localizeRespectively == false,
          secondMenu: [
            const Text(
              'Respectively:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.white, width: 0.5)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<bool>(
                  alignment: Alignment.center,
                  isDense: true,
                  value: _localizeRespectively,
                  iconEnabledColor: Colors.white,
                  dropdownColor: dropDownEnabledColor,
                  borderRadius: BorderRadius.circular(8.0),
                  items: [false, true]
                      .map<DropdownMenuItem<bool>>(
                          (e) => DropdownMenuItem<bool>(
                              value: e,
                              child: Text(
                                e ? ' True' : ' False',
                                style: const TextStyle(fontSize: 14),
                              )))
                      .toList(),
                  onChanged: (bool? newValue) {
                    setState(() {
                      _localizeRespectively = newValue ?? false;
                    });
                    loadTranslations();
                  },
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: _localizedLocales.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => DetailCard(
                firstLine:
                    '${_localizedLocales[index].translatedLocale}\nLanguage: ${_localizedLocales[index].translatedLanguage} / Region: ${_localizedLocales[index].translatedRegion}',
                secondLine:
                    'Locale Tag: ${_localizedLocales[index].localeTag}'),
          ),
        ),
      ],
    );
  }
}
