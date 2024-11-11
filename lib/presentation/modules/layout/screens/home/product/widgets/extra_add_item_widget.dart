import 'package:cogina_restaurants/data/model/response/extra_model.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_title_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/resources/color.dart';

class ExtraAddItemWidget extends StatelessWidget {
  final ExtraModel? extraModel;
  final SizeProductModel? sizeProductModel;
  final bool? isSizeProduct;
   const ExtraAddItemWidget({super.key,  this.extraModel, this.isSizeProduct, this.sizeProductModel});
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
                    child: Center(child: ProductTitleField(title:extraModel?.nameEn??sizeProductModel?.nameEn??'',color: primaryColor,)),
                  ),
                  horizontalSpace(5),
                   Expanded(
                    child:
                    Center(child: ProductTitleField(title: extraModel?.nameAr??sizeProductModel?.nameAr??'',color: primaryColor,)),
                  ),
                  horizontalSpace(5),
                   Expanded(
                    child:
                    Center(child: ProductTitleField(title: extraModel?.price.toString()??sizeProductModel?.price.toString()??'',color: primaryColor,)),
                  ),
                ],
              ),
            ),
          ),
           Positioned(
               top: 5,
               bottom: 5,
               left: 5,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: InkWell(
                    onTap: (){
                      if(isSizeProduct==true){
                        HomeCubit.get(context).removeSizeProduct(sizeProductModel!);
                      }else{
                        HomeCubit.get(context).removeExtra(extraModel!);
                      }
                    },
                    child: const Icon(Icons.delete_forever,color: redColor,)),
              ))
        ],
      ),
    );
  }
}
