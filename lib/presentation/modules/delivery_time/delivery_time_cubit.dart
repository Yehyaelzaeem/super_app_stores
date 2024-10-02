import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delivery_time_state.dart';

class DeliveryTimeCubit extends Cubit<DeliveryTimeState> {
  DeliveryTimeCubit() : super(DeliveryTimeInitial());
}
