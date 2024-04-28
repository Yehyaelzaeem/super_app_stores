import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'provider_home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
}
