import 'package:dars_47_home/controllers/tests_controller.dart';
import 'package:dars_47_home/firebase_options.dart';
import 'package:dars_47_home/views/screens/home_screen.dart';
import 'package:dars_47_home/views/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "name-here",
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx){
              return TestsController();
            },
          )
        ],
        builder: (ctx,child){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  }

                  if (snapshot.hasError)
                    return Text(
                      "Xatolik kelilb chiqdi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    );

                  return snapshot.data == null ? LoginScreen() : HomeScreen();
                },
              )
          );
        }
    );
  }
}
