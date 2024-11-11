import 'dart:async';

import 'package:cogina_restaurants/presentation/component/custom_elevated_button.dart';
import 'package:cogina_restaurants/presentation/component/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/styles.dart';
import '../../../core/translations/locale_keys.dart';
import '../../../core/utils/toast_states/enums.dart';
import '../../../data/model/response/delivery_time.dart';
import '../../../data/model/response/profile_model.dart';
import 'delivery_time_cubit.dart';
class DeliveryTimeScreen extends StatefulWidget {
  final GetProfileModelData? profile;
  final bool isComplete;
   DeliveryTimeScreen({super.key, this.profile,this.isComplete=false});

  @override
  State<DeliveryTimeScreen> createState() => _DeliveryTimeScreenState();
}

class _DeliveryTimeScreenState extends State<DeliveryTimeScreen> {
  TextEditingController orderTimeController = TextEditingController();
  TextEditingController deliveryTimeController  = TextEditingController();
  TextEditingController deliveryPriceController  = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    displayData(widget.profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          automaticallyImplyLeading: false,

          leading:
          widget.isComplete==true?
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
          ):SizedBox(),
          title: Text(LocaleKeys.delivery.tr(),style: TextStyles.font20Black700Weight.copyWith(color: Colors.white,fontSize: 17),),
        ),
        body:
        SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
            child:
            Form(
                key: _formKey,
                child:
                Column(
                  children: [
                    CustomTextField(
                      title: LocaleKeys.orderTime.tr(),
                      textInputType: TextInputType.number,
                      prefixIcon: Icon(Icons.access_time_outlined,color: Colors.grey.shade500,),
                      hintText: LocaleKeys.orderTime.tr(), controller: orderTimeController,),
                    verticalSpace(15),
                    // CustomTextField(
                    //   title: LocaleKeys.deliveryTime2.tr(),
                    //   textInputType: TextInputType.number,
                    //   prefixIcon: Icon(Icons.timer,color: Colors.grey.shade500,),
                    //   hintText: LocaleKeys.deliveryTime2.tr(), controller: deliveryTimeController,),
                    // verticalSpace(15),
                    // CustomTextField(
                    //   title: LocaleKeys.deliveryPrice.tr(),
                    //   textInputType: TextInputType.number,
                    //   prefixIcon: Icon(Icons.attach_money,color: Colors.grey.shade500,),
                    //   hintText: LocaleKeys.deliveryPrice.tr(), controller: deliveryPriceController,),
                    verticalSpace(30),
                    BlocBuilder<DeliveryTimeCubit, DeliveryTimeState>(builder: (context, state) {
                      return  CustomElevatedButton(
                        isLoading: state.addDeliveryTimeState == RequestState.loading,
                        onTap: (){
                          print('onTap');

                          if(_formKey.currentState!.validate()){
                            DeliveryTimeParams params = DeliveryTimeParams(
                              orderTime: orderTimeController.text,
                              deliveryTime: deliveryTimeController.text,
                              deliveryPrice: deliveryPriceController.text,
                            );
                            context.read<DeliveryTimeCubit>().addDeliveryTime(params: params,isComplete: widget.isComplete);

                          }
                        },
                        buttonText:'${LocaleKeys.save.tr()}',
                        width: 350.w,
                        height: 50.h,
                        fontSize: 20,

                      );
                    }),


                  ],
                )
            )
        )
    );
  }
  displayData(GetProfileModelData? profile) {
    if(profile!=null){
      orderTimeController=TextEditingController(text: profile.store?.orderTime??'');
      // deliveryTimeController=TextEditingController(text: profile.store?.deliveryTime??'');
      // deliveryPriceController=TextEditingController(text: profile.store?.deliveryPrice==null?'':profile.store?.deliveryPrice.toString()??'');
    }
  }
}

