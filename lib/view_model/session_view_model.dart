import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/session_model.dart';
import '../services/firebase_rtdb.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:rehab/services/firebase_rtdb.dart';




class SessionViewModel extends GetxController {
  final FirebaseRDB _firebaseRDB = FirebaseRDB();
  final database = FirebaseDatabase.instance.ref();

  ValueNotifier<int> get currentSessionIndex => _currentSessionIndex;
  ValueNotifier<int> _currentSessionIndex = ValueNotifier(0);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);


  List<SessionModel> get sessionModel => _sessionModel;
  List<SessionModel> _sessionModel = <SessionModel>[];

  List<SessionModel> get sessionHistoryModel => _sessionHistoryModel;
  List<SessionModel> _sessionHistoryModel = <SessionModel>[];

  SessionViewModel(){
    getSessions();
  }


  getSessions() async {
    _loading.value = true;
    _firebaseRDB.sessionRef.onValue.listen((DatabaseEvent event) {
      _sessionModel.clear();
      DataSnapshot snapshot = event.snapshot;
      List sessionObjects = snapshot.value as List;
      for (var element in sessionObjects) {
        if(element == null){
          continue;
        }
        _sessionModel.add(SessionModel(sessionNo: element['sessionNo'], sessionCompleted: element['sessionCompleted'], sessionTime: element['sessionTime'], sessionDate: element['sessionDate']));
        _loading.value = false;
      }
      update();
    });
  }

  getSessionsHistory() async {
    _loading.value = true;
    _firebaseRDB.sessionRef.onValue.listen((DatabaseEvent event) {
      _sessionModel.clear();
      DataSnapshot snapshot = event.snapshot;
      List sessionObjects = snapshot.value as List;
      for (var element in sessionObjects) {
        if(element == null){
          continue;
        }
        _sessionModel.add(SessionModel(sessionNo: element['sessionNo'], sessionCompleted: element['sessionCompleted'], sessionTime: element['sessionTime'], sessionDate: element['sessionDate']));
        _loading.value = false;
      }
      update();
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<bool> updateSessionStatus(SessionModel sessionModel) async {
    bool isComplete = false;
    await database.child('Sessions/').child(sessionModel.sessionNo.toString()).update(
        sessionModel.toJson()).whenComplete(() => isComplete = true);
    print(sessionModel.toJson());
    return isComplete;
  }

  void startSession(BuildContext context) async {
    if(currentSessionIndex.value==sessionModel.length){
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        alignment: Alignment.center,
         title: const Text('Sessions Completed'),
        // content: const Text('Click ok button to Restart the Sessions'),
        actions: [
          TextButton(onPressed: (){
            // _sessionModel.clear();
            // _sessionHistoryModel.clear();
            Navigator.pop(context);
            },
        child: const Text('OK'))],
      ));
      print('All task Completed');
      return;
    }
    Random gen = Random();
    int range = 5 * 365;
    int minutes = 1;
    final currentDT = DateTime.now()
        .add(Duration(days: gen.nextInt(range), minutes: gen.nextInt(minutes)));
    _sessionModel[currentSessionIndex.value].sessionCompleted = true;
    _sessionModel[currentSessionIndex.value].sessionTime = DateFormat.jm().format(currentDT).toString();
    _sessionModel[currentSessionIndex.value].sessionDate = DateFormat('dd-mm-yyyy').format(currentDT).toString();
    await updateSessionStatus(_sessionModel[currentSessionIndex.value]) ? sessionHistoryModel.add(_sessionModel[currentSessionIndex.value]) : null;
    ++currentSessionIndex.value;
    update();
  }
}