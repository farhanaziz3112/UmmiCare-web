class medicalStaffModel {
  final String medicalStaffId;
  late final String medicalStaffCreatedDate;
  late final String medicalStaffFullName;
  late final String medicalStaffFirstName;
  late final String medicalStaffLastName;
  late final String medicalStaffEmail;
  late final String medicalStaffPhoneNumber;
  late final String medicalStaffProfileImg;

  medicalStaffModel({
    required this.medicalStaffId,
    required this.medicalStaffCreatedDate,
    required this.medicalStaffFullName,
    required this.medicalStaffFirstName,
    required this.medicalStaffLastName,
    required this.medicalStaffEmail,
    required this.medicalStaffPhoneNumber,
    required this.medicalStaffProfileImg,
  });

}

class ClinicModel {
  final String clinicId;
  late final String clinicName;
  late final String clinicAddress;
  late final String clinicPhoneNumber;

  ClinicModel({
    required this.clinicId,
    required this.clinicName,
    required this.clinicAddress,
    required this.clinicPhoneNumber,
  });
}

class DoctorModel {
  final String doctorId;
  late final String doctorFullName;
  late final String doctorPhoneNumber;

  DoctorModel({
    required this.doctorId,
    required this.doctorFullName,
    required this.doctorPhoneNumber,
  });
}