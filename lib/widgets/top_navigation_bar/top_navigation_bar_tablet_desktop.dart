import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/top_navigation_bar_logo.dart';
import 'package:flutter/material.dart';
import '../../routing/route_names.dart';
import '../top_navbar_item/top_navbar_item.dart';


class TopNavigationBarTabletDesktop extends StatelessWidget {
  const TopNavigationBarTabletDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TopNavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TopNavBarItem('Episodes', EpisodesRoute),
              SizedBox(
                width: 60,
              ),
              TopNavBarItem('About', AboutRoute),
            ],
          )
        ],
      ),
    );
  }
}