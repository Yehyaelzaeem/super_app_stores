import 'package:cogina_restaurants/core/resources/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import '../../core/resources/styles.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/translations/locale_keys.dart';
import '../modules/auth/auth_cubit.dart';
import 'drop_down.dart';


class RestaurantCategoriesWidget extends StatefulWidget {
  final void Function(DropDownItem?)? onChanged;
  final void Function(List<CategoryModel>)? items;
  const RestaurantCategoriesWidget({super.key, this.onChanged, this.items});

  @override
  State<RestaurantCategoriesWidget> createState() => _ReasonReturnsWidgetState();
}

class _ReasonReturnsWidgetState extends State<RestaurantCategoriesWidget> {
  final StreamController<List<CategoryModel>> _reasonModelListController = StreamController<List<CategoryModel>>.broadcast();

  List<CategoryModel> categoryModelList = [];
  AuthCubit cubit =AuthCubit.get(NavigationService.navigationKey.currentContext!);
 String? value;
 String? selectedValue;
  @override
  void initState() {
    cubit.restaurantCategoriesModel=null;
   // cubit.getRestaurantCategories();
    super.initState();
  }
  @override
  void dispose() {
    _reasonModelListController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        categoryModelList.clear();
        selectedValue=null;
        if(cubit.restaurantCategoriesModel!=null)
        return Column(
          children: [
            DropDownField(
              radius: 50,
              fillColor:grayBackGroundColor,
              valueId: value,
              hint:
              LocaleKeys.categories.tr(),
              hintWidget: Text(selectedValue!=null?selectedValue??'':'${LocaleKeys.categories.tr()}', style:
              selectedValue!=null?TextStyles.font16Black500Weight:TextStyles.font16Black500Weight.copyWith(color: Colors.grey),),

              isLoading: cubit.restaurantCategoriesModel == null,
              items: cubit.restaurantCategoriesModel?.data?.map((e) => DropDownItem(
                id: e.id.toString(),
                title: e.name,
                value: e.name,
              )).toList() ?? [],


              onChanged: (item) {
                value = item?.id;
                selectedValue = item?.title;
                widget.onChanged!(item);
                if (categoryModelList.where((element) => element.id == int.parse(item!.id!)).isEmpty) {
                  categoryModelList.add(CategoryModel(id: int.parse(item!.id!), name: item.title!));
                  _reasonModelListController.sink.add(categoryModelList);
                  widget.items!(categoryModelList);
                }
              },
            ),
            SizedBox(height: 10.h),
            StreamBuilder<List<CategoryModel>>(
              stream: _reasonModelListController.stream,
              initialData: categoryModelList,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: snapshot.data!.map((e) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: InkWell(
                        onTap: () {
                          categoryModelList.remove(e);
                          _reasonModelListController.sink.add(categoryModelList);
                          widget.items!(categoryModelList);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: primaryColor,
                          ),
                          child: Text(
                            e.name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: whiteColor,
                            ),
                          )
                        ),
                      ),
                    )).toList(),
                  ),
                );
              },
            ),
          ],
        );
        else
        return const SizedBox();
      },
    );
  }
}

class CategoryModel {

  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});
}
