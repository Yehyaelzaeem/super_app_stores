
import 'package:cogina_restaurants/presentation/modules/auth/widget/auth_widget.dart';
import 'package:cogina_restaurants/presentation/modules/auth/widget/complete_data.dart';
import 'package:cogina_restaurants/presentation/modules/auth/widget/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/resources/decoration.dart';
import 'auth_cubit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit =AuthCubit.get(context);
    cubit.removeCompleteDate(context);
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: Decorations.backGroundDecorationCircleBorderRadius(),
              child:   DefaultTabController(
                length: 2,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      verticalSpace(150),
                      // Image.asset(AppImages.logo),
                      verticalSpace(cubit.type=='auth'||cubit.type=='otp'?60:10),
                      cubit.type=='auth'?const AuthWidget():
                      cubit.type=='otp'?const OtpWidget():
                       CompeteDataWidget(height: MediaQuery.of(context).size.height*0.7,),
                    ],
                  ),
                ),
              ),
            );
        },
      )
    );
  }

}
