import 'package:cogina_restaurants/core/helpers/spacing.dart';
import 'package:cogina_restaurants/core/resources/color.dart';
import 'package:cogina_restaurants/generated/locale_keys.g.dart';
import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/extra_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../../data/model/response/products_model.dart';
import '../../../../../component/custom_app_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductData product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backGroundGray,
      backgroundColor: whiteColor,
       appBar: CustomAppBar(
           color: backGroundGray,
           title: LocaleKeys.mealDetails.tr(),
       ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: whiteColor,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height:MediaQuery.of(context).size.height*0.35,
                    child: ClipRRect(
                      child: CustomImage(image: product.image!,fit: BoxFit.contain,),
                    ),
                  ),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name!,style: TextStyles.font18Black700Weight.copyWith(
                          color: backBlue2
                      ),),
                      Row(
                        children: [
                          const Icon(Icons.flag_rounded,color: backBlue2,size: 25,),
                          Text('${product.priceAfterDiscount} ${LocaleKeys.lyd.tr()}',style: TextStyles.font18Black700Weight.copyWith(
                              color: backBlue2
                          ),),
                        ],
                      ),
                    ],
                  ),
                  Text(product.rate.toString(),style: TextStyles.font18Black700Weight.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                  )),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocaleKeys.discount.tr(),style: TextStyles.font18Black700Weight.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17
                      )),
                      Text('${product.discount}%',style: TextStyles.font18Black700Weight.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17
                      )),
                    ],
                  ),
                  verticalSpace(10),
                  Text(LocaleKeys.description.tr(),style: TextStyles.font18Black700Weight.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    color: backBlue2
                  )),
                  verticalSpace(10),
                  Text('${product.description}',style: TextStyles.font18Black700Weight.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                  )),
                  verticalSpace(10),
                  if(product.extra!=null&&product.extra!.data!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.additions.tr(),style: TextStyles.font18Black700Weight.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                              color: backBlue2
                          )),
                          verticalSpace(10),
                          ...product.extra!.data!.map((e) =>
                              ExtraItem(extraName: e.name!, extraPrice: e.price!,),)
                        ],
                      )
                  else
                    const SizedBox.shrink(),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
