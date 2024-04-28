import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/routing/routes.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/my_files/widget/file_done_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/my_files/widget/file_required_widget.dart';
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
      appBar: const CustomAppBar(
        color: backGroundGray,
        title: 'ملفاتي',
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                if(profileCubit.profileModel!=null){
                  var storeFiles =profileCubit.profileModel!.store!.files!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        storeFiles.commercialId!=null?
                        FileDoneWidget(title: 'ملف السجل التجاري', text: 'قم بتحديث ملف السجل التجاري الخاص بك', onTap: () {
                          context.pushNamed(Routes.editFileScreen,arguments: {
                            'type':'commercialIdFile',
                            'title':'ملف السجل التجاري',
                            'text':'قم بتحديث ملف السجل التجاري الخاص بك',
                          });
                        },):
                        FileRequiredWidget(title: 'ملف السجل التجاري', text: 'قم بتحميل ملف السجل التجاري الخاص بك', onTap: () {
                          cubit.pickImage(type: 'commercialIdFile').then((value) {
                            cubit.uploadAccountFile(context: context, type: 'commercialIdFile');
                          });
                        },),

                        storeFiles.tax!=null?
                        FileDoneWidget(title: 'البطاقة الضريبية', text: 'قم بتحديث  بطاقتك الضريبية', onTap: () {
                          context.pushNamed(Routes.editFileScreen,arguments: {
                            'type':'taxFile',
                            'title':'البطاقة الضريبية',
                            'text':'قم بتحديث  بطاقتك الضريبية',
                          });
                        },):
                        FileRequiredWidget(title: 'البطاقة الضريبية', text: 'قم بتحميل بطاقتك الضريبية', onTap: () {
                          cubit.pickImage(type: 'taxFile').then((value) {
                            cubit.uploadAccountFile(context: context, type: 'taxFile');
                          });
                        },),

                        storeFiles.banner!=null?
                        FileDoneWidget(title: 'صورة البانر', text: 'قم بتحديث صورة البانر', onTap: () {
                          context.pushNamed(Routes.editFileScreen,arguments: {
                            'type':'bannerFile',
                            'title':'صورة البانر',
                            'text':'قم بتحديث صورة البانر',
                          });
                        },):
                        FileRequiredWidget(title: 'صورة البانر', text: 'قم بتحميل صورة البانر', onTap: () {
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
