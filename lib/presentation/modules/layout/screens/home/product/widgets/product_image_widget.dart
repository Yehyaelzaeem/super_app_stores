import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/resources/decoration.dart';
import '../../../../../../../core/utils/toast_states/enums.dart';
import '../../../../../../component/custom_elevated_button.dart';

class ProductImageAndButtonWidget extends StatelessWidget {
  const ProductImageAndButtonWidget({super.key, required this.type,  this.id});
  final String type;
  final int? id;
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
                    child: const Center(
                      child: Icon(Icons.add_photo_alternate_outlined,size: 100,color: Colors.grey,),
                    ),
                  ),
                ),
              ),
            ),
            verticalSpace(20),
            Center(
              child: Container(
                decoration: Decorations.backGroundDecorationButton().copyWith(
                    borderRadius: BorderRadius.circular(40)
                ),
                child: CustomElevatedButton(
                  isLoading: state is AddProductLoadingState,
                  backgroundColor: Colors.transparent,
                  onTap: (){
                    if(type=='update'){
                      if(cubit.productFormKey.currentState!.validate()){
                        if(cubit.categoryId==null){
                          showToast(text: LocaleKeys.chooseCategory.tr(), state: ToastStates.error, context: context);
                        }
                        else if(cubit.productImageFile==null){
                          showToast(text: LocaleKeys.chooseImage.tr(), state: ToastStates.error, context: context);
                        }else{
                          cubit.updateProduct(id: id!=null?id!:0, context: context);
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
