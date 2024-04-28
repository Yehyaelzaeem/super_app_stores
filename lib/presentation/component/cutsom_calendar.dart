import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resources/color.dart';
import '../../core/resources/styles.dart';

class CustomCalender extends StatelessWidget {
  const CustomCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {},
      headerProps:  EasyHeaderProps(
        selectedDateStyle:TextStyles.font16PrimaryColor700Weight.copyWith(
            fontWeight: FontWeight.w500
        ),
        monthStyle:TextStyles.font16PrimaryColor700Weight.copyWith(
            fontWeight: FontWeight.w500
        ),
        monthPickerType: MonthPickerType.switcher,
        dateFormatter: const DateFormatter.fullDateDMY(),
      ),
      dayProps:  EasyDayProps(
        height: 85.h,
        width: 60.w,
        dayStructure: DayStructure.dayStrDayNum,
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Colors.grey.shade200
          ),
        ),
        activeDayStyle:  DayStyle(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: whiteColor,
              border: Border.all(color: primaryColor,width: 2)

          ),
        ),
        activeDayNumStyle:TextStyles.font16PrimaryColor700Weight,
        activeDayStrStyle:TextStyles.font16PrimaryColor700Weight.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 13.sp
        ),
        inactiveDayNumStyle:TextStyles.font16Black600Weight.copyWith(
            color: customGray
        ),
        inactiveDayStrStyle:TextStyles.font16Black600Weight.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 13.sp,
            color: customGray

        ),
      ),

    );
  }
}
