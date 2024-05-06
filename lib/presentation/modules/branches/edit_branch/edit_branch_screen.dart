import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/decoration.dart';
import '../../../../data/model/response/branches_model.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/custom_elevated_button.dart';
import '../branch_cubit.dart';
import '../widgets/branch_data_widget.dart';

class EditBranchScreen extends StatefulWidget {
  const EditBranchScreen({super.key, required this.branchesModelData});
  final BranchesModelData branchesModelData;

  @override
  State<EditBranchScreen> createState() => _EditBranchScreenState();
}

class _EditBranchScreenState extends State<EditBranchScreen> {
  @override
  void initState() {
    BranchCubit cubit=BranchCubit.get(context);
    cubit.storeName.text=widget.branchesModelData.name!;
    cubit.storeEmail.text=widget.branchesModelData.email!;
    cubit.storePhone.text=widget.branchesModelData.phone!;
    cubit.storeAddress.text=widget.branchesModelData.address!;
    cubit.storeLocation.text='${widget.branchesModelData.lng!}/${widget.branchesModelData.lng!}';
    cubit.lat=double.parse(widget.branchesModelData.lat!);
    cubit.long=double.parse(widget.branchesModelData.lng!);
    for(var a in cubit.regionsModel!.data!){
      if(widget.branchesModelData.region!.id!.toString()==a.id.toString()){
        cubit.valueData=a.name;
        cubit.regionsId=a.id!;
        break;
      }
    }
    cubit.storeTime.text='';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    BranchCubit cubit=BranchCubit.get(context);
    return  Scaffold(
      backgroundColor: backGroundGray,
      appBar:  CustomAppBar(
        color: backGroundGray,
        title: LocaleKeys.branchEdit.tr(),
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
                      isLoading: state is UpdateBranchLoadingState,
                      backgroundColor: Colors.transparent,
                      onTap: (){
                        cubit.updateBranch(branchId: widget.branchesModelData.id!, context: context);
                      },
                      buttonText:LocaleKeys.update.tr(),
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
