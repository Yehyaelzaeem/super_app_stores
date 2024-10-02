import 'package:json_annotation/json_annotation.dart';

class TimeParams {
  String? sunday;
  String? suServiceOpenTime;
  String? suServiceCloseTime;
  String? monday;
  String? moServiceOpenTime;
  String? moServiceCloseTime;
  String? tuesday;
  String? tuServiceOpenTime;
  String? tuServiceCloseTime;
  String? wednesday;
  String? weServiceOpenTime;
  String? weServiceCloseTime;
  String? thursday;
  String? thServiceOpenTime;
  String? thServiceCloseTime;
  String? friday;
  String? frServiceOpenTime;
  String? frServiceCloseTime;
  String? saturday;
  String? saServiceOpenTime;
  String? saServiceCloseTime;

  TimeParams({
    this.sunday,
    this.suServiceOpenTime,
    this.suServiceCloseTime,
    this.monday,
    this.moServiceOpenTime,
    this.moServiceCloseTime,
    this.tuesday,
    this.tuServiceOpenTime,
    this.tuServiceCloseTime,
    this.wednesday,
    this.weServiceOpenTime,
    this.weServiceCloseTime,
    this.thursday,
    this.thServiceOpenTime,
    this.thServiceCloseTime,
    this.friday,
    this.frServiceOpenTime,
    this.frServiceCloseTime,
    this.saturday,
    this.saServiceOpenTime,
    this.saServiceCloseTime,
  });

  // Manually writing fromJson method
  factory TimeParams.fromJson(Map<String, dynamic> json) {
    return TimeParams(
      sunday: json['sunday'] as String?,
      suServiceOpenTime: json['su_service_open_time'] as String?,
      suServiceCloseTime: json['su_service_close_time'] as String?,
      monday: json['monday'] as String?,
      moServiceOpenTime: json['mo_service_open_time'] as String?,
      moServiceCloseTime: json['mo_service_close_time'] as String?,
      tuesday: json['tuesday'] as String?,
      tuServiceOpenTime: json['tu_service_open_time'] as String?,
      tuServiceCloseTime: json['tu_service_close_time'] as String?,
      wednesday: json['wednesday'] as String?,
      weServiceOpenTime: json['we_service_open_time'] as String?,
      weServiceCloseTime: json['we_service_close_time'] as String?,
      thursday: json['thursday'] as String?,
      thServiceOpenTime: json['th_service_open_time'] as String?,
      thServiceCloseTime: json['th_service_close_time'] as String?,
      friday: json['friday'] as String?,
      frServiceOpenTime: json['fr_service_open_time'] as String?,
      frServiceCloseTime: json['fr_service_close_time'] as String?,
      saturday: json['saturday'] as String?,
      saServiceOpenTime: json['sa_service_open_time'] as String?,
      saServiceCloseTime: json['sa_service_close_time'] as String?,
    );
  }

  // Manually writing toJson method
  Map<String, dynamic> toJson() {
    return {
      'sunday': sunday,
      'su_service_open_time': suServiceOpenTime,
      'su_service_close_time': suServiceCloseTime,
      'monday': monday,
      'mo_service_open_time': moServiceOpenTime,
      'mo_service_close_time': moServiceCloseTime,
      'tuesday': tuesday,
      'tu_service_open_time': tuServiceOpenTime,
      'tu_service_close_time': tuServiceCloseTime,
      'wednesday': wednesday,
      'we_service_open_time': weServiceOpenTime,
      'we_service_close_time': weServiceCloseTime,
      'thursday': thursday,
      'th_service_open_time': thServiceOpenTime,
      'th_service_close_time': thServiceCloseTime,
      'friday': friday,
      'fr_service_open_time': frServiceOpenTime,
      'fr_service_close_time': frServiceCloseTime,
      'saturday': saturday,
      'sa_service_open_time': saServiceOpenTime,
      'sa_service_close_time': saServiceCloseTime,
    };
  }
}
