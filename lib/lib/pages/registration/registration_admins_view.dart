import 'package:bestfitnesstrackereu/pages/registration/widgets/radiobuttons.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../widgets/loading_circle/loading_circle.dart';

// not in use because we have edit_button_admin.dart

class RegistrationAdminsView extends StatefulWidget {
  const RegistrationAdminsView({Key key}) : super(key: key);

  @override
  State<RegistrationAdminsView> createState() => _RegristrationViewState();
}

class _RegristrationViewState extends State<RegistrationAdminsView> {
  String _genderSelected;
  String _roleSelected;

  String _birthDateInString;
  DateTime birthDate;
  bool isDateSelected= false;

  var _formKey = GlobalKey<FormState> ();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
          child: authProvider.status == Status.Authenticating? Loading() : Container(
            constraints: BoxConstraints(maxWidth: 440),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Image.asset("assets/logo.png"),
                    ),
                    Expanded(child: Container()),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                Row(
                  children: [
                    Text("Admin-Registrierung",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold
                        )),
                  ],
                ),

                SizedBox(height: 10,),

                Row(
                  children: [
                    Text(
                        "Wilkommen zur Admin-Registration",
                        style: TextStyle(
                          color: Colors.grey,))
                  ],
                ),

                SizedBox(height: 15,),

                TextField(
                  controller: authProvider.usernameController,
                  decoration: InputDecoration(
                      labelText: "Benutzername",
                      hintText: "Max123",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),

                SizedBox(height: 15,),

                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    validator: (email) => EmailValidator.validate(email) ? null : "Please enter a valid email",
                    controller: authProvider.emailController,
                    decoration: InputDecoration(
                        labelText: "E-Mail",
                        hintText: "abc@domain.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                TextField(
                  controller: authProvider.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Passwort",
                      hintText: "******",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),

                SizedBox(height: 15,),

                TextField(
                  controller: authProvider.passwordConfirmedController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Passwort wiederholen",
                      hintText: "******",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),

                SizedBox(height: 15,),

                TextField(
                  controller: authProvider.firstNameController,
                  decoration: InputDecoration(
                      labelText: "Vorname",
                      hintText: "Max",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),

                SizedBox(height: 15,),

                TextField(
                  controller: authProvider.lastNameController,
                  decoration: InputDecoration(
                      labelText: "Nachname",
                      hintText: "Mustermann",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),

                SizedBox(height: 15,),

                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(width: 11,),

                    Text(
                      "Geburtsdatum:",
                      style: TextStyle(fontSize: 18),
                    ),

                    SizedBox(width: 90,),

                    GestureDetector(
                      child: new Icon(Icons.calendar_today, size: 30,),
                      onTap: ()async{
                        final DateTime datePick= await showDatePicker(context: context,
                          initialDate: new DateTime.now(),
                          firstDate: new DateTime(1900),
                          lastDate: new DateTime(2100),
                          initialEntryMode: DatePickerEntryMode.input,
                          errorFormatText: 'Enter valid date',
                          errorInvalidText: 'Enter date in valid range',
                          fieldLabelText: 'Birthdate',
                          fieldHintText: 'TT/MM/YYYY',
                        );
                        if(datePick!=null && datePick!=birthDate){
                          setState(() {
                            birthDate=datePick;
                            isDateSelected=true;

                            // birthdate in string
                            _birthDateInString = "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                            print(''+ _birthDateInString);

                          });
                        }
                      },
                    ),
                  ],
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Geschlecht:",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),

                    SizedBox(width: 10,),


                    RadioButtonGender(
                        0, 'Männlich', _genderSelected,(newValue) {
                      print(newValue);
                      setState(() =>
                      _genderSelected = newValue);
                    }),
                    RadioButtonGender(
                        1, 'Weiblich', _genderSelected,(newValue) {
                      print(newValue);
                      setState(() =>
                      _genderSelected = newValue);
                    }),

                  ],
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Rolle:",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),

                    SizedBox(width: 10,),


                    RadioButtonRole(0, 'User', _roleSelected,(newValue) {
                      print(newValue);
                      setState(() =>
                      _roleSelected = newValue);
                    }),
                    RadioButtonRole(1, 'Wissenschaftler', _roleSelected,(newValue) {
                      print(newValue);
                      setState(() =>
                      _roleSelected = newValue);
                    }),
                    RadioButtonRole(2, 'Admin', _roleSelected,(newValue) {
                      print(newValue);
                      setState(() =>
                      _roleSelected = newValue);
                    }),

                  ],
                ),

                SizedBox(height: 15,),

                InkWell(
                    onTap: () async {

                      final form = _formKey.currentState;
                      print(form);

                      print('pw confirmed:' + authProvider.passwordConfirmedController.text.trim());
                      print('pw:' + authProvider.passwordController.text.trim());

                      if(authProvider.passwordConfirmedController.text.trim() == authProvider.passwordController.text.trim()) {
                        if (authProvider.usernameController.text.trim() != null && authProvider.emailController.text.trim() != null
                            && authProvider.passwordController.text.trim() != null && authProvider.passwordConfirmedController.text.trim() != null
                            && authProvider.firstNameController.text.trim() != null && authProvider.lastNameController.text.trim() != null
                            && _birthDateInString != null && _genderSelected != null ) {    //if signIn is success, then signUp + clear controller

                          if(form.validate()){
                            print('validate email okok');
                          }
                          else{
                            print('validate email notgoodatall');
                          }

                          await authProvider.signUpUser(_birthDateInString, _genderSelected);
                          authProvider.clearController();
                          Navigator.of(context).pushNamed(DashboardRoute);
                        }
                        else {      //signIn failed, then return Login failed
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Error: Registration gescheitert! Bitte alle Felder ausfüllen."),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                          return;
                        }


                      } else {
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Error: Passwort und Passwort wiederholen müssen gleich sein!"),
                            actions: [
                              TextButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                      }

                    },
                    child: Container(
                        decoration: BoxDecoration(color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Registrieren",
                          style: TextStyle(
                            color: Colors.white,
                          ),)
                    )
                ),
              ],
            ),
          )
      ),
    );
  }
}