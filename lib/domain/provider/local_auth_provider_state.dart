import 'package:cogina_restaurants/core/utils/toast_states/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../presentation/component/google_map/address_location_model.dart';

class LocalAuthState extends Equatable {
  ///Variables
  bool isLogin = false;
  bool loading = false;
  String? error;
  LatLng? latLng;
  RequestState? pickUpState;
  AddressLocationModel? addressLocationModel;

  LocalAuthState({
    this.isLogin = false,
    this.loading = false,
    this.error,
    this.pickUpState=RequestState.initial,
    this.addressLocationModel,
    this.latLng,
  });

  LocalAuthState copyWith({
    bool? isLogin,
    bool? loading,
    String? error,
      RequestState? pickUpState,
    LatLng? latLng,
    AddressLocationModel? addressLocationModel,
  }) {
    return LocalAuthState()
      ..isLogin = isLogin ?? this.isLogin
      ..loading = loading ?? this.loading
      ..pickUpState = pickUpState ?? this.pickUpState
      ..addressLocationModel = addressLocationModel ?? this.addressLocationModel
      ..latLng = latLng ?? this.latLng
      ..error = error ?? this.error;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isLogin, loading,pickUpState ,error,latLng,addressLocationModel];
}

