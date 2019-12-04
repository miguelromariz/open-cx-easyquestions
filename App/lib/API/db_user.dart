import 'package:app/Model/user.dart';
import 'package:app/Notifiers/notifier_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


void getUserFromDatabase(AuthNotifier authNotifier, String authID) async {
  QuerySnapshot snapshot = await Firestore.instance.collection('Users').getDocuments();

  snapshot.documents.forEach((document)
  {
    User user = User.fromMap(document.data);

    if(user.authID == authID) {
      authNotifier.user = user;
    }
  });
}


registerUser(FirebaseUser firebaseUser, String fullname, String age, String type) async {

  //TODO: Verificacao com regex para age ----------- age hardcoded

  User user;

  if(type == 'Admin')
    user = new User(permission: 2, avatar: null,fullname: fullname,age: 21, description: null, authID: firebaseUser.uid);
  if(type == 'Speaker')
    user = new User(permission: 1, avatar: null, fullname: fullname, age: 20, description: null, authID: firebaseUser.uid);
  if(type == 'Normal')
    user = new User(permission: 0, avatar: null, fullname: fullname, age: 20, description: null, authID: firebaseUser.uid);




  CollectionReference userRef = await Firestore.instance.collection('Users');

  DocumentReference documentReference = await userRef.add(user.toMap());

  user.idDoc = documentReference.documentID;


  await documentReference.setData(user.toMap(), merge:true);

}