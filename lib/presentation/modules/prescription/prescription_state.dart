part of 'prescription_cubit.dart';

@immutable
sealed class PrescriptionState {}

final class PrescriptionInitial extends PrescriptionState {}
final class PrescriptionLoading extends PrescriptionState {}
final class PrescriptionError extends PrescriptionState {}
final class PrescriptionSuccess extends PrescriptionState {}
final class SendPrescriptionSuccess extends PrescriptionState {}
final class SendPrescriptionLoading extends PrescriptionState {}
final class SendPrescriptionError extends PrescriptionState {}

