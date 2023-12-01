class subjectModel {
  late final String subjectId;
  late final String subjectName;

  subjectModel({
    required this.subjectId,
    required this.subjectName
  });
}

class schedule {

  final String scheduleId;
  final String subjectId;
  final String purpose;
  final String startTime;
  final String endTime;

  schedule({
    required this.scheduleId,
    required this.subjectId,
    required this.purpose,
    required this.startTime,
    required this.endTime
  });

}