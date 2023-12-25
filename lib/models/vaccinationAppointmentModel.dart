class VaccincationAppointmentModel {
  final String vaccincationAppointmentModel;
  late final String vaccineType;
  late final String vaccineTime;
  late final String clinicId;
  late final String doctorId;
  late final String healthId;

  VaccincationAppointmentModel({
    required this.vaccincationAppointmentModel,
    required this.vaccineType,
    required this.vaccineTime,
    required this.clinicId,
    required this.doctorId,
    required this.healthId,
  });
}