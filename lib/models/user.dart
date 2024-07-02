
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String id;
  String userEmail;
  int count;

  User({required this.id,required this.userEmail,required this.count});

  factory User.fromJson(QueryDocumentSnapshot query) {
    return User(
      id: query['product_id'],
      userEmail: query['userEmail'],
      count: query['trueAnswerCount'],
    );
  }
}