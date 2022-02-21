import 'package:flutter/material.dart';

import '../src/constants.dart';
import '../src/locales.dart';

class DropDownRow extends StatefulWidget {
  const DropDownRow(this.selectedLocale, this.onChangeLocale,
      {Key? key, this.secondMenu})
      : super(key: key);

  final Locale selectedLocale;
  final void Function(Locale) onChangeLocale;
  final List<Widget>? secondMenu;

  @override
  _DropDownRowState createState() => _DropDownRowState();
}

class _DropDownRowState extends State<DropDownRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Locale:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.white, width: 0.5)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              alignment: Alignment.center,
              isDense: true,
              value: widget.selectedLocale,
              iconEnabledColor: Colors.white,
              dropdownColor: dropDownColor,
              borderRadius: BorderRadius.circular(8.0),
              items: allLocales
                  .map<DropdownMenuItem<Locale>>(
                      (e) => DropdownMenuItem<Locale>(
                          value: e,
                          child: Text(
                            e.toString(),
                            style: const TextStyle(fontSize: 14),
                          )))
                  .toList(),
              onChanged: (Locale? newValue) {
                widget.onChangeLocale(newValue ?? Locales.enUS);
              },
            ),
          ),
        ),
        ...widget.secondMenu ?? [],
      ],
    );
  }
}
