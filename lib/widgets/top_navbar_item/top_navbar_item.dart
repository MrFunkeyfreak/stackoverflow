import 'package:bestfitnesstrackereu/widgets/top_navbar_item/top_navbar_item_desktop.dart';
import 'package:bestfitnesstrackereu/widgets/top_navbar_item/top_navbar_item_mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../datamodels/navbar_item_model.dart';
import '../../locator.dart';
import '../../services/navigation_service.dart';


class TopNavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  final IconData icon;
  const TopNavBarItem(this.title, this.navigationPath, {this.icon});

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
        tablet: TopNavBarItemTabletDesktop(
          model: model,
        ),
        mobile: TopNavBarItemMobile(
          model: model,
        ),
      ),
    );
  }
}