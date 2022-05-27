import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../datamodels/navbar_item_model.dart';
import '../../locator.dart';
import '../../services/navigation_service.dart';
import 'navbar_item_desktop.dart';
import 'navbar_item_mobile.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  final IconData icon;
  const NavBarItem(this.title, this.navigationPath, {this.icon});

  @override
  Widget build(BuildContext context) {

    var model = NavBarItemModel(
      title: title,
      navigationPath: navigationPath,
      iconData: icon,
    );

    return GestureDetector(
      onTap: () {
        //don't ever use a serbice directly in the ui to change any kind of state
        //services should only be used from a viewmodel
        locator<NavigationService>().navigateTo(navigationPath);
      },
      child: ScreenTypeLayout(
        tablet: NavBarItemTabletDesktop(
          model: model,
        ),
        mobile: NavBarItemMobile(
          model: model,
        ),
      ),
    );
  }
}