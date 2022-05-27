import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../widgets/centered_view/centered_view.dart';
import '../../widgets/top_navigation_bar/top_navigation_bar.dart';
import '../../widgets/top_navigation_drawer/top_navigation_drawer.dart';


class LayoutTemplate extends StatelessWidget {
  final Widget child1;
  const LayoutTemplate({Key key, @required this.child1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        backgroundColor: Colors.white,
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? TopNavigationDrawer()
            : null,
        body: CenteredView(
          child: Column(
            children: <Widget>[
              TopNavigationBar(),
              Expanded(
                child: child1,
              )
            ],
          ),
        ),
      ),
    );
  }
}