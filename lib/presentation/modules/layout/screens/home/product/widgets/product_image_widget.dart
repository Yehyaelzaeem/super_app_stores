import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/decoration.dart';
import '../../../../../../../core/utils/toast_states/enums.dart';
import '../../../../../../component/custom_elevated_button.dart';
import 'extra_widget.dart';

class ProductImageAndButtonWidget extends StatelessWidget {
  const ProductImageAndButtonWidget({super.key, required this.type,  this.id, this.image});
  final String type;
  final int? id;
  final String? image;
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  cubit.pickImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white
                  ),
                  child:
                  cubit.productImageFile!=null?
                  SizedBox(
                    height:100.w,
                    width:150.w,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.file(cubit.productImageFile!,
                          fit: BoxFit.cover,
                        ),),
                    ),
                  ):
                  SizedBox(
                    height:100.w,
                    width:150.w,
                    child:  Center(
                      child:
                     type=='update' && image!=null?
                         CustomImage(image: image??'',radius: 25,
                          height: 100.h,
                           width: 150.w,
                         ):
                      Icon(Icons.add_photo_alternate_outlined,size: 100,color: Colors.grey,),
                    ),
                  ),
                ),
              ),
            ),
            verticalSpace(20),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: backGroundGray,
                    boxShadow: const [BoxShadow(color: Colors.black12,blurRadius: 7)]
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ExtraWidget(),
                  )),
            ),
            verticalSpace(20),
            Center(
              child: Container(
                decoration: Decorations.backGroundDecorationButton().copyWith(
                    borderRadius: BorderRadius.circular(40)
                ),
                child:
                CustomElevatedButton(
                  isLoading: state is AddProductLoadingState,
                  backgroundColor: Colors.transparent,
                  onTap: (){
                    if(type=='update'){
                      if(cubit.productFormKey.currentState!.validate()){
                        if(cubit.categoryId==null){
                          showToast(text: LocaleKeys.chooseCategory.tr(), state: ToastStates.error, context: context);
                        }
                        // else if(cubit.productImageFile==null){
                        //   showToast(text: LocaleKeys.chooseImage.tr(), state: ToastStates.error, context: context);
                        // }
                        else{
                          cubit.updateProduct(id: id??0, context: context);
                        }
                      }
                    }else{
                      if(cubit.productFormKey.currentState!.validate()){
                        if(cubit.categoryId==null){
                          showToast(text:  LocaleKeys.chooseCategory.tr(), state: ToastStates.error, context: context);
                        }
                        else if(cubit.productImageFile==null){
                          showToast(text: LocaleKeys.chooseImage.tr(), state: ToastStates.error, context: context);
                        }else{
                          cubit.addProduct();
                        }
                      }

                    }
                  },
                  buttonText:type=='update'?LocaleKeys.update.tr():LocaleKeys.add.tr(),
                  width: MediaQuery.of(context).size.width*0.5,
                  height: 40,
                  fontSize: 17,
                  borderRadius: 40,
                ),
              ),
            ),
            verticalSpace(20),
          ],
        );
      },
    );
  }
}
