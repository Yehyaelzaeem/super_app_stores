import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/styles.dart';
import '../../../component/custom_text_field.dart';
import '../../../component/google_map/custom_google_map.dart';
import '../branch_cubit.dart';

class BranchDataWidget extends StatelessWidget {
  const BranchDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BranchCubit cubit =BranchCubit.get();
    return BlocConsumer<BranchCubit, BranchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: cubit.addBranchKey,
          child: Column(
            children: [
              verticalSpace(20),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CustomTextField(
                      validationFunc: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.requiredField.tr();
                        }
                        return null;
                      },
                      prefixIcon:  const Icon(Icons.menu,color: Colors.grey,),
                      hintText: LocaleKeys.branchNameEN.tr(),
                      hintStyle: TextStyles.font16Black500Weight.copyWith(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600
                      ),
                      fillColor: whiteColor,
                      controller: cubit.storeName,
                      borderRadius: 40,
                      borderColor: Colors.grey.shade400,
                    ),
                    verticalSpace(20),
                    CustomTextField(
                      validationFunc: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.requiredField.tr();
                        }
                        return null;
                      },
                      prefixIcon:  const Icon(Icons.menu,color: Colors.grey,),
                      hintText: LocaleKeys.branchNameAR.tr(),
                      hintStyle: TextStyles.font16Black500Weight.copyWith(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600
                      ),
                      fillColor: whiteColor,
                      controller: cubit.storeNameAr,
                      borderRadius: 40,
                      borderColor: Colors.grey.shade400,
                    ),
                    // CustomTextField(
                    //   textInputType: TextInputType.emailAddress,
                    //   validationFunc: (value) {
                    //     // if (value == null || value.isEmpty) {
                    //     //   return LocaleKeys.requiredField.tr();
                    //     // }
                    //     return null;
                    //   },
                    //   prefixIcon:  const Icon(Icons.email,color: Colors.grey,),
                    //   hintText:LocaleKeys.email.tr(),
                    //   hintStyle: TextStyles.font16Black500Weight.copyWith(
                    //       color: Colors.grey.shade500,
                    //       fontWeight: FontWeight.w600
                    //   ),
                    //   fillColor: whiteColor,
                    //   controller: cubit.storeEmail,
                    //   borderRadius: 40,
                    //   borderColor: Colors.grey.shade400,
                    // ),
                    verticalSpace(20),
                    CustomTextField(
                      textInputType: TextInputType.phone,
                      validationFunc: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.requiredField.tr();
                        }
                        return null;
                      },
                      prefixIcon:  const Icon(Icons.phone_android,color: Colors.grey,),
                      hintText: LocaleKeys.phone.tr(),
                      hintStyle: TextStyles.font16Black500Weight.copyWith(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600
                      ),
                      fillColor: whiteColor,
                      controller: cubit.storePhone,
                      borderRadius: 40,
                      borderColor: Colors.grey.shade400,
                    ),
                    verticalSpace(20),
                    CustomTextField(
                      validationFunc: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.requiredField.tr();
                        }
                        return null;
                      },
                      prefixIcon:  const Icon(Icons.location_city,color: Colors.grey,),
                      hintText: LocaleKeys.address.tr(),
                      hintStyle: TextStyles.font16Black500Weight.copyWith(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600
                      ),
                      suffixIcon: IconButton(onPressed: (){},
                        icon: const Icon(Icons.location_city,color: Colors.grey,),),
                      fillColor: whiteColor,
                      controller: cubit.storeAddress,
                      borderRadius: 40,
                      borderColor: Colors.grey.shade400,
                    ),
                    verticalSpace(20),
                    InkWell(
                      onTap: (){
                        if(cubit.lat!=null&&cubit.long!=null){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                              CustomGoogleMapScreen(
                                lat: cubit.lat!,
                                long: cubit.long!,
                              )));
                        }else{
                          cubit.getLocation(context).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                CustomGoogleMapScreen(
                                  lat: cubit.lat!,
                                  long: cubit.long!,
                                )));
                          });
                        }
                      },
                      child: CustomTextField(
                        validationFunc: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.requiredField.tr();
                          }
                          return null;
                        },
                        enabled: false,
                        fontSize: 10.sp,
                        prefixIcon:  const Icon(Icons.location_on,color: Colors.grey,),
                        hintText: LocaleKeys.location.tr(),
                        hintStyle: TextStyles.font16Black500Weight.copyWith(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w600
                        ),
                        suffixIcon: IconButton(onPressed: (){},icon: const Icon(Icons.location_on_outlined,color: Colors.grey,),),
                        fillColor: whiteColor,
                        controller: cubit.storeLocation,
                        borderRadius: 40,
                        borderColor: Colors.grey.shade400,
                      ),
                    ),
                    verticalSpace(20),
                    // cubit.regionsModel!=null?
                    // StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
                    //   return DropdownButton2<String>(
                    //     isExpanded: true,
                    //     underline: const SizedBox.shrink(),
                    //     hint: Text(cubit.valueData ?? '', style:  TextStyle(fontSize: 14, color: Colors.grey.shade700,fontWeight: FontWeight.w700),),
                    //     items: cubit.regionsModel!.data!.map(( e) => DropdownMenuItem<String>(
                    //       value: e.name,
                    //       child: Text(
                    //         e.name!,
                    //         style: const TextStyle(fontSize: 14),
                    //       ),
                    //     )).toList(),
                    //     onChanged: (String? value) {
                    //       setState(() {
                    //         cubit.valueData = value!;
                    //         for(var a in cubit.regionsModel!.data! ){
                    //           if(cubit.valueData==a.name){
                    //             cubit.regionsId=a.id!;
                    //             break;
                    //           }
                    //         }
                    //       });
                    //     },
                    //     buttonStyleData: ButtonStyleData(
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           border: Border.all(color: Colors.grey),
                    //           borderRadius: BorderRadius.circular(50.r),
                    //         ),
                    //         padding: EdgeInsets.symmetric(horizontal: 16.w) // Adjust the horizontal padding as needed
                    //
                    //     ),
                    //
                    //   );
                    // }):
                    // const SizedBox.shrink(),
                    // verticalSpace(20),
                    // CustomTextField(
                    //   validationFunc: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return LocaleKeys.requiredField.tr();
                    //     }
                    //     return null;
                    //   },
                    //   prefixIcon:  const Icon(Icons.timer_outlined,color: Colors.grey,),
                    //   hintText: LocaleKeys.deliveryTime.tr(),
                    //   hintStyle: TextStyles.font16Black500Weight.copyWith(
                    //       color: Colors.grey.shade500,
                    //       fontWeight: FontWeight.w600
                    //   ),
                    //   textInputType: TextInputType.number,
                    //   textInputAction: TextInputAction.done,
                    //   fillColor: whiteColor,
                    //   controller: cubit.storeTime,
                    //   borderRadius: 40,
                    //   borderColor: Colors.grey.shade400,
                    // ),

                  ],
                ),
              )

            ],
          ),
        );
      },
    );
  }
}
