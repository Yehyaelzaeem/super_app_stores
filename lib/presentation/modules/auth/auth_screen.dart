
import 'package:cogina_restaurants/presentation/modules/auth/widget/auth_widget.dart';
import 'package:cogina_restaurants/presentation/modules/auth/widget/complete_data.dart';
import 'package:cogina_restaurants/presentation/modules/auth/widget/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/assets_constant/images.dart';
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
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  verticalSpace(70),
                  Image.asset(AppImages.logo),
                  verticalSpace(20),

                  // verticalSpace(cubit.type=='auth'||cubit.type=='otp'?60:10),
                  cubit.type=='auth'?const AuthWidget():
                  cubit.type=='otp'?const OtpWidget():
                  CompeteDataWidget(height: MediaQuery.of(context).size.height*0.885,),
                ],
              ),
            ),
          );
        },
      )
    );
  }

}
