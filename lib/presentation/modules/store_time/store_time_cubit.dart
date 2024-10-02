import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'store_time_state.dart';

class StoreTimeCubit extends Cubit<StoreTimeState> {
  StoreTimeCubit() : super(StoreTimeInitial());
}
