import 'package:flutter/material.dart';

import 'filter_settings.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({
    super.key,
    this.initialFilters = const <String, List<String>>{},
  });

  final Map<String, List<String>> initialFilters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).maybePop(),
              child: const SizedBox.shrink(),
            ),
          ),
          SafeArea(
            top: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                ),
                child: FilterSettingsSheet(initialFilters: initialFilters),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
