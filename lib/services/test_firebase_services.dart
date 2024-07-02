import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_47_home/models/error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestFirebaseServices {
  final _authGet = FirebaseAuth.instance;
  final _connectApi = FirebaseFirestore.instance.collection("statistics");

  Future<void> writeResponse(int count) async{
    final pref = await SharedPreferences.getInstance();
    final userId = await pref.get("userId");

    _connectApi.doc(userId.toString()).update({
      "trueAnswerCount": count
    });
  }

  Future<ErrorType?> createUser(String email, String password) async {
    try {
      final response = await _authGet.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ErrorType(isError: false, status: 'null');
    } catch (e) {
      if (e.toString().contains("already")) {
        return ErrorType(isError: true, status: 'already');
      } else if (e.toString().contains("invalid")) {
        return ErrorType(isError: true, status: 'invalid');
      }
    }
  }

  Future<void> writeStatistic(String email) async{
    try {
      var newProduct = await _connectApi.add({
        "trueAnswerCount": 0,
        "userEmail": email,
      });
      await _connectApi.doc(newProduct.id).update({
        "product_id": newProduct.id,
      });
      final pref = await SharedPreferences.getInstance();
      await pref.setString('userId',newProduct.id);
    } on FirebaseException catch (er) {
    }
  }

  Future<ErrorType?> inUser(String email, String password) async {
    try {
      final response = await _authGet.signInWithEmailAndPassword(
          email: email, password: password);
      return ErrorType(isError: false, status: 'null');
    } catch (e) {
      if (e.toString().contains("invalid")) {
        return ErrorType(isError: true, status: "invalid");
      } else if (e.toString().contains("already")) {
        return ErrorType(isError: true, status: 'already');
      }
    }
  }

  Stream<QuerySnapshot> getStatistics() async* {
    yield* _connectApi.snapshots();
  }

  // Future<void>
}
