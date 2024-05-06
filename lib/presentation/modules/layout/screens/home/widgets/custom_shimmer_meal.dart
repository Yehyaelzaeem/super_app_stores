import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../component/custom_shimmer.dart';


class CustomShimmerMeal extends StatelessWidget {
  const CustomShimmerMeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 2)],
        color: whiteColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.4,
            child:
            const CustomShimmer(widget:CustomImage(image:''),)
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              verticalSpace(1),

              CustomShimmer(widget:Container(
                 height: 15,
                 width: 85,
                 decoration:BoxDecoration(
                   color: Colors.grey,
                 borderRadius: BorderRadius.circular(30),),

               ),),

              CustomShimmer(widget:Container(
                height: 15,
                width: 150,
                decoration:BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),),

              ),),

              CustomShimmer(widget:Container(
                height: 15,
                width: 100,
                decoration:BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),),

              ),),
              verticalSpace(1),

            ],
          ),
          const Spacer(),
          CustomShimmer(widget:Container(
            height: 30,
            width: 30,
            decoration:BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5,),

          ),),),
          horizontalSpace(20)
        ],
      ),
    );
  }
}
