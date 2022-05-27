
import 'package:flutter/material.dart';
import '../../routing/route_names.dart';
import '../top_navbar_item/top_navbar_item.dart';
import 'top_navigation_drawer_header.dart';

class TopNavigationDrawer extends StatelessWidget {
  const TopNavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          TopNavigationDrawerHeader(),
          //Bons: Combine the UI for this widget with the NavBarItem and make it responsive
          //The UI for the current Drawer
          TopNavBarItem(
            'Episodes',
            EpisodesRoute,
            icon: Icons.videocam,
          ),
          TopNavBarItem(
              'About',
              AboutRoute,
              icon: Icons.help
          ),
        ],
      ),
    );
  }
}
