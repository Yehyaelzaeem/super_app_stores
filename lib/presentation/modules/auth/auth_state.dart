part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class ChangeTypeState extends AuthState {}
class LoginErrorState extends AuthState {
  final ErrorModel? error;
  LoginErrorState(this.error);
}
class LoginSuccessState extends AuthState {}
class LoginLoadingState extends AuthState {}
class OtpLoadingState extends AuthState {}
class OtpSuccessState extends AuthState {}
class OtpErrorState extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {}
class RegisterErrorState extends AuthState {}

class PickImageState extends AuthState {}
class CompleteProfileLoadingState extends AuthState {}
class CompleteProfileSuccessState extends AuthState {}
class CompleteProfileErrorState extends AuthState {}
class RemoveDateState extends AuthState {}