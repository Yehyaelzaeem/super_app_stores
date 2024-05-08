part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}
class BankAccountLoadingState extends AccountState {}
class BankAccountSuccessState extends AccountState {}
class BankAccountErrorState extends AccountState {}
class PassAccountDataState extends AccountState {}
class RemoveAccountDataState extends AccountState {}
class PickImageState extends AccountState {}
class UploadFileLoadingState extends AccountState {}
class UploadFileLSuccessState extends AccountState {}
class UploadFileErrorState extends AccountState {}
class GetDataSuccessState extends AccountState {
  final String data;
  GetDataSuccessState({required this.data});
}
class GetDataErrorState extends AccountState {}
class GetDataLoadingState extends AccountState {}
