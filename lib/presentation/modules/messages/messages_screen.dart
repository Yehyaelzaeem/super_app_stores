import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/routing/routes.dart';
import 'package:cogina_restaurants/presentation/modules/messages/widgets/person_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/decoration.dart';
import '../../../core/resources/styles.dart';
import '../../component/custom_app_bar.dart';
import '../../component/custom_elevated_button.dart';
import '../../component/custom_text_field.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: backGroundGray,
      appBar: CustomAppBar(
        color: backGroundGray,
        title: 'الرسائل',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PersonChatWidget(),
            PersonChatWidget(),
            PersonChatWidget(),
            PersonChatWidget(),
          ],
        ),
      ),
    );
  }
}
