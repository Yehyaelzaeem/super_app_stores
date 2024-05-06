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
        return cubit.productsCategoriesModel!=null?
        Padding(
          padding: EdgeInsets.only(top: 5.h,bottom: 10.h),
          child: StatefulBuilder(builder: (BuildContext context,void Function(void Function()) setState){
            return DropdownButton2<String>(
              isExpanded: true,
              underline: const SizedBox.shrink(),
              hint: Text(cubit.categoryValue ?? '', style:TextStyles.font16Black500Weight),
              items: cubit.productsCategoriesModel!.data!.map(( e) => DropdownMenuItem<String>(
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
              buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w) // Adjust the horizontal padding as needed

              ),

            );
          }),
        ):
        const SizedBox.shrink();
      },
    );
  }
}
