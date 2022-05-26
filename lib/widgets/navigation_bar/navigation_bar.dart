import 'package:fitnesstrackerwebapplication/widgets/navigation_bar/navigation_bar_tablet_dektop.dart';
import 'package:fitnesstrackerwebapplication/widgets/navigation_bar/navigation_logo.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'navbar_item.dart';
import 'navigation_bar_mobile.dart';

class TopNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(),
      tablet: NavigationBarTabletDesktop(),

    );
  }
}

