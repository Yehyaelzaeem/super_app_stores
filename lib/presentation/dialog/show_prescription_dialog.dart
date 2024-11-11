import 'package:cogina_restaurants/core/helpers/spacing.dart';
import 'package:cogina_restaurants/core/resources/text_styles.dart';
import 'package:cogina_restaurants/presentation/component/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resources/values_manager.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/utils/toast_states/enums.dart';
import '../../data/model/response/send_prescription_params.dart';
import '../../generated/locale_keys.g.dart';
import '../component/primary_button.dart';
import '../modules/prescription/prescription_cubit.dart';
import 'base/simple_dialogs.dart';


 Future showPrescriptionDialog(BuildContext context,int id) async =>
    showCustomDialog(context, _buildBody(context,id), onDismissCallback: ()=>NavigationService.goBack() ,isCancellable: true);


_buildBody(BuildContext context,int id){
  TextEditingController controller = TextEditingController();
  TextEditingController notesController = TextEditingController();
  return Padding(
    padding: EdgeInsets.symmetric(vertical: kScreenPaddingNormal.h),
    child:
    Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child:
               Text(tr( LocaleKeys.sendPrice), style: const TextStyle().regularStyle(fontSize: 16.sp), textAlign: TextAlign.center),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.highlight_remove_outlined,color: Colors.black,),
              ),
              horizontalSpace(16.w)
            ],
          ),
          verticalSpace(10.h),
          Divider(color: Colors.grey.shade300),
         Padding(
           padding: EdgeInsets.symmetric(horizontal: kScreenPaddingNormal.h),
         child: Column(
           children: [
             verticalSpace(30.h),
             CustomTextField(hintText: LocaleKeys.price.tr(), controller: controller,
             textInputType: TextInputType.number,
             ),
             verticalSpace(16.h),
             CustomTextField(
                 maxLines: 3,
                 hintText: LocaleKeys.notes.tr(), controller: notesController),
             verticalSpace(30.h),

             PrimaryButtonWidget(
               onTap: (){
                 if(controller.text.isNotEmpty){
                  context.read<PrescriptionCubit>().sendPricePrescription(params:
                  SendPrescriptionParams(id: id.toString(), price: controller.text, notes: notesController.text), context: context);
                 }else{
                   showToast(text: LocaleKeys.this_field_required.tr(), state: ToastStates.error, context: context);
                 }
               },
               text: LocaleKeys.send.tr(),
              ),
           ],
         ),
         )
  ],
      ),
    ),
  );
}

