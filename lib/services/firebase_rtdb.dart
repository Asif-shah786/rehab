import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/session_model.dart';

class FirebaseRDB {
  //initialize Firebase RDB
  final database = FirebaseDatabase.instance.ref();
  final sessionRef = FirebaseDatabase.instance.ref('Sessions/');
  final sessionList = List<SessionModel>.generate(
      30, (i) => SessionModel(sessionNo: i + 1));


  void initializeSessionList() async {
    for (var session in sessionList) {
      try {
        await sessionRef.child(session.sessionNo.toString()).set(session.toJson());
      } catch (error) {
        print("Error Occurred in Writing");
        print(error);
      }
    }
    print('Done writing to database');
  }
}