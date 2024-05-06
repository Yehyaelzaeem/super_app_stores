import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/resources/fonts/app_fonts.dart';
import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../data/model/response/products_model.dart';
import 'custom_chip.dart';

class MealItemWidget extends StatelessWidget {
  const MealItemWidget({super.key, required this.product});
  final ProductData product;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
      child: InkWell(
        onTap: (){
          context.pushNamed(Routes.productDetailsScreen,arguments: {"product":product});
        },
        child:
        Container(
          height: 130.h,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12,blurRadius: 2)],
            color: whiteColor,
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CustomImage(image: product.image!,radius: 15,),
                )
              ),
              horizontalSpace(2),
              Expanded(
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    verticalSpace(5),
                    Text(product.name!,
                      style: TextStyles.font18Black700Weight.copyWith(
                          fontWeight: FontWeight.bold,height: 0.5
                      ),
                    ),
                    Text(product.description!,
                      style: TextStyles.font15CustomGray400Weight.copyWith(
                          fontWeight: FontWeight.w600

                      ),
                    ),
                     product.extra!=null&&product.extra!.data!.isNotEmpty?
                     FittedBox(
                       child: SizedBox(
                         height: 30,
                         width: MediaQuery.of(context).size.width*0.5,
                         child: SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                           child: Row(
                             children: [
                               Wrap(
                                   spacing: 5,
                                   children: [
                                     ...product.extra!.data!.map((e) =>
                                         SizedBox(
                                           height: 30.h,
                                           child: FittedBox(
                                             child: OutlinedChip(
                                               backgroundColor: sandwichBackGround,
                                               avatarBackgroundColor: primaryColor,
                                               label: e.name!,
                                               price: '${e.price}',
                                             ),
                                           ),
                                         ),)
                                   ]),
                             ],
                           ),
                         ),
                       ),
                     ):const SizedBox.shrink(),
                     verticalSpace(5),

                     FittedBox(
                       child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${product.price!.toString()} ${LocaleKeys.lyd.tr()}',
                            style: TextStyles.font18Black700Weight.copyWith(
                                color: backBlue2,
                                fontSize: 15,
                                fontFamily: AppFonts.cairo,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          horizontalSpace(8),
                          Text('${product.priceAfterDiscount!.toString()} ${LocaleKeys.lyd.tr()}',
                            style: TextStyles.font18Black700Weight.copyWith(
                                color:gray2,
                                fontSize: 15,
                                fontFamily: AppFonts.cairo,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: gray2,
                                fontWeight: FontWeight.bold


                            ),
                          ),
                          // const Spacer(),
                          horizontalSpace(20),

                          InkWell(
                              onTap:(){
                                HomeCubit.get(context).getProductsCategories();
                                context.pushNamed(Routes.updateProductScreen,arguments:{'product':product});
                              },
                              child: const Icon(Icons.edit_calendar_outlined,color: customGray,)),
                          horizontalSpace(5),
                          InkWell(
                              onTap: (){
                                HomeCubit.get(context).deleteProducts(id: product.id!);
                              },
                              child: const Icon(Icons.delete,size: 25,color: redColor,)),
                          horizontalSpace(10),
                        ],
                                           ),
                     ),
                    verticalSpace(5),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
