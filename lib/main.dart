import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rehab/services/firebase_rtdb.dart';

import 'helpers/binding.dart';
import 'home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          initialBinding: Binding(),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Task',
          theme: ThemeData(
            fontFamily: 'Quicksand',
            textTheme: TextTheme(bodyText2: TextStyle(fontSize: 3.sp)),
            primarySwatch: Colors.blue,
          ),
          home:  FutureBuilder(
            future: _fbApp,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasError){
                print('Firebase Error : Something Went Wrong');
              }
              if(snapshot.hasData){
                final FirebaseRDB _firebaseRDB = FirebaseRDB();
                _firebaseRDB.initializeSessionList();
                return const Home();
              }
              return const CircularProgressIndicator();
            },
          ),
        );
      },
    );
  }
}

