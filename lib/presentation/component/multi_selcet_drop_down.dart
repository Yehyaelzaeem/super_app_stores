import 'package:cogina_restaurants/core/resources/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../core/resources/styles.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/translations/locale_keys.dart';
import '../modules/auth/auth_cubit.dart';

class RestaurantCategoriesWidget extends StatefulWidget {
  final void Function(CategoryModel?)? onChanged;
  final void Function(List<CategoryModel>)? items;

  const RestaurantCategoriesWidget({super.key, this.onChanged, this.items});

  @override
  State<RestaurantCategoriesWidget> createState() =>
      _RestaurantCategoriesWidgetState();
}

class _RestaurantCategoriesWidgetState
    extends State<RestaurantCategoriesWidget> {
  final StreamController<List<CategoryModel>> _reasonModelListController =
  StreamController<List<CategoryModel>>.broadcast();

  List<CategoryModel> categoryModelList = [];
  AuthCubit cubit =
  AuthCubit.get(NavigationService.navigationKey.currentContext!);

  @override
  void initState() {
    cubit.restaurantCategoriesModel = null;
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
        if (cubit.restaurantCategoriesModel != null) {
          List<CategoryModel> allCategories = cubit
              .restaurantCategoriesModel?.data
              ?.map((e) => CategoryModel(id: e.id??0, name: e.name??''))
              .toList() ??
              [];
           if(allCategories.isEmpty)return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MultiSelectDialogField<CategoryModel>(
                items: allCategories
                    .map((cat) =>
                    MultiSelectItem<CategoryModel>(cat, cat.name))
                    .toList(),
                title: Text(LocaleKeys.categories.tr()),
                selectedColor: primaryColor,
                decoration: BoxDecoration(
                  color: grayBackGroundColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                buttonText: Text(
                  LocaleKeys.categories.tr(),
                  style: TextStyles.font16Black500Weight
                      .copyWith(color: Colors.grey),
                ),
                onConfirm: (selected) {
                  categoryModelList = selected;
                  _reasonModelListController.sink.add(categoryModelList);
                  widget.items?.call(categoryModelList);
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (item) {
                    categoryModelList.remove(item);
                    _reasonModelListController.sink.add(categoryModelList);
                    widget.items?.call(categoryModelList);
                  },
                ),
              ),
              // SizedBox(height: 10.h),
              // StreamBuilder<List<CategoryModel>>(
              //   stream: _reasonModelListController.stream,
              //   initialData: categoryModelList,
              //   builder: (context, snapshot) {
              //     return SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: Row(
              //         children: snapshot.data!
              //             .map((e) => Padding(
              //           padding:
              //           EdgeInsets.symmetric(horizontal: 5.w),
              //           child: InkWell(
              //             onTap: () {
              //               categoryModelList.remove(e);
              //               _reasonModelListController
              //                   .sink
              //                   .add(categoryModelList);
              //               widget.items?.call(categoryModelList);
              //             },
              //             child: Container(
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10.0),
              //                 color: primaryColor,
              //               ),
              //               child: Text(
              //                 e.name,
              //                 style: TextStyle(
              //                   fontSize: 15.sp,
              //                   color: whiteColor,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ))
              //             .toList(),
              //       ),
              //     );
              //   },
              // ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}
