import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {

        var textAlignment;
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          textAlignment = TextAlign.left;
        } else {
          textAlignment = TextAlign.center;
        }

        double titleSize;
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          titleSize = 50;
        } else {
          titleSize = 80;
        }

        double descriptionSize;
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          descriptionSize = 16;
        } else {
          descriptionSize = 21;
        }

        return Container(
          width: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'FLUTTER WEB.\nTHE BASICS',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    height: 0.9,
                    fontSize: titleSize),
                textAlign: textAlignment,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'In this course we will go over the basics of using Flutter Web for website development. Topics will include Responsive Layout, Deploying, Font Changes, Hover Functionality, Modals and more.',
                style: TextStyle(
                  fontSize: descriptionSize,
                  height: 1.7,
                ),
                textAlign: textAlignment,
              )
            ],
          ),
        );
      },
    );
  }
}
