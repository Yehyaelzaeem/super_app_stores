import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async'; // for StreamController
import '../../core/resources/color.dart';
import '../../core/resources/fonts/app_fonts.dart';

class ChooseFromListItemWidget extends StatefulWidget {
  final List<ChooseItemListModel> items;
  final void Function(ChooseItemListModel item) onChoose;
  final double? radius;
  final double? width;
  final double? height;
  final bool? isHasInitialItem;
  final String? value;

  ChooseFromListItemWidget({
    Key? key,
    this.width,
    this.value,
    this.height,
    required this.onChoose,
    this.radius,
    this.isHasInitialItem,
    required this.items,
  }) : super(key: key);

  @override
  _ChooseFromListItemWidgetState createState() => _ChooseFromListItemWidgetState();
}

class _ChooseFromListItemWidgetState extends State<ChooseFromListItemWidget> {
  final StreamController<String> _selectedItemStreamController = StreamController<String>();

  @override
  void initState() {
    super.initState();
    // Initialize with a default value if there's an initial item
    if (widget.isHasInitialItem != false && widget.value != null) {
      _selectedItemStreamController.add(widget.value!);
    } else {
      _selectedItemStreamController.add('');
    }
  }

  @override
  void dispose() {
    _selectedItemStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _selectedItemStreamController.stream,
      initialData: widget.isHasInitialItem != false ? widget.value : '',
      builder: (context, snapshot) {
        String selectedTitle = snapshot.data ?? '';
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.items.map((e) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                child: InkWell(
                  onTap: () {
                    _selectedItemStreamController.add(e.title); // Update stream with selected title
                    widget.onChoose(e);
                  },
                  child: Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                      color: selectedTitle == e.title ? primaryColor : Colors.blue.shade50,
                      border: Border.all(
                        color: selectedTitle == e.title ? Colors.white : Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(widget.radius ?? 8),
                      boxShadow: [
                        BoxShadow(
                          color:selectedTitle == e.title ? primaryColor.withOpacity(0.6):primaryColor.withOpacity(0.3),
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: selectedTitle == e.title ? Offset(4, 5) : Offset(2, 3),
                        )
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w) + EdgeInsets.only(bottom: 3.h),
                        child: Text(
                          e.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: AppFonts.lateefFont,
                            color: selectedTitle == e.title ? Colors.white : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class ChooseItemListModel {
  final int id;
  final String title;

  ChooseItemListModel({required this.id, required this.title});
}
