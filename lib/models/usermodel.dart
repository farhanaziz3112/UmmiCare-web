class UserModel {
  final String userId;
  late final String userType;
  late final String userName;
  late final String userFirstname;
  late final String userLastname;
  late final String userEmail;
  late final String userPhoneNumber;
  late final String userProfileImg;

  UserModel(
      {required this.userId,
      required this.userType,
      required this.userName,
      required this.userFirstname,
      required this.userLastname,
      required this.userEmail,
      required this.userPhoneNumber,
      required this.userProfileImg});
}

class UserAuthModel {
  final String userId;

  UserAuthModel(
    {required this.userId}
  );
}
