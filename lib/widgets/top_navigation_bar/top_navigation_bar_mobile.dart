import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/top_navigation_bar_logo.dart';
import 'package:flutter/material.dart';


class TopNavigationBarMobile extends StatelessWidget {
  const TopNavigationBarMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          TopNavBarLogo()
        ],
      ),
    );
  }
}
