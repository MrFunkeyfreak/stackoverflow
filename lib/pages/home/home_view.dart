import 'package:fitnesstrackerwebapplication/pages/home/home_content_desktop.dart';
import 'package:fitnesstrackerwebapplication/pages/home/home_content_mobile.dart';
import 'package:fitnesstrackerwebapplication/widgets/call_to_action/call_to_action.dart';
import 'package:fitnesstrackerwebapplication/widgets/centered%20view/centered_view.dart';
import 'package:fitnesstrackerwebapplication/widgets/course_details/course_details.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../widgets/navigation_bar/navigation_bar.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CenteredView(
        child: Column(
          children: <Widget>[
            NavigationBar1(),
            Expanded(
             child: ScreenTypeLayout(
              mobile: HomeContentMobile(),
              desktop: HomeContentDesktop(),
            )),
          ],
        ),
      ),
    );
  }
}