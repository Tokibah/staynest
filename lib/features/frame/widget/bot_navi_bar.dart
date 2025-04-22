import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.currIndex});

  final ValueNotifier<int> currIndex;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ValueListenableBuilder(
        valueListenable: currIndex,
        builder: (context, currentPage, child) {
          //
          Widget botBarIcon({required IconData icon, required int index}) {
            return GestureDetector(
              onTap: () {
                currIndex.value = index;
              },
              child: Icon(
                icon,
                size: 30,
                color: index == currentPage
                    ? themeProvider.themeData.colorScheme.primary
                    : null,
              ),
            );
          }

          return Container(
            height: 80,
            decoration: BoxDecoration(
                color: themeProvider.themeData.brightness == Brightness.light
                    ? ThemeProvider.lightSec
                    : ThemeProvider.darkBack.withBlue(50),
                borderRadius: BorderRadius.circular(40)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  botBarIcon(icon: Icons.home, index: 0),
                  botBarIcon(icon: Icons.search, index: 1),
                  botBarIcon(icon: Icons.message, index: 2),
                  botBarIcon(icon: Icons.person, index: 3),
                ]),
          );
        });
  }
}
