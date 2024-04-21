import 'package:flutter/material.dart';
import 'package:nat_l10n_example/src/constants.dart';

class DetailCard extends StatelessWidget {
  const DetailCard(
      {super.key, required this.firstLine, required this.secondLine});

  final String firstLine;
  final String secondLine;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardBackgroundColor,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(firstLine),
            const SizedBox(height: 5.0),
            Text(
              secondLine,
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
