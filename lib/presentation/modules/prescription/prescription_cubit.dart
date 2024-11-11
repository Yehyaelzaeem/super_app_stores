import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../../data/model/response/prescription_model.dart';
import '../../../../../../domain/usecase/account/prescription_usecase.dart';
import '../../../core/utils/toast_states/enums.dart';
import '../../../data/model/response/send_prescription_params.dart';
import '../../../domain/usecase/account/send_price_prescription_usecase.dart';

part 'prescription_state.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  final PrescriptionUseCase _prescriptionUseCase;
  final SendPricePrescriptionUseCase _sendPricePrescriptionUseCase;
  PrescriptionCubit({
    required PrescriptionUseCase prescriptionUseCase,
    required SendPricePrescriptionUseCase sendPricePrescriptionUseCase,
  }) :
       _prescriptionUseCase=prescriptionUseCase,
       _sendPricePrescriptionUseCase=sendPricePrescriptionUseCase,
        super(PrescriptionInitial());

  PrescriptionModel? prescriptionModel;
  Future<void> getPrescription() async {
    prescriptionModel = null;
    emit(PrescriptionLoading());
    try {
      final response = await _prescriptionUseCase.call();
      if (response.isSuccess) {
        prescriptionModel = response.data;
        emit(PrescriptionSuccess());
      } else {
        emit(PrescriptionError());
      }
    } catch (e) {
      emit(PrescriptionError());
    }
  }
  Future<void> sendPricePrescription({required SendPrescriptionParams params,required BuildContext context}) async {
    emit(SendPrescriptionLoading());
    try {
      final response = await _sendPricePrescriptionUseCase.call(sendPrescriptionParams: params);

      if (response.isSuccess) {
        showToast(text: response.message.toString(), state: ToastStates.success, context: context);
        Navigator.pop(context);
        emit(SendPrescriptionSuccess());
      } else {
        emit(SendPrescriptionError());
      }
    } catch (e) {
      emit(SendPrescriptionError());
    }

  }
}