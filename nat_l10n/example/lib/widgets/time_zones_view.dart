import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nat_l10n/nat_l10n.dart';

import '../src/constants.dart';
import '../src/locales.dart';
import '../src/utils.dart';
import '../widgets/detail_card.dart';
import 'drop_down_row.dart';

class TimeZonesView extends StatefulWidget {
  const TimeZonesView(this.natL10n, this.updateHeader, {super.key});

  final NatL10n natL10n;
  final void Function(String) updateHeader;

  @override
  State<TimeZonesView> createState() => _TimeZonesViewState();
}

class _TimeZonesViewState extends State<TimeZonesView> {
  List<TimeZoneInfo> _localizedTimeZones = [];
  Locale _selectedLocale = Locales.enUS;

  TimeZoneStyle _style = TimeZoneStyle.long;

  @override
  void initState() {
    super.initState();
    loadTranslations();
  }

  Future<void> loadTranslations([Locale? locale]) async {
    if (locale != null) {
      _selectedLocale = locale;
    }
    List<TimeZoneInfo> localizedTimeZones;
    try {
      localizedTimeZones = await widget.natL10n
          .localizedTimeZones(_selectedLocale, allTimeZoneIds, style: _style);
    } on PlatformException {
      localizedTimeZones = [];
    }
    if (!mounted) return;
    setState(() {
      _localizedTimeZones = localizedTimeZones;
    });
    widget.updateHeader(
        'Localized TimeZones (Count: ${allTimeZoneIds.length}/${localizedTimeZones.length})');
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
          secondMenu: [
            const Text(
              'Style:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.white, width: 0.5)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TimeZoneStyle>(
                  alignment: Alignment.center,
                  isDense: true,
                  value: _style,
                  iconEnabledColor: Colors.white,
                  dropdownColor: dropDownEnabledColor,
                  borderRadius: BorderRadius.circular(8.0),
                  items: TimeZoneStyle.values
                      .map<DropdownMenuItem<TimeZoneStyle>>(
                          (e) => DropdownMenuItem<TimeZoneStyle>(
                              value: e,
                              child: Text(
                                e.toShortStringCapitalized(),
                                style: const TextStyle(fontSize: 14),
                              )))
                      .toList(),
                  onChanged: (TimeZoneStyle? newValue) {
                    setState(() {
                      _style = newValue ?? TimeZoneStyle.long;
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
            itemCount: _localizedTimeZones.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => DetailCard(
                firstLine:
                    '${_localizedTimeZones[index].translation}, ${(_localizedTimeZones[index].offset)?.toFormattedOffsetString()}',
                secondLine: 'ID: ${_localizedTimeZones[index].id}'),
          ),
        ),
      ],
    );
  }
}
