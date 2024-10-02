import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/resources/styles.dart';

class ProductCategoriesWidget extends StatelessWidget {
  const ProductCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 5.h,bottom: 10.h),
          child: StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
            return Column(
              children: [
                DropdownButton2<String>(
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  hint: Text(cubit.categoryValue ?? '', style:TextStyles.font16Black500Weight),
                  items:
                  cubit.productsCategoriesModel==null?[]:
                  cubit.productsCategoriesModel!.data!.map(( e) => DropdownMenuItem<String>(
                    value: e.name,
                    child: Text(
                      e.name!,
                      style: TextStyles.font15CustomGray400Weight.copyWith(
                          fontSize: 20
                      ),
                    ),
                  )).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      cubit.categoryValue = value!;
                      for(var a in cubit.productsCategoriesModel!.data! ){
                        if(cubit.categoryValue==a.name){
                          cubit.categoryId=a.id!;
                          break;
                        }
                      }
                    });
                  },
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200.h, // Set the fixed height here
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  iconStyleData: IconStyleData(
                    icon: cubit.productsCategoriesModel == null?
                        const CustomLoadingWidget():
                    const Icon(Icons.keyboard_arrow_down)
                  ) ,
                  buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.w) // Adjust the horizontal padding as needed

                  ),

                ),
              ],
            );
          }),
        );
      },
    );
  }
}
