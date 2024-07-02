
import 'package:dars_47_home/models/error.dart';
import 'package:dars_47_home/services/test_firebase_services.dart';

class AuthController{
  final _authServices = TestFirebaseServices();

  Future<ErrorType?> createUser(String email,String password) async{
    final response = await _authServices.createUser(email, password);
    return response;
  }

  Future<ErrorType> inUser(String email,String password) async{
    final response = await _authServices.inUser(email, password);
    return response!;
  }

  Future<void> writeStatistic(String email) async{
    await _authServices.writeStatistic(email);
  }
}