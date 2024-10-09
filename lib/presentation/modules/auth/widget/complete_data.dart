import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
import 'package:cogina_restaurants/presentation/modules/auth/widget/restuaran_categories_widget.dart';
import 'package:cogina_restaurants/presentation/modules/auth/widget/restuaran_type_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/styles.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/resources/decoration.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../domain/provider/local_auth_provider_cubit.dart';
import '../../../component/custom_elevated_button.dart';
import '../../../component/custom_text_field.dart';
import '../../../component/drop_down.dart';
import '../../../component/google_map/address_location_model.dart';
import '../../../component/google_map/pick_up_google_map.dart';
import '../../../component/multi_selcet_drop_down.dart';
import '../auth_cubit.dart';
class CompeteDataWidget extends StatefulWidget {
  CompeteDataWidget({super.key, this.height, this.title, this.image});
  final double? height;
  final String? title;
  final String? image;
  @override
  State<CompeteDataWidget> createState() => _CompeteDataWidgetState();
}

class _CompeteDataWidgetState extends State<CompeteDataWidget> {
  var profile = ProfileCubit.get(NavigationService.navigationKey.currentContext!).profileModel;
  AuthCubit cubit =AuthCubit.get(NavigationService.navigationKey.currentContext!);

  @override
  void initState() {
    if(profile==null){
      ProfileCubit.get(context).getProfile();
      profile=  ProfileCubit.get(context).profileModel;
    }
    cubit.comNameArController =TextEditingController(text:profile?.store?.nameAr??'' );
    cubit.comNameController =TextEditingController(text:profile?.store?.name??'' );
    typeId =profile?.store?.storeType;

    super.initState();
  }
  List<CategoryModel> categoryModelList=[];
  String? typeId;
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
          backgroundColor: primaryColor.withOpacity(0.5),
          body:  SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: whiteColor,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: SizedBox(
                    width: double.infinity,
                    height: widget.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: backGroundGray,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 60.h,
                            child: Center(
                              child: Text(widget.title??LocaleKeys.completeData.tr(),
                                style: TextStyles.font20Black700Weight,
                              ),
                            ),
                          ),
                          verticalSpace(20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  prefixIcon:  const Icon(Icons.menu_rounded,color: Colors.grey,),
                                  hintText: LocaleKeys.restaurantNameAR.tr(),
                                  hintStyle: TextStyles.font16Black500Weight.copyWith(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w600
                                  ),
                                  fillColor: backGroundGray,
                                  controller: cubit.comNameArController,
                                  borderRadius: 40,
                                  borderColor: Colors.grey.shade400,
                                ),
                                verticalSpace(20),
                                CustomTextField(
                                  prefixIcon:  const Icon(Icons.menu_rounded,color: Colors.grey,),
                                  hintText: LocaleKeys.restaurantName.tr(),
                                  hintStyle: TextStyles.font16Black500Weight.copyWith(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w600
                                  ),
                                  fillColor: backGroundGray,
                                  controller: cubit.comNameController,
                                  borderRadius: 40,
                                  borderColor: Colors.grey.shade400,
                                ),
                                verticalSpace(20),
                                // CustomTextField(
                                //   textInputType: TextInputType.emailAddress,
                                //   prefixIcon:  const Icon(Icons.email,color: Colors.grey,),
                                //   hintText: LocaleKeys.email.tr(),
                                //   hintStyle: TextStyles.font16Black500Weight.copyWith(
                                //       color: Colors.grey.shade500,
                                //       fontWeight: FontWeight.w600
                                //   ),
                                //   fillColor: backGroundGray,
                                //   controller: cubit.comEmailController,
                                //   borderRadius: 40,
                                //   borderColor: Colors.grey.shade400,
                                // ),
                                // verticalSpace(20),
                                // CustomTextField(
                                //   textInputType: TextInputType.phone,
                                //   prefixIcon:  const Icon(Icons.phone_android,color: Colors.grey,),
                                //   hintText: LocaleKeys.phone.tr(),
                                //   hintStyle: TextStyles.font16Black500Weight.copyWith(
                                //       color: Colors.grey.shade500,
                                //       fontWeight: FontWeight.w600
                                //   ),
                                //   fillColor: backGroundGray,
                                //   controller: cubit.comPhoneController,
                                //   borderRadius: 40,
                                //   borderColor: Colors.grey.shade400,
                                // ),
                                // verticalSpace(20),
                                if(widget.title != LocaleKeys.updateData.tr())
                                Column(
                                  children: [
                                    CustomTextField(
                                      suffixIcon:IconButton(onPressed: (){},icon: const Icon(Icons.location_on,color: Colors.grey,),),
                                      prefixIcon:  const Icon(Icons.maps_home_work_outlined,color: Colors.grey,),
                                      hintText: LocaleKeys.address.tr(),
                                      hintStyle: TextStyles.font16Black500Weight.copyWith(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w600
                                      ),
                                      fillColor: backGroundGray,
                                      controller: cubit.comAddressController,
                                      borderRadius: 40,
                                      borderColor: Colors.grey.shade400,
                                    ),
                                    verticalSpace(20),
                                    BlocConsumer<AuthCubit, AuthState>(
                                        listener: (context, state) {},
                                        builder: (context, state) {
                                          return   InkWell(
                                            onTap: (){
                                              if(context.read<LocalAuthCubit>().state.latLng!=null){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                    PickUpGoogleMapScreen())).then((value) {
                                                  cubit.addressModel =value;
                                                  cubit.pickUpController.text='${cubit.addressModel?.city??''}/${cubit.addressModel?.street??''}/${cubit.addressModel?.bigCity??''}';

                                                });
                                              }else{
                                                context.read<LocalAuthCubit>().getLocation().then((value) {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                      PickUpGoogleMapScreen(latLng: value))).then((value) {
                                                    cubit.addressModel =value;
                                                    cubit.pickUpController.text='${cubit.addressModel?.city??''}/${cubit.addressModel?.street??''}/${cubit.addressModel?.bigCity??''}';

                                                  });
                                                });
                                              }
                                            },
                                            child: CustomTextField(
                                                hintText: LocaleKeys.location.tr(),
                                                controller:cubit.pickUpController,
                                                enabled: false,
                                                borderRadius: 50,
                                                textInputAction: TextInputAction.done,
                                                validationFunc: (value){
                                                  if (value == null || value.isEmpty) {
                                                    return LocaleKeys.required.tr();
                                                  }
                                                  return null;
                                                },
                                                prefixIcon: Icon(Icons.location_on,color: customGray,),
                                                contentHorizontalPadding: 20.w,
                                                hintColor:customGray,
                                                fillColor: backGroundGray,
                                                borderColor:backGroundGray

                                            ),
                                          );
                                        }),
                                    verticalSpace(20),
                                    RestaurantTypesWidget(onChanged: (String value ) {
                                      cubit.comTypeController.text=value;
                                    },),
                                    verticalSpace(13),
                                    RestaurantCategoriesWidget(
                                      items: (List<CategoryModel> values) {
                                        categoryModelList=values;
                                      },
                                      onChanged: (DropDownItem? value ) {
                                        print('value ============ ${value?.title}');
                                      },
                                    ),
                                  ],
                                ),
                                // CustomTextField(
                                //   prefixIcon:  const Icon(Icons.store,color: Colors.grey,),
                                //   hintText: LocaleKeys.restaurantType.tr(),
                                //   hintStyle: TextStyles.font16Black500Weight.copyWith(
                                //       color: Colors.grey.shade500,
                                //       fontWeight: FontWeight.w600
                                //   ),
                                //   fillColor: backGroundGray,
                                //   controller: cubit.comTypeController,
                                //   borderRadius: 40,
                                //   borderColor: Colors.grey.shade400,
                                // ),
                                verticalSpace(20),
                                Text(LocaleKeys.addImage.tr(),
                                  style: TextStyles.font18Black700Weight,
                                ),
                                verticalSpace(25),
                                BlocConsumer<AuthCubit, AuthState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return Column(
                                      children: [
                                        Center(
                                          child: InkWell(
                                            onTap: (){
                                              cubit.pickImage();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  border: Border.all(color: Colors.grey)
                                              ),
                                              child:
                                              cubit.imageFile!=null?
                                              SizedBox(
                                                height:150.w,
                                                width:150.w,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(80),
                                                    child: Image.file(cubit.imageFile!,
                                                      fit: BoxFit.cover,
                                                    ),),
                                                ),
                                              ):
                                              SizedBox(
                                                height:120.w,
                                                width:150.w,
                                                child:  Center(
                                                  child:
                                                  widget.image!=null?CustomImage(image:widget.image??'',radius: 30,
                                                    width: 150.w,
                                                    height:120.w,
                                                  ):
                                                  const Icon(Icons.add_a_photo,size: 120,color: Colors.grey,),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        verticalSpace(25),
                                        Container(
                                          decoration: Decorations.backGroundDecorationButton().copyWith(
                                              borderRadius: BorderRadius.circular(40)
                                          ),
                                          child: CustomElevatedButton(
                                            isLoading: state is CompleteProfileLoadingState,
                                            backgroundColor: Colors.transparent,
                                            onTap: (){
                                              cubit.completeProfile(context,widget.image!=null?true:false);
                                            },
                                            buttonText:widget.image!=null?LocaleKeys.update.tr():LocaleKeys.done.tr(),
                                            width:double.infinity,
                                            height: 40,
                                            fontSize: 17,
                                            borderRadius: 40,
                                          ),
                                        ),
                                        verticalSpace(20),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
      );
  }

}



