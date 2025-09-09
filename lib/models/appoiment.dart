import 'service.dart';

class Appointment {
  final String id;
  final Service service;
  final DateTime dateTime;
  final String stylist;

  Appointment(
      {required this.id,
      required this.service,
      required this.dateTime,
      required this.stylist});
}
