import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/routing/routes.dart';
import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/branches/branch_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color.dart';
import '../../../../core/resources/styles.dart';
import '../../../../data/model/response/branches_model.dart';
import '../../../component/google_map/custom_google_map.dart';

class CustomBranchItemWidget extends StatelessWidget {
  const CustomBranchItemWidget({super.key, required this.branchesModel});
 final BranchesModelData branchesModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child:
      Container(
        color: whiteColor,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
          child: Column(
            children: [
              Row(
                children: [
                  Text(branchesModel.name.toString(),style: TextStyles.font18Black700Weight.copyWith(
                      color: backBlue2
                  ),),
                  const Spacer(),
                  IconButton(
                      onPressed: (){
                        context.pushNamed(Routes.editBranchScreen,arguments: {'branchesModelData':branchesModel});
                      },
                      icon: const Icon(Icons.edit_calendar_outlined)),
                  IconButton(
                      onPressed: (){
                        BranchCubit.get().deleteBranch( branchId: branchesModel.id!, context: context);
                      },
                      icon: const Icon(Icons.delete,color: redColor,))

                ],
              ),
              Row(
                children: [
                  Text(branchesModel.address.toString(),style: TextStyles.font18Black700Weight.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15
                  )),
                  const Spacer(),
                  InkWell(
                    onTap: (){
                          if(branchesModel.lat!=null&&branchesModel.lng!=null){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                          CustomGoogleMapScreen(
                          lat: double.parse(branchesModel.lat!),
                          long:double.parse(branchesModel.lng!),
                           )));
                          }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.location_on,color: backBlue2,size: 25,),
                        Text(LocaleKeys.onMap.tr(),style: TextStyles.font18Black700Weight.copyWith(
                            color: backBlue2,
                            fontWeight: FontWeight.w600
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
