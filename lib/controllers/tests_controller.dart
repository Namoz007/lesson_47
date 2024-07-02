import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_47_home/models/test.dart';
import 'package:dars_47_home/services/test_firebase_services.dart';
import 'package:flutter/cupertino.dart';

class TestsController extends ChangeNotifier{
  final _apiServices = TestFirebaseServices();
  List<int> _clickQuestionList = [];
  List<Test> _tests = [
    Test(question: "Flutter qaysi kompaniya tarafidan yaratilgan?", options: ['Google','Amazon','Apple','Facebook'], trueAnswer: 0),
    Test(question: "Flutter nechinchi yilda yaratilgan?", options: ['2020','2017','2008','2000'], trueAnswer: 1),
    Test(question: "Flutter qaysi dasturlash tili bilan uy'g'unlikda ishlaydi?", options: ['Python','Java','Dart','JavaScript'], trueAnswer: 2),
    Test(question: "Flutter qanaqa tizimlar uchun mo'ljallangan?", options: ['IOS','Android','Linux','Istalgan'], trueAnswer: 3),
  ];

  Stream<QuerySnapshot> get getStatistics {
    return _apiServices.getStatistics();
  }

  Future<void> writeResponse(int count) async{
    await _apiServices.writeResponse(count);
  }

  List<Test> getTests(){
    return [..._tests];
  }

  void clickQuestion(int index){
    _clickQuestionList.add(index);
    notifyListeners();
  }

  List<int> clickedIndexs(){
    return [..._clickQuestionList];
  }






}