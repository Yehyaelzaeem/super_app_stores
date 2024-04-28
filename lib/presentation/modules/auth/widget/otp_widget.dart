
import 'package:cogina_restaurants/domain/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import '../../../../../core/resources/decoration.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/styles.dart';
import '../../../component/custom_elevated_button.dart';
import '../auth_cubit.dart';
class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  bool _onEditing=true;
  String _code ='1234';
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit =AuthCubit.get(context);
    return  Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: whiteColor,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 2)
              ]),
          child: SizedBox(
            height: 300.h,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: backGroundGray,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
                  child: Center(
                    child: Text('تاكيد الرقم',
                    style: TextStyles.font20Black700Weight,
                    ),
                  ),
                ),
                verticalSpace(20),
                Text('ادخل كود OTP المرسل لك',
                  style: TextStyles.font18Black700Weight.copyWith(
                    color: Colors.grey
                  ),
                ),

                VerificationCode(
                  textStyle: TextStyle(fontSize: 20.0, color: Colors.blue.shade900,fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  underlineColor: backBlue2, // If this is null it will use primaryColor: Colors.red from Theme
                  length: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  cursorColor:  backBlue2, // If this is null it will default to the ambient
                  // clearAll is NOT required, you can delete it
                  // takes any widget, so you can implement your design
                  clearAll: const SizedBox.shrink(),
                  onCompleted: (String value) {
                    cubit.login(cubit.phoneController.text, value,context);
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
                verticalSpace(50),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 50.w),
                  child: Container(
                    decoration: Decorations.backGroundDecorationButton().copyWith(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return CustomElevatedButton(
                                                  isLoading: state is LoginLoadingState,
                                                  backgroundColor: Colors.transparent,
                                                  onTap: (){
                                                    cubit.login(cubit.phoneController.text, _code,context);
                                                  },
                                                  buttonText:'تاكيد',
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 40,
                                                  fontSize: 17,
                                                  borderRadius: 40,
                                                );
                              },
                            ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
