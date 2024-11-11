
import 'package:bloc/bloc.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/toast_states/enums.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/time_params.dart';
import '../../../domain/usecase/time/add_store_time_usecase.dart';
import '../layout/screens/account/edit_profile/profile_cubit.dart';

part 'store_time_state.dart';

class StoreTimeCubit extends Cubit<StoreTimeState> {
  final AddStoreTimeUseCase addStoreTimeUseCase;
  StoreTimeCubit({required this.addStoreTimeUseCase}) : super(StoreTimeInitial());

  Future addStoreTime({required TimeParams params ,bool isComplete=false}) async {
    emit(state.copyWith(addStoreTimeState: RequestState.loading));
   try {
     final context = NavigationService.navigationKey.currentContext!;
     ResponseModel responseModel = await addStoreTimeUseCase.call(params: params);
     if (responseModel.isSuccess) {
       showToast(text: responseModel.message.toString(), state: ToastStates.success, context: NavigationService.navigationKey.currentContext!);
       // if(isComplete==true){
       //   // context.pushNamed(Routes.deliveryTimeScreen,arguments: {'isComplete':true});
       // }else{
       //   Navigator.of(context).pop();
       //   ProfileCubit.get(context).getProfile();
       // }
       Navigator.of(context).pop();
       ProfileCubit.get(context).getProfile();
       emit(state.copyWith(addStoreTimeState: RequestState.loaded));
     }
     else {
       showToast(text: responseModel.message.toString(), state: ToastStates.error, context: NavigationService.navigationKey.currentContext!);
       emit(state.copyWith(addStoreTimeState: RequestState.error));
     }
   }
   catch(e){
     emit(state.copyWith(addStoreTimeState: RequestState.error));
   }
  }

}
