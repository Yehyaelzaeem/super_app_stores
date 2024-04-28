import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/decoration.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../component/custom_app_bar.dart';
import '../../../../../component/custom_elevated_button.dart';
import '../account_cubit.dart';

class EditFileScreen extends StatelessWidget {
  const EditFileScreen({super.key, required this.type, required this.title, required this.text});
  final String type;
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    AccountCubit cubit=AccountCubit.get(context);
    return  Scaffold(
      backgroundColor: backGroundGray,
      appBar: const CustomAppBar(
        color: backGroundGray,
        title: 'تعديل ملفاتي',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: whiteColor,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,style: TextStyles.font18Black700Weight.copyWith(
                          color: backBlue2
                        ),),
                        Text(text,style: TextStyles.font18Black700Weight.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(20),
            BlocConsumer<AccountCubit, AccountState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: whiteColor,
                                          borderRadius: BorderRadius.circular(20.sp),
                                          border: Border.all(color: Colors.grey)
                                      ),
                                      child: InkWell(
                                          onTap: (){
                                            cubit.pickImage(type: type);
                                          },
                                          child:
                                          type=='commercialIdFile'?
                                              cubit.commercialIdFile!=null?
                                                  SizedBox(
                                                      height: 150.h,
                                                      width: 200.w,
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(20.sp),
                                                          child: Image.file(cubit.commercialIdFile!,fit: BoxFit.cover,width: double.infinity,))):
                                          const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Icon(Icons.add_a_photo,size: 80,color: Colors.grey,),
                                          ):
                                          type=='taxFile'?
                                          cubit.taxFile!=null?
                                          SizedBox(
                                              height: 150.h,
                                              width: 200.w,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20.sp),
                                                  child: Image.file(cubit.taxFile!,fit: BoxFit.cover,width: double.infinity,))):
                                          const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Icon(Icons.add_a_photo,size: 80,color: Colors.grey,),
                                          ):
                                           type=='bannerFile'?
                                           cubit.bannerFile!=null?
                                           SizedBox(
                                               height: 150.h,
                                               width: 200.w,
                                               child: ClipRRect(
                                                   borderRadius: BorderRadius.circular(20.sp),
                                                   child: Image.file(cubit.bannerFile!,fit: BoxFit.cover,width: double.infinity,))) :
                                          const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Icon(Icons.add_a_photo,size: 80,color: Colors.grey,),
                                          ):
                                           const Padding(
                                             padding: EdgeInsets.all(20.0),
                                             child: Icon(Icons.add_a_photo,size: 80,color: Colors.grey,),
                                           ),


                                      ),
                                    ),
                                  );
                        },
                      ),
            verticalSpace(50),
            BlocConsumer<AccountCubit, AccountState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Container(
                              height: 43,
                              decoration: Decorations.backGroundDecorationButton().copyWith(
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: CustomElevatedButton(
                                isLoading: state is UploadFileLoadingState,
                                backgroundColor: Colors.transparent,
                                onTap: (){
                                  cubit.uploadAccountFile(context: context, type: type);
                                },
                                buttonText:'تم',
                                width: MediaQuery.of(context).size.width*0.5,
                                height: 35,
                                fontSize: 17,
                                borderRadius: 40,
                              ),
                            );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
