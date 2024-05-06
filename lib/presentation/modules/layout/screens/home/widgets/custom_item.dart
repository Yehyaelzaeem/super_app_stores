import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../data/model/response/products_model.dart';
class CustomItem extends StatelessWidget {
  final CategoriesData categoriesData;
  const CustomItem({super.key,required this.categoriesData});
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        decoration: BoxDecoration(
            color: backGroundGray,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)
        ),
        child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 3.w),
          child:  Center(
            child: Text(categoriesData.name!,
              style: TextStyles.font18Black700Weight.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 17
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}
