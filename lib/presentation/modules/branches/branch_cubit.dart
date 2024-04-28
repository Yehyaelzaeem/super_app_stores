import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/utils/toast_states/enums.dart';
import 'package:cogina_restaurants/domain/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/branches_model.dart';
import '../../../data/model/response/regions_model.dart';
import '../../../domain/request_body/add_branch_body.dart';
import '../../../domain/usecase/branches/add_branch_usecase.dart';
import '../../../domain/usecase/branches/delete_branch_usecase.dart';
import '../../../domain/usecase/branches/get_branches_usecase.dart';
import '../../../domain/usecase/branches/get_regions_usecase.dart';
import '../../../domain/usecase/branches/update_branch_usecase.dart';
import '../../component/google_map/address_location_model.dart';
part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final GetBranchesUseCase _getBranchesUseCase;
  final AddBranchUseCase _addBranchUseCase;
  final GetRegionsUseCase _getRegionsUseCase;
  final UpdateBranchUseCase _updateBranchUseCase;
  final DeleteBranchUseCase _deleteBranchUseCase;
  BranchCubit({required GetBranchesUseCase getBranchesUseCase,required UpdateBranchUseCase updateBranchUseCase,required DeleteBranchUseCase deleteBranchUseCase,required AddBranchUseCase addBranchUseCase,required GetRegionsUseCase getRegionsUseCase}) :
        _deleteBranchUseCase=deleteBranchUseCase,
        _addBranchUseCase=addBranchUseCase,
        _updateBranchUseCase=updateBranchUseCase,
        _getRegionsUseCase=getRegionsUseCase,
        _getBranchesUseCase=getBranchesUseCase, super(BranchInitial()){
    getRegions();
  }
  static BranchCubit get(BuildContext context )=>BlocProvider.of(context);
  TextEditingController storeName =TextEditingController();
  TextEditingController storeEmail =TextEditingController();
  TextEditingController storePhone =TextEditingController();
  TextEditingController storeAddress =TextEditingController();
  TextEditingController storeLocation =TextEditingController();
  TextEditingController storeTime =TextEditingController();
  final addBranchKey = GlobalKey<FormState>();



  Future<ResponseModel> getBranches() async {
    emit(GetBranchesLoadingState()) ;
    ResponseModel responseModel = await _getBranchesUseCase.call();
    if (responseModel.isSuccess) {
      branchesModel=responseModel.data;
      emit(GetBranchesSuccessState()) ;
    }else{
      emit(GetBranchesErrorState()) ;
    }
    return responseModel;
  }
  String? valueData='المنطقة';
  String? regionsData;
  int? regionsId;
  RegionsModel? regionsModel;
  Future<ResponseModel> getRegions() async {
    emit(GetRegionsLoadingState()) ;
    ResponseModel responseModel = await _getRegionsUseCase.call();
    if (responseModel.isSuccess) {
      regionsModel=responseModel.data;
      emit(GetRegionsSuccessState()) ;
    }else{
      emit(GetRegionsErrorState()) ;
    }
    return responseModel;
  }

  BranchesModel? branchesModel;
  Future<dynamic> addBranch(BuildContext context) async {
   if(addBranchKey.currentState!.validate()){
     if(regionsId!=null){
       emit(AddBranchLoadingState()) ;
       AddBranchBody addBranchBody =AddBranchBody(
           name: storeName.text, email: storeEmail.text,
           phone: storePhone.text, address: storeAddress.text,
           lat: addressLocationModel!=null?addressLocationModel!.lat:'', lng: addressLocationModel!=null?addressLocationModel!.long:'',
           regionId: regionsId!=null?regionsId!.toString():'', deliveryTime: storeTime.text);
       ResponseModel responseModel = await _addBranchUseCase.call(addBranchBody: addBranchBody);
       if (responseModel.isSuccess) {
         Future.delayed(const Duration(microseconds: 0)).then((value) {
           showToast(text: responseModel.message.toString(), state: ToastStates.success, context: context);
           getBranches();
           context.pop();
         });
         emit(AddBranchSuccessState()) ;
       }else{
         emit(AddBranchErrorState());
       }
     }
     else{
       showToast(text: 'choose the region', state: ToastStates.error, context: context);
     }
     }
  }
  Future<dynamic> updateBranch({required int branchId,required BuildContext context}) async {
   if(addBranchKey.currentState!.validate()){
     if(regionsId!=null){
       emit(UpdateBranchLoadingState()) ;
       AddBranchBody addBranchBody =AddBranchBody(
           name: storeName.text, email: storeEmail.text,
           phone: storePhone.text, address: storeAddress.text,
           lat: addressLocationModel!=null?addressLocationModel!.lat:'', lng: addressLocationModel!=null?addressLocationModel!.long:'',
           regionId: regionsId!=null?regionsId!.toString():'', deliveryTime: storeTime.text);
       ResponseModel responseModel = await _updateBranchUseCase.call(addBranchBody: addBranchBody, branchId: branchId);
       if (responseModel.isSuccess) {
         Future.delayed(const Duration(microseconds: 0)).then((value) {
           showToast(text: responseModel.message.toString(), state: ToastStates.success, context: context);
           getBranches();
           context.pop();
         });
         emit(UpdateBranchSuccessState()) ;
       }else{
         emit(UpdateBranchErrorState());
       }
     }
     else{
       showToast(text: 'choose the region', state: ToastStates.error, context: context);
     }
     }
  }
  Future<dynamic> deleteBranch({required int branchId, required BuildContext context}) async {
    emit(DeleteBranchLoadingState()) ;
    ResponseModel responseModel = await _deleteBranchUseCase.call(branchId: branchId);
    if (responseModel.isSuccess) {
      Future.delayed(const Duration(microseconds: 0)).then((value) {
        showToast(text: responseModel.message.toString(), state: ToastStates.success, context: context);
        getBranches();
      });
      emit(DeleteBranchSuccessState()) ;
    }else{
      emit(DeleteBranchErrorState()) ;
    }
    return responseModel;
  }


/// Get Location form Google Map
  double? lat;
  double? long;
  Position? p ;
  AddressLocationModel? addressLocationModel;
  Future<void> getLocation(context)async{
    p =await Geolocator.getCurrentPosition().then((Position value) {
      lat=value.latitude;
      long=value.longitude;
      emit(GetPositionState());
      return null;
    });
  }
  Future<void> getLocationAddress(BuildContext context)async{
    storeLocation.text='${addressLocationModel!.country}/${addressLocationModel!.bigCity}/${addressLocationModel!.city}/${addressLocationModel!.street}';
    emit(GetPositionState());
    context.pop();
  }

}
