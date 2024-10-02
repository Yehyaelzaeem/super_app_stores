import 'package:easy_localization/easy_localization.dart';
import '../../../../core/helpers/date_formatter.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/translations/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/styles.dart';
import '../../../component/custom_text_field.dart';
import '../../../component/switch/text_switch.dart';
class TimeDayItem extends StatelessWidget {
  final String day;
  final String? initialValueFrom;
  final String? initialValueTo;
  final Function(String) onTapFrom;
  // bool isFullDay = false;
  // bool groupValue = false;
  final Function(String)? onChangeCycle;
  final Function(String) onTapTo;
  final bool? active;

  TimeDayItem({super.key, required this.day, required this.onTapFrom, required this.onTapTo, this.active, this.initialValueFrom, this.initialValueTo,  this.onChangeCycle});
  TextEditingController fromController = TextEditingController();
  TextEditingController fromControllerData = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool isSwitchActive = true;
  String? selectedCycle = '12';
  @override
  Widget build(BuildContext context) {
     if(initialValueFrom!=null && initialValueFrom!.isNotEmpty  && initialValueTo   !=null && initialValueTo!.isNotEmpty){
       if(initialValueFrom =='00:00:00' && initialValueTo =='11:59:59'){
         selectedCycle='24';
       }
     }

    if(initialValueFrom!=null && initialValueFrom!.isNotEmpty && initialValueFrom!='off'){
      fromController.text=DateFormatter.formatTimeHMS22(initialValueFrom!,context);
      fromControllerData.text=initialValueFrom!;
    }
    if(initialValueTo!=null && initialValueTo!.isNotEmpty){
      toController.text=DateFormatter.formatTimeHMS22(initialValueTo!,context);
    }
    isSwitchActive = active ?? true;

    return StatefulBuilder(builder: (context, setState) {
        return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h) +
                EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSwitchActive ? Colors.grey.shade200 : Colors.grey
                  .shade500,
              border: Border.all(color: Colors.grey.shade400, width: 1),

            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextSwitch(
                    value: isSwitchActive,
                    text: day,

                    onToggle: (bool x) {
                      setState(() {
                        isSwitchActive = x;
                        if(isSwitchActive==false){
                          onTapFrom('off');
                        }else{
                          onTapFrom(fromControllerData.text);
                          if(selectedCycle=='24'){
                            onChangeCycle!(selectedCycle!);
                          }
                          // onChangeCycle!(selectedCycle!);

                        }

                      });
                    },
                  ),
                  Divider(thickness: 1, color: Colors.grey.shade400,),

                  Stack(
              children: [
                Opacity(
                  opacity: isSwitchActive ? 1.0 : 0.5,
                  child: AbsorbPointer(
                    absorbing: !isSwitchActive,
                    child: Container(
                      color: isSwitchActive
                          ? Colors.grey.shade200
                          : Colors.grey.shade500,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        child:
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: '12',
                                      groupValue: selectedCycle,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCycle = newValue!;
                                          onChangeCycle!(newValue);
                                          fromController.text='';
                                          toController.text='';
                                        });
                                      },
                                    ),
                                    Text('12 ${LocaleKeys.hour.tr()}', style: TextStyles.font18Black700Weight.copyWith(color: Colors.grey.shade700)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: '24',
                                      groupValue: selectedCycle,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCycle = newValue!;
                                          onChangeCycle!(newValue!);
                                        });
                                      },
                                    ),
                                    Text('24 ${LocaleKeys.hour.tr()}', style: TextStyles.font18Black700Weight.copyWith(color: Colors.grey.shade700)),
                                  ],
                                ),
                              ],
                            ),
                            selectedCycle=='12'?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Text(
                                        '${LocaleKeys.from.tr()}',
                                        style: TextStyles.font18Black700Weight
                                            .copyWith(
                                            fontSize: 20,
                                            color: Colors.grey.shade800),
                                      ),
                                      horizontalSpace(10),
                                      SizedBox(
                                        width: 120.w,
                                        child: InkWell(
                                          onTap: () {
                                            print('from');
                                            HelperMethods.timePicker(context)
                                                .then((value) {
                                              fromController.text =
                                                  DateFormatter.formatTimeHM(
                                                      value, context);
                                              fromControllerData.text =
                                                  DateFormatter.formatTimeHMS(
                                                      value);
                                              onTapFrom(DateFormatter.formatTimeHMS(
                                                  value));
                                            });
                                          },
                                          child: CustomTextField(
                                            enabled: false,
                                            width: 100,
                                            height: 40,
                                            prefixIcon: Icon(
                                              Icons.access_time,
                                              color: Colors.grey.shade700,
                                              size: 20,
                                            ),
                                            hintText: '',
                                            hintStyle: TextStyles
                                                .font16Black500Weight
                                                .copyWith(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w600),
                                            textStyle: const TextStyle(
                                                fontSize: 15, color: customBlack),
                                            fillColor: backGroundGray,
                                            controller: fromController,
                                            borderRadius: 10,
                                            borderColor: Colors.grey.shade400,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Text(
                                        '${LocaleKeys.to.tr()}',
                                        style: TextStyles.font18Black700Weight
                                            .copyWith(
                                            fontSize: 20,
                                            color: Colors.grey.shade800),
                                      ),
                                      horizontalSpace(10),
                                      SizedBox(
                                        width: 120.w,
                                        child: InkWell(
                                          onTap: () {
                                            HelperMethods.timePicker(context)
                                                .then((value) {
                                              toController.text =
                                                  DateFormatter.formatTimeHM(
                                                      value, context);
                                              onTapTo(DateFormatter.formatTimeHMS(
                                                  value));
                                            });
                                          },
                                          child: CustomTextField(
                                            enabled: false,
                                            width: 100,
                                            height: 40,
                                            prefixIcon: Icon(
                                              Icons.access_time,
                                              color: Colors.grey.shade700,
                                              size: 20,
                                            ),
                                            hintText: '',
                                            hintStyle: TextStyles
                                                .font16Black500Weight
                                                .copyWith(
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w600),
                                            textStyle: const TextStyle(
                                                fontSize: 15, color: customBlack),
                                            fillColor: backGroundGray,
                                            controller: toController,
                                            borderRadius: 10,
                                            borderColor: Colors.grey.shade400,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ):SizedBox.shrink()
                          ],
                        )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ])
        );
      });
  }
}
