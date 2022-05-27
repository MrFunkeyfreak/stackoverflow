import 'package:flutter/material.dart';
import '../../datamodels/navbar_item_model.dart';

class TopNavBarItemTabletDesktop extends StatelessWidget {
  final NavBarItemModel model;
  TopNavBarItemTabletDesktop({this.model});

  @override
  Widget build(
      BuildContext context,
      ) {
    return Text(
      model.title,
      style: TextStyle(fontSize: 18),
    );
  }
}
