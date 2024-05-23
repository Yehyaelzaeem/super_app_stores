import 'package:cogina_restaurants/data/model/response/extra_model.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/resources/color.dart';

class ExtraAddItemWidget extends StatelessWidget {
  final ExtraModel extraModel;
   const ExtraAddItemWidget({super.key, required this.extraModel});
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Expanded(
                    child: Center(child: ProductTitleField(title:extraModel.nameEn,color: primaryColor,)),
                  ),
                  horizontalSpace(5),
                   Expanded(
                    child:
                    Center(child: ProductTitleField(title: extraModel.nameAr,color: primaryColor,)),
                  ),
                  horizontalSpace(5),
                   Expanded(
                    child:
                    Center(child: ProductTitleField(title: extraModel.price.toString(),color: primaryColor,)),
                  ),
                ],
              ),
            ),
          ),
           Positioned(
              top: 8,
              left: 5,
              child: InkWell(
                  onTap: (){
                    HomeCubit.get(context).removeExtra(extraModel);
                  },
                  child: const Icon(Icons.delete_forever,color: redColor,)))
        ],
      ),
    );
  }
}
