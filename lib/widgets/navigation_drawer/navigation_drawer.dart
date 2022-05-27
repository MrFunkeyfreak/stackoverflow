import 'package:bestfitnesstrackereu/widgets/navbar_item/navbar_item.dart';
import 'package:flutter/material.dart';
import '../../routing/route_names.dart';
import 'navigation_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

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
          NavigationDrawerHeader(),
          //Bons: Combine the UI for this widget with the NavBarItem and make it responsive
          //The UI for the current Drawer
          NavBarItem(
            'Episodes',
            EpisodesRoute,
            icon: Icons.videocam,
          ),
          NavBarItem(
              'About',
              AboutRoute,
              icon: Icons.help
          ),
        ],
      ),
    );
  }
}
