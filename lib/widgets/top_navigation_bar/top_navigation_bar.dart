import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'top_navigation_bar_mobile.dart';
import 'top_navigation_bar_tablet_desktop.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: TopNavigationBarMobile(),
      tablet: TopNavigationBarTabletDesktop(),
    );
  }
}
