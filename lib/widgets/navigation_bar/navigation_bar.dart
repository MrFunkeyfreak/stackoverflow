import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'navigation_bar_mobile.dart';
import 'navigation_bar_tablet_desktop.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(),
      tablet: NavigationBarTabletDesktop(),
    );
  }
}
