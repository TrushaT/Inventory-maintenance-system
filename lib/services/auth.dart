import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Inventory_User u;

  Inventory_User _userFromFirebaseUser(DocumentSnapshot querySnapshot) {
    String uid = querySnapshot.data()['uid'];
    String name = querySnapshot.data()['name'];
    String user_type = querySnapshot.data()['user_type'];
    Timestamp date_of_joining = querySnapshot.data()['date_of_joining'];
    String department = querySnapshot.data()['department'];
    String mobile_number = querySnapshot.data()['mobile_number'];
    String email = querySnapshot.data()['email'];
    return Inventory_User(
        uid: uid,
        name: name,
        user_type: user_type,
        date_of_joining: date_of_joining,
        department: department,
        mobile_number: mobile_number,
        email: email);
  }


  Future getUserData(String uid) async {
    DocumentReference ref = userCollection.doc(uid);
    print("UID");

    try {
      await ref.get().then((querySnapshot) async {
        print("Here 1");
        this.u = _userFromFirebaseUser(querySnapshot);
        // return this.u;
      });
      return this.u;
    } catch (e) {
      return null;
    }
  }

  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //to create user account
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //create new document for the user with uid
      // await DatabaseService(uid: user.uid)
      //     .updateUserData('0', 'new crew member', 100);
      return (user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
