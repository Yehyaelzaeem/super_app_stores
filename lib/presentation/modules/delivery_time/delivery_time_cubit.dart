import 'package:bloc/bloc.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/toast_states/enums.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/delivery_time.dart';
import '../../../domain/usecase/time/add_delivery_time_usecase.dart';
import '../layout/screens/account/edit_profile/profile_cubit.dart';

part 'delivery_time_state.dart';

class DeliveryTimeCubit extends Cubit<DeliveryTimeState> {
  final AddDeliveryTimeUseCase addDeliveryTimeUseCase;
  DeliveryTimeCubit({required this.addDeliveryTimeUseCase}) : super(DeliveryTimeInitial());
  Future addDeliveryTime({required DeliveryTimeParams params,bool isComplete=false}) async {
    emit(state.copyWith(addDeliveryTimeState: RequestState.loading));
    try {
      final context = NavigationService.navigationKey.currentContext!;

      ResponseModel responseModel = await addDeliveryTimeUseCase.call(params: params);
      if (responseModel.isSuccess) {
        showToast(text: responseModel.message.toString(), state: ToastStates.success, context: NavigationService.navigationKey.currentContext!);
        if(isComplete==true){
          context.pushNamed(Routes.myFilesScreen,arguments: {'isComplete':true});
        }else{
          Navigator.of(context).pop();
          ProfileCubit.get(context).getProfile();        }

        emit(state.copyWith(addDeliveryTimeState: RequestState.loaded));
      }
      else {
        showToast(text: responseModel.message.toString(), state: ToastStates.error, context: NavigationService.navigationKey.currentContext!);
        emit(state.copyWith(addDeliveryTimeState: RequestState.error));
      }
    }
    catch(e){
      emit(state.copyWith(addDeliveryTimeState: RequestState.error));
    }
  }

}
