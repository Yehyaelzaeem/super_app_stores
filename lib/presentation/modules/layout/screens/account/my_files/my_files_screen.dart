import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/routing/routes.dart';
import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/my_files/widget/file_done_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/my_files/widget/file_required_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../component/custom_app_bar.dart';
import '../account_cubit.dart';

class MyFilesScreen extends StatelessWidget {
  const MyFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountCubit cubit =AccountCubit.get(context);
    ProfileCubit profileCubit =ProfileCubit.get(context);
    return  Scaffold(
      backgroundColor: backGroundGray,
      appBar:  CustomAppBar(
        color: backGroundGray,
        title: LocaleKeys.myFiles.tr(),
      ),
      body:
      BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                if(profileCubit.profileModel!=null){
                  var storeFiles =profileCubit.profileModel!.store!.files!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        storeFiles.commercialId!=null?
                        FileDoneWidget(
                          title: LocaleKeys.commercialRegisterFile.tr(), text: LocaleKeys.commercialRegisterFileUpdate.tr(), onTap: () {
                          context.pushNamed(Routes.editFileScreen,arguments: {
                            'type':'commercialIdFile',
                            'title': LocaleKeys.commercialRegisterFile.tr(),
                            'text':LocaleKeys.commercialRegisterFileUpdate.tr(),
                          });
                        },):
                        FileRequiredWidget(title:LocaleKeys.commercialRegisterFile.tr(), text: LocaleKeys.commercialRegisterFileUpdate.tr(), onTap: () {
                          cubit.pickImage(type: 'commercialIdFile').then((value) {
                            cubit.uploadAccountFile(context: context, type: 'commercialIdFile');
                          });
                        },),

                        storeFiles.tax!=null?
                        FileDoneWidget(title: LocaleKeys.taxCard.tr(), text:LocaleKeys.taxCardUpdate.tr(), onTap: () {
                          context.pushNamed(Routes.editFileScreen,arguments: {
                            'type':'taxFile',
                            'title':LocaleKeys.taxCard.tr(),
                            'text':LocaleKeys.taxCardUpdate.tr(),
                          });
                        },):
                        FileRequiredWidget(title: LocaleKeys.taxCard.tr(), text:LocaleKeys.taxCardUpdate.tr(), onTap: () {
                          cubit.pickImage(type: 'taxFile').then((value) {
                            cubit.uploadAccountFile(context: context, type: 'taxFile');
                          });
                        },),

                        storeFiles.banner!=null?
                        FileDoneWidget(title: LocaleKeys.bannerImage.tr(), text:LocaleKeys.bannerImageUpdate.tr(), onTap: () {
                          context.pushNamed(Routes.editFileScreen,arguments: {
                            'type':'bannerFile',
                            'title': LocaleKeys.bannerImage.tr(),
                            'text':LocaleKeys.bannerImageUpdate.tr(),
                          });
                        },):
                        FileRequiredWidget(title:  LocaleKeys.bannerImage.tr(), text: LocaleKeys.bannerImageUpdate.tr(), onTap: () {
                          cubit.pickImage(type: 'bannerFile').then((value) {
                            cubit.uploadAccountFile(context: context, type: 'bannerFile');

                          });
                        },),



                      ],
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
