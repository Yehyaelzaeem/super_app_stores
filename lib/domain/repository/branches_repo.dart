
import 'dart:io';

import '../../data/model/base/api_response.dart';
import '../request_body/add_branch_body.dart';
import '../request_body/profile_body.dart';


mixin BranchesRepository {
  Future<ApiResponse> getBranches() ;
  Future<ApiResponse> getRegions() ;
  Future<ApiResponse> addBranch({required AddBranchBody addBranchBody}) ;
  Future<ApiResponse> updateBranch({required AddBranchBody addBranchBody,required int branchId}) ;
  Future<ApiResponse> deleteBranch({required int branchId}) ;


}
