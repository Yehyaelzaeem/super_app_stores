import 'package:json_annotation/json_annotation.dart'; 

part 'time_params.g.dart'; 

@JsonSerializable(ignoreUnannotated: false)
class TimeParams {
  @JsonKey(name: 'sunday')
  String? sunday;
  @JsonKey(name: 'su_service_open_time')
  String? suServiceOpenTime;
  @JsonKey(name: 'su_service_close_time')
  String? suServiceCloseTime;
  @JsonKey(name: 'monday')
  String? monday;
  @JsonKey(name: 'mo_service_open_time')
  String? moServiceOpenTime;
  @JsonKey(name: 'mo_service_close_time')
  String? moServiceCloseTime;
  @JsonKey(name: 'tuesday')
  String? tuesday;
  @JsonKey(name: 'tu_service_open_time')
  String? tuServiceOpenTime;
  @JsonKey(name: 'tu_service_close_time')
  String? tuServiceCloseTime;
  @JsonKey(name: 'wednesday')
  String? wednesday;
  @JsonKey(name: 'we_service_open_time')
  String? weServiceOpenTime;
  @JsonKey(name: 'we_service_close_time')
  String? weServiceCloseTime;
  @JsonKey(name: 'thursday')
  String? thursday;
  @JsonKey(name: 'th_service_open_time')
  String? thServiceOpenTime;
  @JsonKey(name: 'th_service_close_time')
  String? thServiceCloseTime;
  @JsonKey(name: 'friday')
  String? friday;
  @JsonKey(name: 'fr_service_open_time')
  String? frServiceOpenTime;
  @JsonKey(name: 'fr_service_close_time')
  String? frServiceCloseTime;
  @JsonKey(name: 'saturday')
  String? saturday;
  @JsonKey(name: 'sa_service_open_time')
  String? saServiceOpenTime;
  @JsonKey(name: 'sa_service_close_time')
  String? saServiceCloseTime;

  TimeParams({this.sunday, this.suServiceOpenTime, this.suServiceCloseTime, this.monday, this.moServiceOpenTime, this.moServiceCloseTime, this.tuesday, this.tuServiceOpenTime, this.tuServiceCloseTime, this.wednesday, this.weServiceOpenTime, this.weServiceCloseTime, this.thursday, this.thServiceOpenTime, this.thServiceCloseTime, this.friday, this.frServiceOpenTime, this.frServiceCloseTime, this.saturday, this.saServiceOpenTime, this.saServiceCloseTime});

   factory TimeParams.fromJson(Map<String, dynamic> json) => _$TimeParamsFromJson(json);

   Map<String, dynamic> toJson() => _$TimeParamsToJson(this);
}

