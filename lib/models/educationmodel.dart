class EducationModel {
  final String educationId;
  late final String calendarEndDate;
  late final String calendarStartDate;
  late final String childId;
  late final String classId;
  late final String classTeacherId;
  late final String schoolId;
  late final String currentYear;
  late final String status;
  late final List<String> subjectsList;

  EducationModel(
      {required this.educationId,
      required this.calendarEndDate,
      required this.calendarStartDate,
      required this.childId,
      required this.classId,
      required this.classTeacherId,
      required this.schoolId,
      required this.currentYear,
      required this.status,
      required this.subjectsList});
}

class ClassModel {
  final String classId;
  late final String className;
  late final String classTeacherId;
  late final String schoolId;

  ClassModel({
    required this.classId,
    required this.className,
    required this.classTeacherId,
    required this.schoolId,
  });
}

class SchoolModel {
  final String schoolId;
  late final String schoolAddress;
  late final String schoolEmail;
  late final String schoolName;
  late final String schoolPhoneNumber;

  SchoolModel({
    required this.schoolId,
    required this.schoolAddress,
    required this.schoolEmail,
    required this.schoolName,
    required this.schoolPhoneNumber,
  });
}

class TeacherModel {
  final String teacherId;
  late final String schoolId;
  late final String teacherEmail;
  late final String teacherName;
  late final String teacherPhoneNumber;

  TeacherModel({
    required this.teacherId,
    required this.schoolId,
    required this.teacherEmail,
    required this.teacherName,
    required this.teacherPhoneNumber,
  });
}

class SubjectModel {
  final String subjectId;
  late final String subjectName;

  SubjectModel({
    required this.subjectId,
    required this.subjectName,
  });
}
