part of 'store_time_cubit.dart';

 class StoreTimeState extends Equatable {
   final RequestState addStoreTimeState;
  const StoreTimeState({
    this.addStoreTimeState =  RequestState.initial,
 });
  StoreTimeState copyWith({RequestState? addStoreTimeState}) {
    return StoreTimeState(
      addStoreTimeState: addStoreTimeState ?? this.addStoreTimeState,
    );
  }

  @override
  List<Object> get props => [addStoreTimeState];
}

final class StoreTimeInitial extends StoreTimeState {}
