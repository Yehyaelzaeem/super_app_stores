import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/widgets/custom_bottom_sheet_body.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/widgets/custom_profile_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/translations/locale_keys.dart';
import '../../../../component/custom_app_bar.dart';
import '../../../../component/images/custom_image.dart';
import '../../../../dialog/show_logout_dialog.dart';
import '../../../branches/branch_cubit.dart';
import '../../layout_cubit.dart';


class AccountScreen extends StatelessWidget {
   const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool switchValue = false;
    final LayoutCubit cubit = BlocProvider.of<LayoutCubit>(context);
    ProfileCubit profileCubit =ProfileCubit.get(context);
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: '',
          isBackButtonExist: false,
          onBackPress: (){
            final LayoutCubit viewModel = BlocProvider.of<LayoutCubit>(context);
            viewModel.setCurrentIndex(0);
          },
        ),
        body:  SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(10),
              Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child:
                BlocConsumer<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (profileCubit.profileModel != null) {
                      return Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100.w, vertical: 20.h),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 115.h,
                                    width: 115.h,
                                    child: CustomImage(image:profileCubit.profileModel!.image!, radius: 100,),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 18,
                                      child: Center(
                                        child: IconButton(
                                            onPressed: () {
                                              NavigationService.push(
                                                  Routes.editProviderProfileScreen);
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: whiteColor,
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpace(5),
                              Text(
                                '${profileCubit.profileModel!.firstName} ${profileCubit.profileModel!.lastName}',
                                style: TextStyles.font20Black700Weight,
                              ),
                              Text(
                                profileCubit.profileModel!.email ?? '',
                                style: TextStyles.font14White500Weight
                                    .copyWith(color: customGray,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                  listener: (context, state) {},
                ),
               
              ),
              verticalSpace(10),
              Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    CustomProviderProfileItem(title: LocaleKeys.restaurant.tr(), icon: Icons.restaurant,
                      onTap: (){
                        context.pushNamed(Routes.updateRestaurant);
                      },),
                    verticalSpace(10),
                    CustomProviderProfileItem(title: LocaleKeys.orders.tr(), icon: Icons.badge,
                    onTap: (){
                      // context.pushNamed(Routes.providerOrdersScreen);
                      cubit.setCurrentIndex(2);

                    },),
                    verticalSpace(10),
                     CustomProviderProfileItem(title: LocaleKeys.profits.tr(), icon: Icons.bar_chart_outlined,
                    onTap: (){
                      cubit.setCurrentIndex(1);
                    },
                    ),
                    // verticalSpace(10),
                    //  CustomProviderProfileItem(title: LocaleKeys.elements.tr(), icon: Icons.menu,
                    // onTap: (){
                    //   context.pushNamed(Routes.elementsScreen);
                    // },
                    // ),
                    verticalSpace(10),
                     CustomProviderProfileItem(title: LocaleKeys.myFiles.tr(), icon: Icons.file_copy,
                    onTap: (){
                      context.pushNamed(Routes.myFilesScreen);
                    },
                    ),
                    verticalSpace(10),
                     CustomProviderProfileItem(title: LocaleKeys.bankDetails.tr(), icon: Icons.food_bank,
                         onTap: (){
                          context.pushNamed(Routes.bankDetailsScreen);
                          },
                     ),
                    verticalSpace(10),
                     CustomProviderProfileItem(title: LocaleKeys.branches.tr(), icon: Icons.location_on,
                    onTap: (){
                      BranchCubit.get().getBranches();
                      context.pushNamed(Routes.branchesScreen);
                    },
                    ),
                    // verticalSpace(10),
                    //  CustomProviderProfileItem(title: LocaleKeys.messages.tr(), icon: Icons.message,
                    //   onTap: (){
                    //     context.pushNamed(Routes.messagesScreen);
                    //   },
                    // ),
                    // verticalSpace(10),
                    //  CustomProviderProfileItem(title: LocaleKeys.setting.tr(), icon: Icons.settings,
                    //   onTap: (){
                    //     context.pushNamed(Routes.settingsScreen);
                    //   },
                    // ),
                    verticalSpace(10),
                    CustomProviderProfileItem(title: LocaleKeys.aboutUs.tr(), icon: Icons.info_outline,
                      onTap: (){
                        context.pushNamed(Routes.aboutUsScreen);
                      },
                    ),
                    verticalSpace(10),
                    CustomProviderProfileItem(title: LocaleKeys.termsAndConditions.tr(), icon:IonIcons.hammer,
                      onTap: (){
                        context.pushNamed(Routes.termsConditionScreen);
                      },
                    ),
                    verticalSpace(10),
                    CustomProviderProfileItem(title: LocaleKeys.privacyPolicy.tr(), icon: Icons.privacy_tip_outlined,
                      onTap: (){
                        context.pushNamed(Routes.privacyPolicyScreen);
                      },
                    ),
                    // verticalSpace(10),
                    //  CustomProviderProfileItem(title: LocaleKeys.contactUs.tr(), icon: Icons.phone,
                    // onTap: (){
                    //    context.pushNamed(Routes.contactUsScreen);
                    // },
                    // ),
                    verticalSpace(10),
                   StatefulBuilder(builder: (context,setState){
                     return   CustomProviderProfileItem(title: LocaleKeys.language.tr(), icon: Icons.language,
                       // trailing: Switch(
                       //   value: switchValue,
                       //   onChanged: (value) {
                       //     setState(() {
                       //       switchValue = value;
                       //     });
                       //   },
                       // ),
                       onTap: (){
                         showModalBottomSheet(
                           context: context,
                           builder: (BuildContext context) {
                             return  CustomBottomSheetBody();
                           },
                         );
                       },
                     );
                   }),
                    verticalSpace(10),

                    CustomProviderProfileItem(title: LocaleKeys.deleteAccount.tr(), icon: Icons.delete,
                      onTap: (){
                        showDeleteAccountDialog(context,);
                      },
                    ),
                    verticalSpace(10),
                     CustomProviderProfileItem(title: LocaleKeys.logout.tr(), icon: Icons.logout,color: redColor,
                    onTap: (){
                      showLogoutDialog(context,);
                    },
                    ),
                    verticalSpace(80),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  }
}
