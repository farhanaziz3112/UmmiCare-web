String convertTimeToDate(String timeInMilliseconds) {
  int temp = int.parse(timeInMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(temp);
  return date.day.toString() +
      " - " +
      date.month.toString() +
      " - " +
      date.year.toString();
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
