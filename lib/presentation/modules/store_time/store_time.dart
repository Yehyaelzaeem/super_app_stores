import 'package:cogina_restaurants/core/helpers/spacing.dart';
import 'package:cogina_restaurants/presentation/component/custom_elevated_button.dart';
import 'package:cogina_restaurants/presentation/modules/store_time/store_time_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/store_time/widget/time_day_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/date_formatter.dart';
import '../../../core/helpers/helper_methods.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/styles.dart';
import '../../../core/translations/locale_keys.dart';
import '../../../core/utils/toast_states/enums.dart';
import '../../../data/model/response/profile_model.dart';
import '../../../data/model/response/time_params.dart';
import '../../component/custom_text_field.dart';
import '../../component/spaces.dart';

class StoreTimeScreen extends StatelessWidget {
  final List<Times>? times;
  final bool isComplete;
   StoreTimeScreen({super.key, this.times, this.isComplete = false});

  TextEditingController saturdayTo  = TextEditingController();
  TextEditingController sundayTo  = TextEditingController();
  TextEditingController mondayTo  = TextEditingController();
  TextEditingController tuesdayTo  = TextEditingController();
  TextEditingController wednesdayTo  = TextEditingController();
  TextEditingController thursdayTo  = TextEditingController();
  TextEditingController fridayTo  = TextEditingController();
   TextEditingController saturdayFrom  = TextEditingController();
   TextEditingController sundayFrom   = TextEditingController();
   TextEditingController mondayFrom  = TextEditingController();
   TextEditingController tuesdayFrom   = TextEditingController();
   TextEditingController wednesdayFrom   = TextEditingController();
   TextEditingController thursdayFrom  = TextEditingController();
   TextEditingController fridayFrom   = TextEditingController();
   bool sundayActive = true;
   bool mondayActive = true;
   bool tuesdayActive = true;
   bool wednesdayActive = true;
   bool thursdayActive = true;
   bool fridayActive = true;
   bool saturdayActive = true;
  @override
  Widget build(BuildContext context) {
     if (times != null && times!.isNotEmpty) {
       displayTime(times??[]);
     }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        title: Text(LocaleKeys.times.tr(),style: TextStyles.font20Black700Weight.copyWith(color: Colors.white,fontSize: 30),),
      ),
      body:
     SafeArea(
       child:  SingleChildScrollView(
         padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
         child:
         Column(
           children: [
             TimeDayItem(
               onChangeCycle: (String value) {
                 if(value=='24') {
                   saturdayFrom.text='00:00:00';
                   saturdayTo.text='11:59:59';
                 }else{
                   saturdayFrom.text='';
                    saturdayTo.text='';
                 }
               },
               active: saturdayActive,
               initialValueFrom: saturdayFrom.text,
               initialValueTo: saturdayTo.text,
               day: '${LocaleKeys.saturday.tr()}',
               onTapFrom: (String value) {
                 saturdayFrom.text=value;
               },
               onTapTo: (String value) {
                 saturdayTo.text=value;
               },),
             TimeDayItem(
               onChangeCycle: (String value) {
                 if(value=='24') {
                   sundayFrom.text='00:00:00';
                   sundayTo.text='11:59:59';
                 }
                 else{
                   sundayFrom.text='';
                    sundayTo.text='';
                 }
               },
                  active: sundayActive,
                  initialValueFrom: sundayFrom.text,
                  initialValueTo: sundayTo.text,
               day: '${LocaleKeys.sunday.tr()}',
               onTapFrom: (String value) {
                 sundayFrom.text=value;
               },
               onTapTo: (String value) {
                 sundayTo.text=value;
               },),
             TimeDayItem(
               onChangeCycle: (String value) {
                 if(value=='24') {
                   mondayFrom.text='00:00:00';
                   mondayTo.text='11:59:59';
                 }
                 else{
                   mondayFrom.text='';
                    mondayTo.text='';
                 }
               },
                  active: mondayActive,
                  initialValueFrom: mondayFrom.text,
                  initialValueTo: mondayTo.text,
               day: '${LocaleKeys.monday.tr()}',
               onTapFrom: (String value) {
                 mondayFrom.text=value;
               },
               onTapTo: (String value) {
                 mondayTo.text=value;
               },),
             TimeDayItem(
               onChangeCycle: (String value) {
                 if(value=='24') {
                      tuesdayFrom.text='00:00:00';
                      tuesdayTo.text='11:59:59';
                 }
                 else{
                   tuesdayFrom.text='';
                    tuesdayTo.text='';
                 }
               },
                  active: tuesdayActive,
                  initialValueFrom: tuesdayFrom.text,
                  initialValueTo: tuesdayTo.text,
               day: '${LocaleKeys.tuesday.tr()}',
               onTapFrom: (String value) {
                 tuesdayFrom.text=value;
               },
               onTapTo: (String value) {
                 tuesdayTo.text=value;
               },),
             TimeDayItem(
               onChangeCycle: (String value) {
                 if(value=='24') {
                      wednesdayFrom.text='00:00:00';
                      wednesdayTo.text='11:59:59';
                 }else{
                   wednesdayFrom.text='';
                    wednesdayTo.text='';  }
               },
                  active: wednesdayActive,
                  initialValueFrom: wednesdayFrom.text,
                  initialValueTo: wednesdayTo.text,
               day: '${LocaleKeys.wednesday.tr()}',
               onTapFrom: (String value) {
                 wednesdayFrom.text=value;
               },
               onTapTo: (String value) {
                 wednesdayTo.text=value;
               },),
             TimeDayItem(
               onChangeCycle: (String value) {
                 if(value=='24') {
                      thursdayFrom.text='00:00:00';
                      thursdayTo.text='11:59:59';
                 }else{
                   thursdayFrom.text='';
                    thursdayTo.text='';
                 }
               },
                  active: thursdayActive,
                  initialValueFrom: thursdayFrom.text,
                  initialValueTo: thursdayTo.text,
               day: '${LocaleKeys.thursday.tr()}',
               onTapFrom: (String value) {
                 thursdayFrom.text=value;
               },
               onTapTo: (String value) {
                 thursdayTo.text=value;
               },),
             TimeDayItem(
               onChangeCycle: (String value) {
                 if(value=='24') {
                      fridayFrom.text='00:00:00';
                      fridayTo.text='11:59:59';
                 }else{
                   fridayFrom.text='';
                    fridayTo.text='';
                 }
               },
                  active: fridayActive,
                  initialValueFrom: fridayFrom.text,
                  initialValueTo: fridayTo.text,
               day: '${LocaleKeys.friday.tr()}',
               onTapFrom: (String value) {
                 fridayFrom.text=value;
               },
               onTapTo: (String value) {
                 fridayTo.text=value;
               },),
             verticalSpace(20),
             BlocBuilder<StoreTimeCubit, StoreTimeState>(
               builder: (context, state) {
                 return  CustomElevatedButton(
                   isLoading: state.addStoreTimeState == RequestState.loading,
                     width: 350.w,
                     height: 50.h,
                     fontSize: 20,
                     onTap: (){
                       TimeParams params = TimeParams(
                         saturday: saturdayFrom.text == 'off' ?'off':'on',
                         saServiceCloseTime: saturdayFrom.text == 'off' ?'':saturdayTo.text,
                         saServiceOpenTime: saturdayFrom.text == 'off' ?'':saturdayFrom.text,
                         sunday: sundayFrom.text == 'off' ?'off':'on',
                         suServiceCloseTime: sundayFrom.text == 'off' ?'':sundayTo.text,
                         suServiceOpenTime: sundayFrom.text == 'off' ?'':sundayFrom.text,
                         monday: mondayFrom.text == 'off' ?'off':'on',
                         moServiceCloseTime: mondayFrom.text == 'off' ?'':mondayTo.text,
                         moServiceOpenTime: mondayFrom.text == 'off' ?'':mondayFrom.text,
                         tuesday: tuesdayFrom.text == 'off' ?'off':'on',
                         tuServiceCloseTime: tuesdayFrom.text == 'off' ?'':tuesdayTo.text,
                         tuServiceOpenTime: tuesdayFrom.text == 'off' ?'':tuesdayFrom.text,
                         wednesday: wednesdayFrom.text == 'off' ?'off':'on',
                         weServiceCloseTime: wednesdayFrom.text == 'off' ?'':wednesdayTo.text,
                         weServiceOpenTime: wednesdayFrom.text == 'off' ?'':wednesdayFrom.text,
                         thursday: thursdayFrom.text == 'off' ?'off':'on',
                         thServiceCloseTime: thursdayFrom.text == 'off' ?'':thursdayTo.text,
                         thServiceOpenTime: thursdayFrom.text == 'off' ?'':thursdayFrom.text,
                         friday: fridayFrom.text == 'off' ?'off':'on',
                         frServiceCloseTime: fridayFrom.text == 'off' ?'':fridayTo.text,
                         frServiceOpenTime: fridayFrom.text == 'off' ?'':fridayFrom.text,

                       );
                        context.read<StoreTimeCubit>().addStoreTime(params: params,isComplete: isComplete);
                     }, buttonText: '${LocaleKeys.save.tr()}');
               })
           ],
         ),
       ),
     )
    );
  }

  displayTime(List<Times> times) {
   for (var time in times) {
      if (time.day == 'saturday') {
        if(time.type == 'on'){
          saturdayActive=true;
          saturdayFrom.text = time.startTime??'';
          saturdayTo.text = time.endTime??'';
        }else{
          saturdayActive=false;
          saturdayFrom.text='off';
        }

      } else if (time.day == 'sunday') {
        if(time.type == 'on'){
          sundayActive=true;
          sundayFrom.text = time.startTime??'';
          sundayTo.text = time.endTime??'';
        }else{
          sundayActive=false;
          sundayFrom.text='off';
        }

      } else if (time.day == 'monday') {
        if(time.type == 'on'){
          mondayActive=true;
          mondayFrom.text = time.startTime??'';
          mondayTo.text = time.endTime??'';
        }else{
          mondayActive=false;
          mondayFrom.text='off';
        }
      } else if (time.day == 'tuesday') {
        if(time.type == 'on'){
          tuesdayActive=true;
          tuesdayFrom.text = time.startTime??'';
          tuesdayTo.text = time.endTime??'';
        }else{
          tuesdayActive=false;
          tuesdayFrom.text='off';
        }

      } else if (time.day == 'wednesday') {
        if(time.type == 'on'){
          wednesdayActive=true;
          wednesdayFrom.text = time.startTime??'';
          wednesdayTo.text = time.endTime??'';
        }else{
          wednesdayActive=false;
          wednesdayFrom.text='off';
        }

      } else if (time.day == 'thursday' ) {
        if(time.type == 'on'){
          thursdayActive=true;
          thursdayFrom.text = time.startTime??'';
          thursdayTo.text = time.endTime??'';
        }else{
          thursdayActive=false;
          thursdayFrom.text='off';
        }


      } else if (time.day == 'friday' ) {
        if(time.type == 'on'){
          fridayActive=true;
          fridayFrom.text = time.startTime??'';
          fridayTo.text = time.endTime??'';
        }else{
          fridayActive=false;
          fridayFrom.text='off';
        }

      }
   }

  }
}
