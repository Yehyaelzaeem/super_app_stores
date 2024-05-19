// import 'package:flutter/material.dart';
// import 'package:cogina_restaurants/core/translations/locale_keys.dart';
// import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../../core/resources/color.dart';
// import '../../../../../../data/model/response/orders_model.dart';
// import '../../../../../component/custom_divider.dart';
// import '../widgets/custom_row details.dart';
// class ProductDetailsScreen extends StatelessWidget {
//   final OrdersDetailsData ordersDetailsData;
//
//   const ProductDetailsScreen({super.key, required this.ordersDetailsData});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             CustomImage(
//                 height: MediaQuery.of(context).size.height*0.3,
//                 image: ordersDetailsData.image??''
//             ),
//             SizedBox(height: 25.h,),
//             Padding(
//                 padding:  EdgeInsets.symmetric(horizontal: 12.w),
//                 child:Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         CustomRowDetails(title: LocaleKeys.productName.tr(),value: ordersDetailsData.productName??'',),
//                         CustomRowDetails(title: LocaleKeys.price.tr(),dis:50.w,
//                           color: redColor,value: '${ordersDetailsData.productPrice!.toString()} ${LocaleKeys.lyd.tr()}',
//                           fontSize: 23,
//                         ),
//                       ],
//                     ),
//                     const CustomDivider(),
//                     CustomRowDetails(title: getLang(context, 'status'),value:productModelData.productStatus!,),
//                     CustomDivider(),
//                     Padding(
//                       padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
//                       child: Text(
//                         getLang(context, 'des'),
//                         style:
//                         TextStyles.font16GeryColor400WeightTajawal.copyWith(
//                             fontFamily: FontConstants.lateefFont,
//                             fontSize: 20,
//                             fontWeight: FontWeightManager.bold
//                         ),
//                       ),
//                     ),
//                     Text(
//                         productModelData.description!,
//                         style:
//                         TextStyles.font16BlackColor500WeightTajawal.copyWith(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 17,
//                           fontFamily: FontConstants.lateefFont,
//                         )
//                     ),
//                     SizedBox(height: 35.h,),
//                     isCart!=null?
//                     BlocConsumer<CartCubit, CartState>(
//                       listener: (BuildContext context,CartState state) {},
//                       builder: (BuildContext context,CartState state) {
//                         Cart  cartProduct=  Cart(
//                             id: productModelData.id,
//                             productId: productModelData.id.toString(),
//                             productName: productModelData.title,
//                             productPrice: productModelData.price,
//                             description: productModelData.description,
//                             image: productModelData.images!=null&&productModelData.images!.isNotEmpty?productModelData.images![0].image:"",
//                             type: productModelData.type,
//                             productState: productModelData.productStatus,
//                             providerId: productModelData.provider!=null?productModelData.provider!.id!.toString():'',
//                             count: 1,
//                             productBrand: productModelData.brand!=null?productModelData.brand!.name:'');
//                         return Column(children: <Widget>[
//                           if (cubit.products.where((Cart element) => element.id == productModelData.id).toList().length == 0)
//                             InkWell(onTap: (){
//                               if(AuthCubit.get(context).token.isNotEmpty){
//                                 if( cubit.products.isEmpty){
//                                   cubit.addProduct(cartProduct);
//                                 }
//                                 if(cubit.products[0].providerId == cartProduct.providerId ){
//                                   cubit.addProduct(cartProduct);
//
//                                 }else{
//                                   showToast(text: getLang(context, 'no_store'), state: ToastStates.error, context: context);
//                                 }
//                               }else{
//                                 visitorDialog(context);
//                                 // showToast(text: getLang(context, 'Log_in_first'),state: ToastStates.error, context: context);
//                               }
//
//                             },
//                               child: Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 9.w,vertical: 5),
//                                 height: 48.h,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(color: Colors.black),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 8.0,right: 8.0),
//                                   child: Center(
//                                     child: Text(getLang(context, 'add_cart'),style: TextStyle(
//                                         fontWeight: FontWeight.bold
//                                     ),),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           if (cubit.products.where((Cart element) => element.id == cartProduct.id).toList().length > 0)
//                             InkWell(
//                               onTap: (){
//                                 cubit.removeProduct(cartProduct);
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   margin: EdgeInsets.symmetric(horizontal: 12),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(17.0),
//                                     color: blueColor,
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                                     child: Center(
//                                       child: Icon(Icons.check_circle, color: primaryColor),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],);
//                       },
//                     ):SizedBox.shrink(),
//                     SizedBox(height: 50.h,),
//                   ],
//                 )
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
