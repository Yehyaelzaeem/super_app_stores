part of 'branch_cubit.dart';

@immutable
abstract class BranchState {}

class BranchInitial extends BranchState {}
class GetBranchesLoadingState extends BranchState {}
class GetBranchesSuccessState extends BranchState {}
class GetBranchesErrorState extends BranchState {}
class GetPositionState extends BranchState {}
class GetRegionsLoadingState extends BranchState {}
class GetRegionsSuccessState extends BranchState {}
class GetRegionsErrorState extends BranchState {}
class AddBranchLoadingState extends BranchState {}
class AddBranchSuccessState extends BranchState {}
class AddBranchErrorState extends BranchState {}
class DeleteBranchLoadingState extends BranchState {}
class DeleteBranchSuccessState extends BranchState {}
class DeleteBranchErrorState extends BranchState {}
class UpdateBranchLoadingState extends BranchState {}
class UpdateBranchSuccessState extends BranchState {}
class UpdateBranchErrorState extends BranchState {}
