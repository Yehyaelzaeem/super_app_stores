import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/decoration.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/custom_elevated_button.dart';
import '../branch_cubit.dart';
import '../widgets/branch_data_widget.dart';

class AddBranchScreen extends StatefulWidget {
  const AddBranchScreen({super.key});

  @override
  State<AddBranchScreen> createState() => _AddBranchScreenState();
}

class _AddBranchScreenState extends State<AddBranchScreen> {
  @override
  void initState() {
    BranchCubit cubit=BranchCubit.get(context);
    cubit.storeName.text='';
    cubit.storeEmail.text='';
    cubit.storePhone.text='';
    cubit.storeAddress.text='';
    cubit.storeLocation.text='';
    cubit.addressLocationModel=null;
    cubit.getLocation(context);
    cubit.valueData=LocaleKeys.region.tr();
    cubit.regionsId=null;
    cubit.storeTime.text='';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    BranchCubit cubit =BranchCubit.get(context);
    cubit.getLocation(context);
    return  Scaffold(
      backgroundColor: backGroundGray,
      appBar:  CustomAppBar(
        color: backGroundGray,
        title:LocaleKeys.addBranch.tr(),
      ),
      body:
      BlocConsumer<BranchCubit, BranchState>(
          listener: (context, state) {},
          builder: (context, state) {
            return
              SingleChildScrollView(
               child: Column(
                 children: [
                   const BranchDataWidget(),
                   verticalSpace(50),
                   Container(
                     height: 43,
                     decoration: Decorations.backGroundDecorationButton().copyWith(
                         borderRadius: BorderRadius.circular(40)
                     ),
                     child: CustomElevatedButton(
                       isLoading: state is AddBranchLoadingState,
                       backgroundColor: Colors.transparent,
                       onTap: (){
                         cubit.addBranch(context);
                       },
                       buttonText:LocaleKeys.done.tr(),
                       width: MediaQuery.of(context).size.width*0.5,
                       height: 35,
                       fontSize: 17,
                       borderRadius: 40,
                     ),
                   ),
                   verticalSpace(50)
                 ],
               ),
              );
          },
        ),
    );
  }
}
