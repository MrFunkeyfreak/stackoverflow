import 'package:cloud_firestore/cloud_firestore.dart';
import '../datamodels/user_model.dart';


class UserServices {
  String usersCollection = "users";

  // creates a user in the firestore - not in use
  void createUser({String uid,String username,String email,String firstName,String lastName, String birthday,String gender,String status,String role,}) {
    FirebaseFirestore.instance.collection(usersCollection).doc(uid).set({
      'uid': uid,
      'username': username,
      'email': email,
      'first name': firstName,
      'last name': lastName,
      'birthday': birthday,
      'gender': gender,
      'status': status,
      'role': role,
    });
  }

  // update the values from the user, who has the specific id - input Map with the values which should get changed
  void updateUserData(Map<String, dynamic> values) {
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(values['id'])
        .update(values);
  }

  // get the current user logged in
  Future<UserModel> getUserById(String id) =>
      FirebaseFirestore.instance.collection(usersCollection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });

  // get all user from the users collection and add them into a List <UserModel>   -> fromSnapshot get used which is defined in UserModel (datamodels folder)
  // currently used in the tables
  Future<List<UserModel>> getAllUsers() async =>
      FirebaseFirestore.instance.collection(usersCollection).get().then((result) {
        List<UserModel> users = [];
        for (DocumentSnapshot user in result.docs) {
          users.add(UserModel.fromSnapshot(user));
        }
        return users;
      });
}