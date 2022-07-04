import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth.dart';
import '../../../provider/users_table.dart';
import '../../registration/widgets/radiobuttons.dart';

// Button which edit an User in the database (and table)

class EditButtonAdmin extends StatefulWidget {
  const EditButtonAdmin({Key key}) : super(key: key);

  @override
  State<EditButtonAdmin> createState() => _EditButtonAdminState();
}

class _EditButtonAdminState extends State<EditButtonAdmin> {
  String genderSelected;
  String roleSelected;

  List<Map<String,dynamic>> selectedRows;
  String selectedUid;

  String _birthDateInString;
  DateTime birthDate;
  bool isDateSelected= false;

  static final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(),
  ];

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final UsersTable userTable = Provider.of<UsersTable>(context);
    final AuthProvider authproviderInstance = Provider.of<AuthProvider>(context);

    return TextButton.icon(
      onPressed: () =>
      { selectedRows = userTable.selecteds,    //get the selected row from the user_administration_desktop.dart
        if(selectedRows.length == 1) {

          //change the value of the TextFieldsControllers to the data of the selected user
          authproviderInstance.usernameController.value = TextEditingValue(
              text: selectedRows[0]['username'],
              selection: TextSelection.fromPosition(
                  TextPosition(offset: selectedRows[0]['username'].length)
              )
          ),

          authproviderInstance.emailController.value = TextEditingValue(
            text: selectedRows[0]['email'],
            selection: TextSelection.fromPosition(
                TextPosition(offset: selectedRows[0]['email'].length)
            )
        ),

          authproviderInstance.firstNameController.value = TextEditingValue(
            text: selectedRows[0]['first name'],
            selection: TextSelection.fromPosition(
                TextPosition(offset: selectedRows[0]['first name'].length)
            )
        ),

          authproviderInstance.lastNameController.value = TextEditingValue(
            text: selectedRows[0]['last name'],
            selection: TextSelection.fromPosition(
                TextPosition(offset: selectedRows[0]['last name'].length)
            )
        ),

          genderSelected = selectedRows[0]['gender'],

          roleSelected = selectedRows[0]['role'],

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Form(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [
                                    Text("Benutzer bearbeiten",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight
                                                .bold
                                        )),
                                  ],
                                ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _formKeys[0],
                                    autovalidateMode: AutovalidateMode.always,
                                    child: TextFormField(
                                      validator: (username) {
                                        print(authproviderInstance.validateUsername(username));
                                        return authproviderInstance.validateUsername(username);
                                      },
                                      controller: authproviderInstance.usernameController,
                                      decoration: InputDecoration(
                                          labelText: "Benutzername",
                                          hintText: "Max123",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          )
                                      ),
                                    ),),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _formKeys[1],
                                    autovalidateMode: AutovalidateMode.always,
                                    child: TextFormField(
                                      validator: (email) => EmailValidator.validate(email) ? null : "Bitte gib eine gültige E-Mail an.",
                                      controller: authproviderInstance.emailController,
                                      decoration: InputDecoration(
                                          labelText: "E-Mail",
                                          hintText: "abc@domain.com",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          )
                                      ),
                                    ),
                                  ),),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _formKeys[2],
                                    autovalidateMode: AutovalidateMode.always,
                                    child: TextFormField(
                                      validator: (firstName) {
                                        print(authproviderInstance.validateName(firstName));
                                        return authproviderInstance.validateName(firstName);
                                      },
                                      controller: authproviderInstance.firstNameController,
                                      decoration: InputDecoration(
                                          labelText: "Vorname",
                                          hintText: "Max",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          )
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _formKeys[3],
                                    autovalidateMode: AutovalidateMode.always,
                                    child: TextFormField(
                                      validator: (lastName) {
                                        print(authproviderInstance.validateName(lastName));
                                        return authproviderInstance.validateName(lastName);
                                      },
                                      controller: authproviderInstance.lastNameController,
                                      decoration: InputDecoration(
                                          labelText: "Nachname",
                                          hintText: "Mustermann",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          )
                                      ),
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [

                                    //SizedBox(width: 11,),

                                    Text(
                                      "Geburtsdatum:",
                                      style: TextStyle(
                                          fontSize: 18),
                                    ),

                                    GestureDetector(
                                      child: new Icon(
                                        Icons.calendar_today,
                                        size: 30,),
                                      onTap: () async {
                                        final DateTime datePick = await showDatePicker(
                                          locale: const Locale('de'),
                                          context: context,
                                          initialDate: new DateTime
                                              .now(),
                                          firstDate: new DateTime(
                                              1900),
                                          lastDate: new DateTime(
                                              2100),
                                          initialEntryMode: DatePickerEntryMode.input,
                                          errorFormatText: 'Gib ein Datum mit dem Format Tag/Monat/Jahr ein',
                                          errorInvalidText: 'Gib ein realistisches Datum ein',
                                          fieldLabelText: 'Geburtstag',
                                          fieldHintText: 'TT/MM/YYYY',
                                        );
                                        if (datePick != null &&
                                            datePick != birthDate) {
                                          setState(() {
                                            birthDate = datePick;
                                            isDateSelected = true;

                                            // birthdate in string
                                            _birthDateInString = "${birthDate.day}/${birthDate.month}/${birthDate.year}";
                                            print('' +_birthDateInString);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: <Widget>[

                                    Text(
                                      "Geschlecht:",
                                      style: TextStyle(
                                          fontSize: 18),
                                      textAlign: TextAlign.start,
                                    ),

                                    SizedBox(width: 10,),

                                    // using the radiobuttons in widgets (registration)
                                    RadioButtonGender(
                                        0, 'Männlich', genderSelected, (newValue) {
                                      print(newValue);
                                      setState(() =>
                                      genderSelected = newValue);
                                    }),
                                    RadioButtonGender(
                                        1, 'Weiblich', genderSelected, (newValue) {
                                      print(newValue);
                                      setState(() =>
                                      genderSelected = newValue);
                                    }),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "Rolle:",
                                      style: TextStyle(
                                          fontSize: 18),
                                      textAlign: TextAlign.start,
                                    ),

                                    SizedBox(width: 10,),

                                    // using the radiobuttons in widgets (registration)
                                    RadioButtonRole(
                                        0, 'User', roleSelected, (newValue) {
                                      print(newValue);
                                      setState(() =>
                                      roleSelected = newValue);
                                    }),
                                    RadioButtonRole(
                                        1, 'Wissenschaftler', roleSelected, (newValue) {
                                      print(newValue);
                                      setState(() =>
                                      roleSelected = newValue);
                                    }),
                                    RadioButtonRole(
                                        2, 'Admin', roleSelected, (newValue) {
                                      print(newValue);
                                      setState(() =>
                                      roleSelected = newValue);
                                    }),

                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(
                                      8.0),
                                  child: ElevatedButton(
                                    child: Text("Bearbeiten"),
                                    onPressed: () async {
                                      //selectedRows = userTable.selecteds;

                                      final usernameFormkey = _formKeys[0].currentState;
                                      final emailFormkey = _formKeys[1].currentState;
                                      final firstNameFormkey = _formKeys[2].currentState;
                                      final lastNameFormkey = _formKeys[3].currentState;

                                        if(authproviderInstance.usernameController.text.trim() != null && authproviderInstance.emailController.text.trim() != null
                                            && authproviderInstance.firstNameController.text.trim() != null && authproviderInstance.lastNameController.text.trim() != null
                                            && isDateSelected != false && genderSelected != null  && roleSelected != null){
                                        if (emailFormkey.validate() && usernameFormkey.validate() && firstNameFormkey.validate()
                                            && lastNameFormkey.validate()){
                                        selectedUid = selectedRows[0]['uid'];

                                        //update the user with the authProviderControllers and the selected role,gender,birthday + the uid
                                        await authproviderInstance.updateUserEdit(selectedUid,
                                            _birthDateInString,genderSelected, roleSelected);

                                        Navigator.of(context).pop();
                                        userTable.selecteds.clear();   //clear the selected row variable
                                        userTable.initializeData();    //initializeData to update the table
                                      }else{
                                          print('validate notgoodatall');
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
                                      }// not all Textfields/Buttons are filled
                                        else {
                                          showDialog(context: context, builder: (BuildContext context){
                                            return AlertDialog(
                                              title: Text("Error: Editieren gescheitert! Bitte alle Felder ausfüllen."),
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
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            })
      } else {
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text("Error: Bitte wähle genau einen User aus."),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }),
        }
      },
      icon: Icon(
        IconData(0xf00d, fontFamily: 'MaterialIcons'),
        color: Colors.black,),
      label: Text("Bearbeiten",
          style: TextStyle(
              color: Colors.black
          )
      ),
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all<Color>(Colors.grey),
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(10)),
      ),
    );
    }
}
