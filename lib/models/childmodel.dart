class ChildModel {
  final String childId;
  late final String parentId;
  late final String childName;
  late final String childFirstname;
  late final String childLastname;
  late final String childBirthday;
  late final int childCurrentAge;
  late final String childAgeCategory;
  late final String childProfileImg;

  ChildModel(
      {required this.childId,
      required this.parentId,
      required this.childName,
      required this.childFirstname,
      required this.childLastname,
      required this.childBirthday,
      required this.childCurrentAge,
      required this.childAgeCategory,
      required this.childProfileImg});
}