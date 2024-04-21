import 'package:flutter/material.dart';
import 'package:nat_l10n/nat_l10n.dart';

import 'src/constants.dart';
import 'widgets/currencies_view.dart';
import 'widgets/locales_view.dart';
import 'widgets/time_zones_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Localization (Nat_l10n) Demo',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final NatL10n _natL10n = NatL10n();
  String _header = '';
  int _pageIndex = 0;
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: foregroundColor,
        title: Text(_header),
        bottom: TabBar(
          controller: _tabController,
          onTap: (value) {
            _pageIndex = value;
            _pageController.animateToPage(_pageIndex,
                duration: animationDuration, curve: Curves.easeInOut);
          },
          indicatorColor: indicatorColor,
          tabs: const [
            Tab(text: 'TimeZones'),
            Tab(text: 'Locales'),
            Tab(text: 'Currencies'),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          _pageIndex = value;
          _tabController.animateTo(_pageIndex,
              duration: animationDuration, curve: Curves.easeInOut);
        },
        children: [
          TimeZonesView(_natL10n, _updateHeader),
          LocalesView(_natL10n, _updateHeader),
          CurrenciesView(_natL10n, _updateHeader),
        ],
      ),
    );
  }

  void _updateHeader(String text) {
    setState(() {
      _header = text;
    });
  }
}
