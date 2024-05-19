import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/styles.dart';
import '../../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../../core/resources/decoration.dart';
import '../../../../../../../core/routing/routes.dart';
import '../../../../../../component/custom_app_bar.dart';
import '../../../../../../component/custom_elevated_button.dart';
import '../../../../../../component/custom_text_field.dart';
import '../../../../../../component/images/custom_image.dart';
import '../profile_cubit.dart';

class EditProviderProfileScreen extends StatelessWidget {
  const EditProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit =ProfileCubit.get(context);
    cubit.pushProfileData();
    return
      Scaffold(
      backgroundColor: backGroundGray,
      appBar:  CustomAppBar(
        color: backGroundGray,
        title: LocaleKeys.editProfile.tr(),
      ),
      body:
      BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if(cubit.profileModel!=null){
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              verticalSpace(20),
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                          height: 115.h,
                                          width: 115.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(60),
                                              boxShadow: const [BoxShadow(color: Colors.black26,blurRadius: 3,
                                                  offset: Offset(2,4)
                                              )]
                                          ),
                                          child:  cubit.imageFile!=null?
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(60),
                                            child: Image.file(cubit.imageFile!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                              :
                                          CustomImage(image: cubit.profileModel!.image!,radius: 60,)
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child:
                                        CircleAvatar(
                                          radius: 18,
                                          backgroundColor: whiteColor,
                                          child: Center(
                                            child: IconButton(
                                                onPressed: (){
                                                  cubit.pickImage();
                                                },
                                                icon: const Icon(Icons.camera_alt,size: 20,color: backBlue2,)),
                                          ),
                                        ),)
                                    ],
                                  ),
                                  Text(
                                    '${cubit.profileModel!.firstName??''} ali${cubit.profileModel!.lastName??''}',
                                    style: TextStyles.font20Black700Weight,
                                  ),
                                  // Text(
                                  //   'تاجر',
                                  //   style: TextStyles.font14White500Weight
                                  //       .copyWith(color: customGray),
                                  // ),
                                ],
                              ),
                              verticalSpace(50),
                              CustomTextField(
                                prefixIcon:  const Icon(Icons.person,color: Colors.grey,),
                                hintText: LocaleKeys.firstName.tr(),
                                hintStyle: TextStyles.font16Black500Weight.copyWith(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w600
                                ),
                                fillColor: whiteColor,
                                controller: cubit.firstNameController,
                                borderRadius: 40,
                                borderColor: Colors.grey.shade400,
                              ),
                              verticalSpace(20),
                              CustomTextField(
                                prefixIcon:  const Icon(Icons.person,color: Colors.grey,),
                                hintText: LocaleKeys.lastName.tr(),
                                hintStyle: TextStyles.font16Black500Weight.copyWith(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w600
                                ),
                                fillColor: whiteColor,
                                controller: cubit.lastNameController,
                                borderRadius: 40,
                                borderColor: Colors.grey.shade400,
                              ),
                              verticalSpace(20),
                              CustomTextField(
                                prefixIcon:  const Icon(Icons.phone_android,color: Colors.grey,),
                                hintText: LocaleKeys.phone.tr(),
                                hintStyle: TextStyles.font16Black500Weight.copyWith(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w600
                                ),
                                fillColor: whiteColor,
                                controller: cubit.phoneController,
                                borderRadius: 40,
                                borderColor: Colors.grey.shade400,
                              ),
                              verticalSpace(70),
                              Container(
                                height: 43,
                                decoration: Decorations.backGroundDecorationButton().copyWith(
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: CustomElevatedButton(
                                  backgroundColor: Colors.transparent,
                                  onTap: (){
                                    cubit.updateProfile();
                                    if(cubit.imageFile!=null){
                                      cubit.updateImageProfile();
                                    }
                                  },
                                  buttonText:LocaleKeys.update.tr(),
                                  width: MediaQuery.of(context).size.width*0.5,
                                  height: 35,
                                  fontSize: 17,
                                  borderRadius: 40,
                                ),
                              ),
                              verticalSpace(20),

                              // Container(
                              //   height: 43,
                              //   decoration: Decorations.backGroundDecorationButton().copyWith(
                              //       borderRadius: BorderRadius.circular(40)
                              //   ),
                              //   child: CustomElevatedButton(
                              //     backgroundColor: Colors.transparent,
                              //     onTap: (){
                              //       context.pushNamed(Routes.changeProfilePasswordScreen);
                              //     },
                              //     buttonText:'تحديث كلمة المرور',
                              //     width: MediaQuery.of(context).size.width*0.5,
                              //     height: 35,
                              //     fontSize: 17,
                              //     borderRadius: 40,
                              //   ),
                              // ),
                              // verticalSpace(70),


                            ],
                          ),
                        ),
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator(),);
                    }

                  },
                ),
    );
  }
}
