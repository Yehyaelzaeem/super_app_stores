import 'package:cogina_restaurants/core/resources/text_styles.dart';
import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:cogina_restaurants/presentation/component/custom_not_found_data.dart';
import 'package:cogina_restaurants/presentation/modules/prescription/prescription_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/assets_constant/images.dart';
import '../../../../../../core/helpers/helper_methods.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/styles.dart';

import '../../../core/resources/values_manager.dart';
import '../../../core/utils/contact_helper.dart';
import '../../../core/utils/toast_states/enums.dart';
import '../../../data/model/response/prescription_model.dart';
import '../../../data/model/response/send_prescription_params.dart';
import '../../component/custom_app_bar.dart';
import '../../component/custom_text_field.dart';
import '../../component/images/custom_image.dart';
import '../../component/primary_button.dart';
import '../../dialog/show_prescription_dialog.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PrescriptionCubit cubit = context.read<PrescriptionCubit>();
    cubit.getPrescription();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      // appBar: CustomAppBar(
      //   title: LocaleKeys.prescription.tr(),
      // ),
      body: BlocConsumer<PrescriptionCubit, PrescriptionState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (cubit.prescriptionModel != null) {
            if (cubit.prescriptionModel?.data?.isNotEmpty ?? false) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  itemCount: cubit.prescriptionModel?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = cubit.prescriptionModel?.data?[index]!;
                    return
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headerPrescription(context,item!),
                            Divider(color: Colors.grey.shade300,),
                            Text('${LocaleKeys.notes.tr()} :-', style: TextStyles.font16Black600Weight.copyWith(
                              fontSize: 12.sp,
                              color: Colors.grey.shade500,
                            ),),
                            verticalSpace(10),
                           Padding(padding: EdgeInsets.symmetric(horizontal: 30.w),
                           child:  Text('${item.note??''}', style: TextStyles.font16Black600Weight.copyWith(
                             fontSize: 14.sp,
                           ),),
                           ),
                            verticalSpace(10),
                            InkWell(
                              onTap: (){
                                ImageProvider imageProvider = NetworkImage(item?.image??'');
                                openBottomSheet(context, imageProvider);
                              },
                              child:  CustomImage(image:item?.image??'',
                                radius: 12,
                                height: 250.h,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            verticalSpace(10),
                            Divider(color: Colors.grey.shade300,),
                            if(item.status =='request')
                              bottomPrescription(context,item)
                            else
                             Center(
                               child:  Text( '${LocaleKeys.inPreparation.tr()}', style: TextStyles.font16Black600Weight.copyWith(
                                 fontSize: 14.sp,
                               ),),
                             )
                          ],
                        ),
                      );
                  });
            } else {
              return CustomNotFoundDataWidget(
                title: LocaleKeys.notFoundData.tr(),
                type: 'svg',
                image: AppImages.notFoundBranch,
              );
            }
          } else {
            return Center(
              child: CustomLoadingWidget(),
            );
          }
        },
      ),
    );
  }
}

Widget headerPrescription(BuildContext context,PrescriptionModelData item){
  return Row(
    children: [
      Expanded(child: InkWell(
        onTap: (){
        },
        child: Row(
          children: [
            CustomImage(image: '',
              radius: 60,
              height: 45,
              width: 45,
            ),
            horizontalSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item?.client?.name??''}' , style: TextStyles.font16Black600Weight.copyWith(
                    fontSize: 14.sp,
                  ),),
                  verticalSpace(5),
                  Text('${item?.client?.address??''}' , style: TextStyles.font16Black600Weight.copyWith(
                    fontSize: 14.sp,
                  ),),

                ],
              ),
            ),
          ],
        ),
      )),
      InkWell(

        onTap: (){
          ContactHelper.launchCall(item.client?.phone??'');
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor:Colors.blue.shade400,
          child: Icon(Icons.phone, color: Colors.white,),
        ),
      ),
      horizontalSpace(10),
      InkWell(
        onTap: (){
          ContactHelper.launchMap(lat: double.parse(item.client?.location?.lat?.toString()??'0.0'), long: double.parse(item.client?.location?.lng?.toString()??'0.0'));
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.red.shade400,
          child: Icon(Icons.location_on_rounded, color: Colors.white,),
        ),
      ),




    ],
  );
}
Widget bottomPrescription(BuildContext context,PrescriptionModelData item){
  TextEditingController controller = TextEditingController();
  TextEditingController notesController = TextEditingController();
  return
    Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kScreenPaddingNormal.h),
            child: Column(
              children: [
                verticalSpace(8.h),
               Column(
                 children: [

                   TextField(
                     decoration: InputDecoration(

                         hintText:  LocaleKeys.price.tr()
                     ),
                     keyboardType: TextInputType.number,
                     controller: controller,
                   ),
                   verticalSpace(10.h),
                   TextField(

                     decoration: InputDecoration(
                       hintText:  LocaleKeys.notes.tr()
                     ),
                     controller: notesController,
                     keyboardType: TextInputType.multiline,

                   ),

                 ],
               ),
                verticalSpace(30.h),
                BlocConsumer<PrescriptionCubit,PrescriptionState>(builder: (context,state){
                  return  PrimaryButtonWidget(
                    radius: 8,
                    isLoading: state is SendPrescriptionLoading,
                    onTap: (){
                      if(controller.text.isNotEmpty){
                        context.read<PrescriptionCubit>().sendPricePrescription(params:
                        SendPrescriptionParams(id: item.id.toString(), price: controller.text, notes: notesController.text), context: context);
                      }else{
                        showToast(text: LocaleKeys.this_field_required.tr(), state: ToastStates.error, context: context);
                      }
                    },
                    text: LocaleKeys.send.tr(),
                  );
                }, listener:  (context,state){})
              ],
            ),
          )
        ],
      ),
    );
}
