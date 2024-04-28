import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/helpers/spacing.dart';
import 'package:cogina_restaurants/core/resources/color.dart';
import 'package:cogina_restaurants/core/resources/styles.dart';
import 'package:cogina_restaurants/core/routing/routes.dart';
import 'package:cogina_restaurants/domain/logger.dart';
import 'package:cogina_restaurants/presentation/component/custom_app_bar.dart';
import 'package:cogina_restaurants/presentation/modules/branches/widgets/branch_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/assets_constant/images.dart';
import 'branch_cubit.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BranchCubit cubit = BranchCubit.get(context);
    return
      Scaffold(
        backgroundColor: backGroundGray,
        appBar: CustomAppBar(
          color: backGroundGray,
          isBackButtonExist: false,
          title: 'الفروع',
          actions: [
            InkWell(
                onTap: () {
                  context.pushNamed(Routes.addBranchScreen);
                },
                child: const Icon(Icons.add)),
            IconButton(onPressed: () {
              context.pop();
            }, icon: const Icon(Icons.arrow_forward_ios)),


          ],
        ),
        //CustomBranchItemWidget(),
        body: BlocBuilder<BranchCubit, BranchState>(
          builder: (context, state) {
            if(cubit.branchesModel!=null){
              if(cubit.branchesModel!.data!.isEmpty){
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height*0.4,
                          child: SvgPicture.asset(AppImages.notFoundBranch,fit: BoxFit.contain,)),
                      verticalSpace(30),
                      Text('Not Found Any Branch Data Now',
                      style: TextStyles.font20Black700Weight.copyWith(color: Colors.grey.shade700,fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }else{
                return ListView.builder(
                    itemCount: cubit.branchesModel!.data!.length,
                    itemBuilder: (context,index){
                      return CustomBranchItemWidget(branchesModel:cubit.branchesModel!.data![index],);
                    });
              }
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }

          },
        ),
      );
  }
}
