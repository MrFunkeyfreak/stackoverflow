import 'package:bestfitnesstrackereu/pages/user_administration/admin/user_administration_view_admin_dekstop.dart';
import 'package:bestfitnesstrackereu/pages/user_administration/admin/user_administration_view_admin_mobile.dart';
import 'package:bestfitnesstrackereu/pages/user_administration/admin/user_administration_view_admin_tablet.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';


// user_administration page displayer - ScreenTypeLayout decides which screen is getting displayed
// in work - at the moment not in use

class UserAdministrationViewAdmin extends StatelessWidget {
  const UserAdministrationViewAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: UsersAdministrationViewAdminDesktop(),
      tablet: UsersAdministrationViewAdminTablet(),
      mobile: UsersAdministrationViewAdminMobile(),
    );
  }
}
