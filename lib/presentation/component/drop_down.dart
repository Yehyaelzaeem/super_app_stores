
import 'package:cogina_restaurants/core/helpers/spacing.dart';
import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../core/resources/color.dart';
import 'custom_text_field.dart';

class DropDownField extends StatelessWidget {
  final List<DropDownItem> items;
  final String? title;
  final String? hint;
  final double? radius;
  final double? height;
  final Color? fillColor;
  final Color? hintColor;
  final Color? dropDownIconColor;
  final dynamic valueId;
  final TextStyle? texStyle;
  final String? prefixIcon;
  final Widget? iconWidget;
  final void Function(DropDownItem?)? onChanged;
  final bool isValidator;
  final String? Function(dynamic)? validator;
  final TextStyle? style;
  final TextStyle? titleStyle;
  final double? hintFontSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? marginDropDown;
  final bool isDecoration;
  final InputDecoration? inputDecoration;
  final bool isLoading;
  final bool disabled;
  final Color? backgroundColor;

  const DropDownField(
      {Key? key,
      required this.items,
      this.title,
      this.hint,
      this.onChanged,
      this.prefixIcon,
      this.texStyle,
      this.valueId,
      this.iconWidget,
      this.isValidator = true,
      this.validator,
      this.style,
      this.margin,
      this.marginDropDown,
      this.height,
      this.fillColor,
      this.hintColor,
      this.dropDownIconColor,
      this.hintFontSize, this.radius, this.titleStyle,
      this.isDecoration = false,
      this.inputDecoration,
      this.isLoading = false,
      this.disabled = false,
      this.backgroundColor,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? colorBorderSide = Colors.grey;
    Color? fillColor = Colors.white;
    TextEditingController controller = TextEditingController();
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 10)+ EdgeInsets.only(bottom: 8),

      // color: isDecoration ? null : backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title ?? '',
              style: titleStyle ?? Theme.of(context).textTheme.bodySmall,
            ),
            verticalSpace(5)
          ],
          Padding(
            padding: marginDropDown ?? EdgeInsets.zero,
            child: DropdownButtonFormField2<DropDownItem>(
              isExpanded: true,
              value: getDropDownItemById(valueId.toString()),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: inputDecoration ?? InputDecoration(
                // Add Horizontal padding using menuItemStyleData.padding so it matches
                // the menu padding when button's width is not specified.
                // constraints: BoxConstraints(
                //   minHeight: height ?? 48,
                //   maxHeight: height ?? 48,
                // ),
                filled: true,
                fillColor: fillColor,
                contentPadding: EdgeInsets.only(left: 2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorBorderSide
                  ),
                  borderRadius: BorderRadius.circular(radius ?? 12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorBorderSide ,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(radius ?? 12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorBorderSide
                  ),
                  borderRadius: BorderRadius.circular(radius ?? 12),
                ),
                prefixIcon: iconWidget ??
                    (prefixIcon != null
                        ? Icon(Icons.arrow_drop_down, color: dropDownIconColor ?? primaryColor)
                        : null),

                errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red),
                // Add more decoration..
              ),
              hint: Text(
                hint ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: hintFontSize ?? 12, color: hintColor),
                overflow: TextOverflow.ellipsis,
              ),
              items: items
                  .map((item) => DropdownMenuItem<DropDownItem>(
                        value: item,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            item.title ?? '',
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                  .toList(),
              // validator: isValidator
              //     ? (value) => Validation.validateRequired(value?.title ?? '')
              //     : null,
              onChanged: onChanged,
              onSaved: (value) {
                //  selectedValue = value.toString();
              },
              buttonStyleData: ButtonStyleData(
                // padding: 10.paddingVert,

                height: height,
              ),
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding:EdgeInsets.only(right: 10),
                  child: isLoading ?  CustomLoadingWidget(size:25) :
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                ),
                iconSize: 25,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                // offset: Offset(0, 0),
                openInterval: const Interval(0.25, 0.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 8),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.15),
                      offset: const Offset(0, 0),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              dropdownSearchData: items.length < 10 ? null :
              DropdownSearchData(
                searchInnerWidgetHeight: 50,
                searchController: controller,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'search',
                    controller: controller,
                    prefixIcon: Icon(Icons.search, color: primaryColor),
                  ),
                ),
                searchMatchFn: (DropdownMenuItem<DropDownItem> item, String text) {
                  return item.value?.title
                      ?.toLowerCase()
                      .contains(text.toLowerCase()) ??
                      false;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropDownItem? getDropDownItemById(String id) {
    if (id.isEmpty) return null;
    return items.firstWhereOrNull((element) => element.id == id);
  }
}

// class DefaultDropDown extends StatelessWidget {
//   final List<DropdownMenuItem>? items;
//   final String? hintText;
//   final String? value;
//   final TextStyle? texStyle;
//   final IconData? prefixIcon;
//   final bool? isLoading;
//   final void Function(dynamic)? onChanged;
//   final bool isValidator;
//   const DefaultDropDown({Key? key, this.items, this.hintText, this.value, this.texStyle, this.prefixIcon, this.isLoading = false, this.onChanged, this.isValidator = true}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  isLoading! ? DropDownField(
//       prefixIcon: prefixIcon,
//       hint: hintText,
//   //    iconWidget: const LoadingWidget(size: 40, strokeWidth: 2.5),
//     ) : DropDownField(
//       prefixIcon: prefixIcon,
//       hint: hintText,
//       texStyle:Theme.of(context).textTheme.labelSmall,
//       items: items,
//       onChanged: onChanged,
//       isValidator: isValidator,
//     );
//   }
// }

class DropDownItem {
  final String? id;
  final String? title;
  final String? value;
  final IconData? icon;
  final Widget? child;

  const DropDownItem({this.id, this.title, this.value, this.icon, this.child});
}
