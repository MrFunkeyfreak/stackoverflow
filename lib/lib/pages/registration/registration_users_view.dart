import 'package:bestfitnesstrackereu/pages/registration/widgets/radiobuttons.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../widgets/loading_circle/loading_circle.dart';

// normal Registration page for the users
class RegistrationUsersView extends StatefulWidget {
  const RegistrationUsersView({Key key}) : super(key: key);

  @override
  State<RegistrationUsersView> createState() => _RegristrationViewState();
}

class _RegristrationViewState extends State<RegistrationUsersView> {
  String _genderSelected;

  String _birthDateInString;
  DateTime birthDate;
  bool isDateSelected= false;

  Map<String, dynamic> mapUserinformations = {};
  static final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(),
    GlobalKey<FormState>(), GlobalKey<FormState>()
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);  // creating an instance of authProvider

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            // checks the authentication status, when it is Authenticating, then return loading, else show the page
            child: authProvider.status == Status.Authenticating ? Loading() : Container(
              constraints: BoxConstraints(maxWidth: 440),
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Image.asset("assets/logo.png", width: 300,),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    children: [
                      Text("Registrierung",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold
                          )),
                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Text(
                          "Wilkommen zur Registration",
                          style: TextStyle(
                            color: Colors.grey,))
                    ],
                  ),

                  SizedBox(height: 15,),

                  Form(
                    key: _formKeys[0],
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      validator: (username) {
                        print(authProvider.validateUsername(username));
                        return authProvider.validateUsername(username);
                      },
                      controller: authProvider.usernameController,
                      decoration: InputDecoration(
                          labelText: "Benutzername",
                          hintText: "Max123",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),),

                  SizedBox(height: 15,),

                  Form(
                    key: _formKeys[1],
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      validator: (email) => EmailValidator.validate(email) ? null : "Bitte gib eine gültige E-Mail an.",
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

                  Form(
                    key: _formKeys[2],
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                        validator: (password) {
                          print(authProvider.validatePassword(password));
                          return authProvider.validatePassword(password);
                        },
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
                  ),

                  SizedBox(height: 15,),

                  Form(
                    key: _formKeys[3],
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      validator: (passwordConfirm) {
                        print(authProvider.validatePassword(passwordConfirm));
                        return authProvider.validatePassword(passwordConfirm);
                      },
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
                  ),

                  SizedBox(height: 15,),

                  Form(
                    key: _formKeys[4],
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      validator: (firstName) {
                        print(authProvider.validateName(firstName));
                        return authProvider.validateName(firstName);
                      },
                      controller: authProvider.firstNameController,
                      decoration: InputDecoration(
                          labelText: "Vorname",
                          hintText: "Max",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),

                  Form(
                    key: _formKeys[5],
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      validator: (lastName) {
                        print(authProvider.validateName(lastName));
                        return authProvider.validateName(lastName);
                      },
                      controller: authProvider.lastNameController,
                      decoration: InputDecoration(
                          labelText: "Nachname",
                          hintText: "Mustermann",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),

                  Row(
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
                            errorFormatText: 'Gib ein Datum mit dem Format Tag/Monat/Jahr ein',
                            errorInvalidText: 'Gib ein realistisches Datum ein',
                            fieldLabelText: 'Geburtstag',
                            fieldHintText: 'TT/MM/YYYY',
                          );
                          if(datePick!=null && datePick!=birthDate){
                            setState(() {
                              birthDate=datePick;
                              isDateSelected=true;

                              // birthdate in string
                              _birthDateInString = "${birthDate.day}/${birthDate.month}/${birthDate.year}";
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

                        // using the radiobuttons in widgets
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

                  InkWell(
                      onTap: () async {
                        final usernameFormkey = _formKeys[0].currentState;
                        final emailFormkey = _formKeys[1].currentState;
                        final passwordFormkey = _formKeys[2].currentState;
                        final passwordConfirmedFormkey = _formKeys[3].currentState;
                        final firstNameFormkey = _formKeys[4].currentState;
                        final lastNameFormkey = _formKeys[5].currentState;

                        print('pw confirmed:' + authProvider.passwordConfirmedController.text.trim());
                        print('pw:' + authProvider.passwordController.text.trim());


                        //password and passworconfirm check
                        if(authProvider.passwordConfirmedController.text.trim() == authProvider.passwordController.text.trim()) {

                          //checking if all textfields are not empty
                          if (authProvider.usernameController.text.trim() != null && authProvider.emailController.text.trim() != null
                              && authProvider.passwordController.text.trim() != null && authProvider.passwordConfirmedController.text.trim() != null
                              && authProvider.firstNameController.text.trim() != null && authProvider.lastNameController.text.trim() != null
                              && isDateSelected != false && _genderSelected != null ) {

                            // checking if all textfields are valid
                            if(emailFormkey.validate() && usernameFormkey.validate() && passwordFormkey.validate() &&
                                passwordConfirmedFormkey.validate() && firstNameFormkey.validate() && lastNameFormkey.validate()){
                              print('validate okok');

                            // input is the authProvider.emailController, which provides the written email
                            // output are all the user informations in a Map<String, dynamic>
                            // used to check the status and role of the user
                              mapUserinformations = await authProvider.getUserByEmail();

                            //when email exist, then check status
                            if (mapUserinformations != null){
                              print('email is already existing');

                              //checking if status is deleted
                              if(mapUserinformations['status'] == 'gelöscht'){
                                print('email is deleted');

                                //recreate the deleted user
                                try{
                                  //update user informations
                                  await authProvider.updateUserSignup(mapUserinformations['uid'], _birthDateInString, _genderSelected, 'User');

                                  //input: emailcontroller, output: send password reset link
                                  try {
                                    await FirebaseAuth.instance.sendPasswordResetEmail(
                                        email: authProvider.emailController.text.trim());
                                  } on FirebaseAuthException catch (e){
                                    print(e);
                                    showDialog(
                                        context: context,builder: (context){
                                      return AlertDialog(
                                        content: Text(e.message.toString()),
                                      );
                                    });
                                  }
                                  authProvider.clearController();
                                  isDateSelected = false;
                                  _genderSelected = null;

                                  // deleted user got recreated - now print a message that the registration process is completed
                                  showDialog(context: context, builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text(
                                          "Registration abgeschlossen.\nDein Account war gelöscht, daher wurde dir eine E-Mail zum zurücksetzen deines persönlichen Passworts zugesendet.\nNachdem du das Passwort abgeändert hast, kannst du "
                                          "dich nun in unserer App einloggen.",
                                          textAlign: TextAlign.center),
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
                                catch(e) {
                                  print(e);
                                }
                              }
                              // email is already existing and the status is not deleted
                              else{
                                showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Error: Es existiert schon ein Account mit dieser E-Mail Adresse."),
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
                            }
                            // email not existing in database -> mapUserinformations = null
                            else{
                              try{
                                print('email existiert noch nicht');
                                // sign up user in database with the birthday and gender + all controllers from authProvider
                                await authProvider.signUpUser(_birthDateInString, _genderSelected);
                                authProvider.clearController();
                                isDateSelected = false;
                                _genderSelected = null;

                                showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Registration abgeschlossen. Du kannst dich nun in unserer App einloggen."),
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
                              catch(e) {
                                print(e);
                              }
                            }
                            }else{
                            print('validate email notgoodatall');
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Error: Bitte überprüfe, ob alle deine Eingaben ein gültiges Format aufweisen."),
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
                            }
                          // not all Textfields/Buttons are filled
                          else {
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

                  SizedBox(height: 15,),

                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                            height: 50,
                            color: Colors.grey[500],
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Du bist schon registriert?'),
                      ),
                      Expanded(
                          child: Divider(
                            height: 50,
                            color: Colors.grey[500],
                          )
                      ),
                    ],
                  ),

                  SizedBox(height: 15,),

                  InkWell(
                      onTap: (){
                        authProvider.clearController();
                        isDateSelected = false;
                        _genderSelected = null;
                        Navigator.of(context).pushNamed(AuthenticationPageRoute);
                      },
                      child: Container(
                          decoration: BoxDecoration(color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Zum Login",
                            style: TextStyle(
                              color: Colors.white,
                            ),)
                      )
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}