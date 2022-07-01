import 'package:intl/intl.dart';

class SessionModel {
  SessionModel(
      {this.sessionCompleted = false,
        required this.sessionNo,
        this.sessionDate = null,
        this.sessionTime = null});
  final int sessionNo;
  bool sessionCompleted;
  String? sessionDate;
  String? sessionTime;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  // String? getDate() =>  sessionDate == null? null : DateFormat('dd-mm-yyyy').format(sessionTime!).toString();
  // String? getTime() => sessionTime == null? null  :     DateFormat.jm().format(sessionDate!).toString();

}

SessionModel _$SessionDataFromJson(Map<String, dynamic> json) {
  return SessionModel(
    sessionNo: json['sessionNo'] as int,
    sessionCompleted: json['sessionCompleted'] as bool,
    sessionDate: json['sessionDate'] as String,
    sessionTime: json['sessionTime'] as String,
  );
}

Map<String, dynamic> _$UserDataToJson(SessionModel session) => <String, dynamic>{
  'sessionNo': session.sessionNo,
  'sessionCompleted': session.sessionCompleted,
  'sessionDate': session.sessionDate,
  'sessionTime': session.sessionTime,
};