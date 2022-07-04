import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datamodels/user_model.dart';
import '../services/user_services.dart';

enum Status { Uninitialized, Admin, Scientist, Authenticating, Unauthenticated }
//statt Authenticated - admin und scientist + vor aufbau der seite currentuser rolle checken

class AuthProvider with ChangeNotifier {

  AuthProvider({Key key});

  User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserModel _userModel;

  //  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  // public variables
  final formkey = GlobalKey<FormState>();
  UserServices userServices = UserServices ();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmedController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();


  AuthProvider.initialize() {
    _fireSetUp();
  }

  _fireSetUp() async {      //initializeApp (Firebase connection) and check changes
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCaos63TeR_y3YVXxD5x180IYz3ssQeWHE",
        appId: "1:414667114455:web:e0d8cdd30559bc41576d92",
        messagingSenderId: "414667114455",
        projectId: "thebasics-fb4e8",
      ),).then((value) {
      FirebaseAuth.instance.authStateChanges().listen(_onStateChanged);
    });
  }

  // checking if user is allowed to have access
  _onStateChanged(User firebaseUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else { //when firebase user exist
      _user = firebaseUser;
      await prefs.setString("id", firebaseUser.uid);

      _userModel = await _userServices.getUserById(user.uid).then((value) async {  //checking if user is Authenticated
        Map<String, dynamic> mapUserinformations = {};
        mapUserinformations = await getUserByUid(user.uid);
        if(mapUserinformations['role'] == 'Admin'){
          _status = Status.Admin; //admin
          print('role is admin');
        }
        if(mapUserinformations['role'] == 'Scientist'){
          _status = Status.Scientist; //scientist
          print('role is scientist');
        }
        if(mapUserinformations['role'] == 'User'){
          _status = Status.Unauthenticated; //scientist
          print('role is user');
        }
        return value;  //userModel
      });
    }
    notifyListeners();
  }

  // sign in the user -> used for login page (input = email and password)
  Future<bool> signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      _status = Status.Authenticating;
      notifyListeners(); //changing status
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim())
          .then((value) async {
        await prefs.setString("id", value.user.uid);  //checking user
      });


      // jetzt checken ob der user admin oder scientist ist
      Map<String, dynamic> mapUserinformations = {};
      mapUserinformations = await getUserByEmail();

      if(mapUserinformations['role'] == 'Admin'){
        _status = Status.Admin; //admin
        print('role is admin');
      }
      if(mapUserinformations['role'] == 'Scientist'){
        _status = Status.Scientist; //scientist
        print('role is scientist');
      }
      if(mapUserinformations['role'] == 'User'){
        _status = Status.Unauthenticated; //scientist
        print('role is user');
      }
      notifyListeners();
      return true;

    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  // update user especially made for the edit button in the user tables as admin
   Future <void> updateUserEdit(String id,String birthday, String gender, String role)async{
    print("username: " + usernameController.text.trim() + "email: " + emailController.text.trim());
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'username': usernameController.text.trim(), 'email': emailController.text.trim(),
         'first name': firstNameController.text.trim(), 'last name': lastNameController.text.trim(),
         'birthday': birthday, 'gender': gender, 'role': role,})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // update user especially made for the sign up in the registration pages (when user has status deleted)
  Future <void> updateUserSignup(String id,String birthday, String gender, String role)async{
    print("username: " + usernameController.text.trim() + "email: " + emailController.text.trim());
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'username': usernameController.text.trim(), 'email': emailController.text.trim(),
      'first name': firstNameController.text.trim(), 'last name': lastNameController.text.trim(),
      'birthday': birthday, 'gender': gender, 'status': 'aktiv','role': role,})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // update user especially made for changing status in the user tables (input: id and the value of the changed status)
  Future <void> updateUserStatus(String id, String status )async{
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'status': status})
        .then((value) => print("User status Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // input: emailController -> get the user data (used in registration, login and user_administration -> check if user with this email already exist)
  Future<Map<String, dynamic>> getUserByEmail() async {
    var userData;
    try {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: emailController.text.trim())
        .get()
        .then((QuerySnapshot docs) {

            if (docs.docs.isNotEmpty){
              print('test not empty + emailcontroller: '+emailController.text.trim() );
            userData = docs.docs[0].data();
          }
    });
    return userData;
  }catch (e) {print('Fehler getUserByEmail: '+e.toString());}}

  Future<Map<String, dynamic>> getUserByEmailInput(String email) async {
    var userData;
    try {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot docs) {

          print('okokoko');
      if (docs.docs.isNotEmpty){
        userData = docs.docs[0].data();
        print('getUserByEmailInput not empty: role is ' + userData['role']);
      }
    });
    return userData;
  }catch (e) {print('Fehler getUserByEmail: '+e.toString());}}

  Future<Map<String, dynamic>> getUserByUid(String uid) async {
    var userData;
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot docs) {

      if (docs.docs.isNotEmpty){
        print('getUserByUid not empty');
        userData = docs.docs[0].data();
      }
    });
    return userData;
  }

/*                 //not in use anymore
  Future <bool> getAdminExistence()async{  //bearbeiten
    print('hier wird abgefragt: '+emailController.text.trim());
    var i = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: emailController.text.trim(),)
        .get();
    if(i.size > 0){
      print('mit der email gibt admins: '+i.size.toString());
      return true;
    }
    else{
      return false;
    }
  }

  Future <bool> getScientistExistence()async{ //bearbeiten
    var i = await FirebaseFirestore.instance
        .collection('scientists')
        .where('email', isEqualTo: emailController.text.trim())
        .get();
    if(i.size > 0){
      return true;
    }
    else{
      return false;
    }
  }  */

  // delete a user from FirebaseFirestore -> not in use because we can't delete the user from authFirebase
  static Future deleteUser(String uid) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .delete();
  }

  // signUp a user in the database (auth and firestore) - used in registration
  Future<bool> signUpUser(String birthday, String gender) async {
    try {
      _status = Status.Authenticating;
      notifyListeners(); //changing status
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim())
          .then((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("id", result.user.uid);  //userid setzen
        _userServices.createUser(
          uid: result.user.uid,
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          birthday: birthday,
          gender: gender,
          status: 'aktiv',
          role: 'User',
        );});
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  //signOut a user - used in every page after the login (in the TopNavigationBar)
  Future signOut() async {
    FirebaseAuth.instance.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
  // clear all controllers - used after every click on a button
  void clearController() {
    usernameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    passwordConfirmedController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
  }

  Future<void> reloadUserModel() async {  //reloading user data
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  String validateEmail(String email) { //validate the email textfield
    RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.isEmpty) {
      return 'Bitte gib eine E-Mail ein.';
    } else {
      if (!regex.hasMatch(email)) {
        return 'Bitte gib eine gültige E-Mail ein.';
      } else {
        return null;
      }
    }
  }

  // at least one upper case, lower case, one digit, one Special character and at least 8  and max 18 characters in length
  String validatePassword(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,18}$');
    if (password.isEmpty) {
      return 'Bitte gib ein Passwort ein.';
    } else {
      if (!regex.hasMatch(password)) {
        return 'Bitte gib ein gültiges Passwort ein.';
      } else {
        return null;
      }
    }
  }

  // validate the username textfield
  String validateUsername(String username) {
    RegExp regex = RegExp(r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$');
    if (username.isEmpty) {
      return 'Bitte gib einen Benutzernamen ein.';
    } else {
      if (!regex.hasMatch(username)) {
        return 'Bitte gib einen gültigen Benutzernamen ein.';
      } else {
        return null;
      }
    }
  }
  // validate the name textfield
  String validateName(String name) { // so modifizieren, dass (^[A-Z]*) = erster buchstabe immer groß
    RegExp regex = RegExp(r"(^[A-Z]*)^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{1,}$");
    if (name.isEmpty) {
      return 'Bitte gib einen Namen ein.';
    } else {
      if (!regex.hasMatch(name)) {
        return 'Bitte gib einen gültigen Namen ein.';
      } else {
        return null;
      }
    }
  }

}