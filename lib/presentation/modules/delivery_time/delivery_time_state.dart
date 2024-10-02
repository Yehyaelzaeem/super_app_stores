part of 'delivery_time_cubit.dart';

class DeliveryTimeState extends Equatable {
  final RequestState addDeliveryTimeState;
  const DeliveryTimeState({
    this.addDeliveryTimeState =  RequestState.initial,
  });
  DeliveryTimeState copyWith({RequestState? addDeliveryTimeState}) {
    return DeliveryTimeState(
      addDeliveryTimeState: addDeliveryTimeState ?? this.addDeliveryTimeState,
    );
  }

  @override
  List<Object> get props => [addDeliveryTimeState];
}

final class DeliveryTimeInitial extends DeliveryTimeState {}
