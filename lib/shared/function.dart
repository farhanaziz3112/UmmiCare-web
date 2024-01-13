import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/models/studentModel.dart';

String convertTimeToDateString(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date.day.toString() +
      " / " +
      date.month.toString() +
      " / " +
      date.year.toString();
}

String convertTimeToDateWithStringMonth(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date.day.toString() +
      " " +
      monthToString(date.month) +
      " " +
      date.year.toString();
}

String convertTimeToHoursMinute(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date.hour.toString() + " : " + date.minute.toString();
}

String getTimeFormat(String timeInMilliseconds) {
  DateTime temp =
      DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMilliseconds));
  return DateFormat.jm().format(temp);
}

String getTimeFormatWithDateTime(String timeInMilliseconds) {
  DateTime temp =
      DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMilliseconds));
  return DateFormat.jm().format(temp);
}

TimeOfDay convertDateTimeToTimeofDay(String timeInMilliseconds) {
  DateTime temp =
      DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMilliseconds));
  return TimeOfDay(hour: temp.hour, minute: temp.minute);
}

DateTime convertTimeToDate(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date;
}

DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay, DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour,
      timeOfDay.minute);
}

String monthToString(int month) {
  List<String> months = [
    'Jan',
    'Feb',
    'Mac',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  return months.elementAt(month - 1);
}

int getAge(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime birthDate = DateTime.fromMillisecondsSinceEpoch(temp);
  DateTime currentDate = DateTime.now();
  DateTime from = DateTime(birthDate.year, birthDate.month, birthDate.day);
  DateTime to = DateTime(currentDate.year, currentDate.month, currentDate.day);
  return (to.difference(from).inDays / 365).round();
}

String getAgeCategory(int age) {
  if (age <= 3) {
    return 'Newborn to 3 years old';
  } else if (3 < age && age <= 6) {
    return '3 to 6 years old';
  } else if (6 < age && age <= 12) {
    return '7 to 12 years old';
  } else {
    return '13 years old and above';
  }
}

String getLastSignedInFormat(String timeInMilliSeconds) {
  int temp = int.parse(timeInMilliSeconds);
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(temp);
  return dateTime.hour.toString() +
      ":" +
      dateTime.minute.toString() +
      " " +
      dateTime.day.toString() +
      "/" +
      dateTime.month.toString() +
      "/" +
      dateTime.year.toString();
}

int getNoOfChildCategory(List<childModel> childList, String category) {
  int total = 0;
  for (int i = 0; i < childList.length; i++) {
    if (childList.elementAt(i).childAgeCategory == category) {
      total++;
    }
  }
  return total;
}

int getNoOfAttendanceStatus(List<studentAttendanceModel> list, String status) {
  int total = 0;
  if (status == 'present') {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).attendanceStatus == "present") {
        total++;
      }
    }
  } else {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).attendanceStatus == "absent") {
        total++;
      }
    }
  }
  return total;
}

int getNoOfChildEducationStatus(List<childModel> childList, bool status) {
  int total = 0;
  if (status == true) {
    for (int i = 0; i < childList.length; i++) {
      if (childList.elementAt(i).educationId != "") {
        total++;
      }
    }
  } else {
    for (int i = 0; i < childList.length; i++) {
      if (childList.elementAt(i).educationId == "") {
        total++;
      }
    }
  }
  return total;
}

int getNoOfChildHealthStatus(List<childModel> childList, bool status) {
  int total = 0;
  if (status == true) {
    for (int i = 0; i < childList.length; i++) {
      if (childList.elementAt(i).healthId != "") {
        total++;
      }
    }
  } else {
    for (int i = 0; i < childList.length; i++) {
      if (childList.elementAt(i).healthId == "") {
        total++;
      }
    }
  }
  return total;
}

int getNoOfChildStatus(List<childModel> childList, String status) {
  int total = 0;
  for (int i = 0; i < childList.length; i++) {
    if (childList.elementAt(i).overallStatus == status) {
      total++;
    }
  }
  return total;
}

int getNoOfStudentStatus(List<studentModel>? studentList, String status) {
  int total = 0;
  for (int i = 0; i < studentList!.length; i++) {
    if (studentList.elementAt(i).activationStatus == status) {
      total++;
    }
  }
  return total;
}

int getNoOfStudentStatusBasedOnAcademicCalendar(List<studentModel> studentList,
    List<academicCalendarModel> academicCalendar, String status) {
  int total = 0;
  for (int i = 0; i < academicCalendar.length; i++) {
    for (int j = 0; j < studentList.length; j++) {
      if (studentList[j].academicCalendarId ==
          academicCalendar[i].academicCalendarId) {
        if (studentList[j].activationStatus == status) {
          total = total + 1;
        }
      }
    }
  }
  return total;
}

int getNoOfStudentAttendanceBasedOnAcademicCalendar(List<studentAttendanceModel> attendanceList,
    List<academicCalendarModel> academicCalendar, String status) {
  int total = 0;
  for (int i = 0; i < academicCalendar.length; i++) {
    for (int j = 0; j < attendanceList.length; j++) {
      if (attendanceList[j].academicCalendarId ==
          academicCalendar[i].academicCalendarId) {
        if (attendanceList[j].attendanceStatus == status) {
          total = total + 1;
        }
      }
    }
  }
  return total;
}

double getPercentageFromInt(int subject, int total) {
  return double.parse(((subject / total) * 100).toStringAsFixed(2));
}

String getGrade(String markInString) {
  int mark = int.parse(markInString);
  if (mark <= 100 && mark >= 80) {
    return 'A';
  } else if (mark >= 60 && mark < 80) {
    return 'B';
  } else if (mark >= 40 && mark < 60) {
    return 'C';
  } else if (mark >= 20 && mark < 40) {
    return 'D';
  } else {
    return 'E';
  }
}

String getGradeStatus(String grade) {
  if (grade == 'A' || grade == 'B' || grade == 'C') {
    return 'pass';
  } else {
    return 'fail';
  }
}

int getNumberOfPatientBasedOnBmiStatus(List<patientModel> patient, List<BmiModel> bmi, String status){
  List<double> bmiData = [];
  for (int i = 0; i < patient.length; i++) {
    DateTime? date;
    double bmi2 = 0;
    for (int j = 0; j < bmi.length; j++) {
      if (patient[i].healthId == bmi[j].healthId) {
        if (date == null || date.isBefore(bmi[j].createdAt)) {
          date = bmi[j].createdAt;
          bmi2 = bmi[j].bmiData;
        }
      }
    }
    bmiData.add(bmi2);
  }

  int total1 = 0;
  int total2 = 0;
  int total3 = 0;
  int total4 = 0;
  int total5 = 0;
  int total6 = 0;
  int total7 = 0;
  int total8 = 0;
  int total9 = 0;
  for (int i = 0; i < bmiData.length; i++) {
    if (bmiData[i] < 16) {
      total1 = total1 + 1;
    } else if (bmiData[i] < 17) {
      total2 = total2 + 1;
    } else if (bmiData[i] < 18.5) {
      total3 = total3 + 1;
    } else if (bmiData[i] < 25) {
      total4 = total4 + 1;
    } else if (bmiData[i] < 30) {
      total5 = total5 + 1;
    } else if (bmiData[i] < 35) {
      total6 = total6 + 1;
    } else if (bmiData[i] < 40) {
      total7 = total7 + 1;
    } else if (bmiData[i] >= 40) {
      total8 = total8 + 1;
    } else {
      total9 = total9 + 1;
    }
  }

  if (status == 'Severe Thinness'){
    return total1;
  }else if (status == 'Moderate Thinness'){
    return total2;
  }else if (status == 'Mild Thinness'){
    return total3;
  }else if (status == 'Normal'){
    return total4;
  }else if (status == 'Overweight'){
    return total5;
  }else if (status == 'Obese Class I'){
    return total6;
  }else if (status == 'Obese Class II'){
    return total7;
  }else if (status == 'Obese Class III'){
    return total8;
  }else if (status == 'No Status'){
    return total9;
  }else{
    return 0;
  }
}
