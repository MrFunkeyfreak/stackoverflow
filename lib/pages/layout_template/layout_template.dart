import 'package:bestfitnesstrackereu/widgets/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../widgets/centered_view/centered_view.dart';
import '../../widgets/navigation_drawer/navigation_drawer.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget child1;
  const LayoutTemplate({Key key, @required this.child1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        backgroundColor: Colors.white,
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawer()
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