import 'package:cogina_restaurants/core/helpers/spacing.dart';
import 'package:cogina_restaurants/core/resources/color.dart';
import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/extra_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../../data/model/response/products_model.dart';
import '../../../../../component/custom_app_bar.dart';
import '../../../../../component/custom_rate.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductData product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print(product.toJson());
    return Scaffold(
      // backgroundColor: backGroundGray,
      backgroundColor: whiteColor,
       // appBar: CustomAppBar(
       //     color: backGroundGray,
       //     // title: LocaleKeys.mealDetails.tr(),
       // ),
      body:
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height:MediaQuery.of(context).size.height*0.35,
              child: ClipRRect(
                child: CustomImage(image: product.image!,fit: BoxFit.cover,),
              ),
            ),
            Container(
              width: double.infinity,
              color: whiteColor,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    verticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child:  Text(product.name??'',style: TextStyles.font18Black700Weight.copyWith(
                            color: backBlue2
                        ),),),
                        if(product.priceAfterDiscount!=null && product.priceAfterDiscount!='0' && product.priceAfterDiscount!=0)
                          Text('${product.priceAfterDiscount} ${LocaleKeys.currency.tr()}',style: TextStyles.font18Black700Weight.copyWith(
                              color: backBlue2
                          ),)
                      ],
                    ),
                    verticalSpace(10),
                    RatingWidget(filledStar: Icons.star, halfStar: Icons.star_half, emptyStar: Icons.star_border,
                      rating: double.parse(product.rate?.toString()??'0.0'), onChanged: (double c) {
                        print(c);
                      },),
                    verticalSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.discount.tr(),style: TextStyles.font18Black700Weight.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 13
                        )),
                        Text('${product.discount}%',style: TextStyles.font18Black700Weight.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 13
                        )),
                      ],
                    ),
                    verticalSpace(10),
                    Text(LocaleKeys.description.tr(),style: TextStyles.font18Black700Weight.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: backBlue2
                    )),
                    verticalSpace(10),
                    Text('${product.description}',style: TextStyles.font18Black700Weight.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12
                    )),
                    verticalSpace(10),
                    if(product.productSize!=null&&product.productSize!.data!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.price.tr(),style: TextStyles.font18Black700Weight.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: backBlue2
                          )),
                          verticalSpace(10),
                          ...product.productSize!.data!.map((e) =>
                              ExtraItem(extraName: e.name??'', extraPrice: e.priceAfterDiscount?.toString()??'',),)
                        ],
                      )
                    else
                      const SizedBox.shrink(),
                    verticalSpace(10),
                    if(product.extra!=null&&product.extra!.data!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.additions.tr(),style: TextStyles.font18Black700Weight.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: backBlue2
                          )),
                          verticalSpace(10),
                          ...product.extra!.data!.map((e) =>
                              ExtraItem(extraName: e.name??'', extraPrice: e.price??'',),)
                        ],
                      )
                    else
                      const SizedBox.shrink(),
                    if(product.bestDishes==1)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        child:
                       FittedBox(
                         fit: BoxFit.scaleDown,
                         child:   Row(
                           children: [
                             Text('${LocaleKeys.bestDishesMess2.tr()}', style: TextStyles.font18Black700Weight.copyWith(
                                 fontSize:12.sp ,
                                 color: Colors.grey.shade700)),
                             Checkbox(
                                 value:true,
                                 onChanged: (bool? val){

                                 })
                           ],
                         ),
                       )
                      ),
                    verticalSpace(40),

                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
