import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:cogina_restaurants/core/resources/text_styles.dart';
import 'package:cogina_restaurants/presentation/component/custom_elevated_button.dart';
import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:cogina_restaurants/presentation/modules/auth/complete_profile/complete_profile_screen.dart';
import 'package:cogina_restaurants/presentation/modules/auth/otp/widgets/click_text.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/resources/color.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../../data/model/response/user_model.dart';
import '../../../../domain/request_body/check_otp_body.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/custom_app_bar.dart';
import '../../../component/spaces.dart';
import 'otp_cubit.dart';

class OTPScreen extends StatefulWidget {
  final String _phone;
  final CheckOTPType _checkOTPType;

  @override
  _OTPScreenState createState() => _OTPScreenState();

  const OTPScreen({
    super.key,
    required String phone,
    required CheckOTPType checkOTPType,
  })  : _phone = phone,
        _checkOTPType = checkOTPType;
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _codeController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void _onResendCode() async {
    await BlocProvider.of<OtpCubit>(context,listen: false).reSendCode(phone: widget._phone);
  }
  void _onSubmit(context) async {



    String otp = _codeController.text;
    if (otp.length==4) {

    var response = await BlocProvider.of<OtpCubit>(context,listen: false).otpCode(phone: widget._phone,otp: otp,type: widget._checkOTPType );

      if (response?.isSuccess ==true) {
         if(widget._checkOTPType==CheckOTPType.login){
           Navigator.pushNamedAndRemoveUntil(context, Routes.layoutScreen, (route) => false);

         }else{
           Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>CompleteProfileFirstScreen()),(d)=>false);
         }
        _codeController.clear();
      } else {
        // _codeController.clear();

      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<OtpCubit>().isLoading;

    return Scaffold(
      appBar: CustomAppBar(title: 'Phone Verification',
        actions: [
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: kScreenPaddingNormal.w + 10.w),
            child: Image.asset(
              AppImages.logo2,
              width: 25.w,
              height: 25.h,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .99,
            child:               ListView(
              children: [
                VerticalSpace( 50.h),

                Center(
                  child: Text(
                    el.tr(LocaleKeys.otpVerification),
                    textAlign: TextAlign.center,
                    style: const TextStyle().titleStyle().boldBlackStyle(),
                  ),
                ),
                VerticalSpace(kScreenPaddingNormal.h),
                Center(
                  child: Text(
                    '${el.tr(LocaleKeys.anAuthenticationCodeHasBeenSentTo)}\n ${widget._phone}',
                    textAlign: TextAlign.center,
                    style: const TextStyle().descriptionStyle(fontSize: 14).heightStyle(height: 1.4),
                  ),
                ),
                // const ConfirmCodeForm(),
                VerticalSpace(kScreenPaddingNormal.h),

                _buildForm(),
                _buildResendCode(),
                VerticalSpace(kScreenPaddingNormal.h),

                Center(child: CustomElevatedButton(
                    width: MediaQuery.sizeOf(context).width*0.8,
                    height: 45.h,
                    isLoading: isLoading,
                    buttonText: el.tr(LocaleKeys.verifyNow),
                    onTap: ()=> _onSubmit(context))),
                VerticalSpace( kScreenPaddingNormal.h),

              ],
            ),
          )

      ),
    );
  }

  _buildResendCode(){
    bool isLoading = context.watch<OtpCubit>().isResendLoading;
    bool isTimerDone = context.watch<OtpCubit>().isTimerDone;

    return Column(
     children: [
       isLoading?const CustomLoadingWidget():
       TextClickWidget(
         text: el.tr(LocaleKeys.iDidNotReceiveCode),
         subText: el.tr(LocaleKeys.resendCode),
         onTap: ()=> _onResendCode(),
       ),

       VerticalSpace( kScreenPaddingNormal.h),
       if(!isTimerDone && !isLoading)
       Row(
         mainAxisSize: MainAxisSize.min,
         children: [
           TimerCountdown(
             format: CountDownTimerFormat.minutesSeconds,
             enableDescriptions: false,
             endTime: DateTime.now().add(const Duration(minutes: 1)),
             spacerWidth: 1.0,
             timeTextStyle: const TextStyle().regularStyle(),
             onEnd: () => BlocProvider.of<OtpCubit>(context,listen: false).onTimerEnd(),
           ),
           Text(' ${el.tr(LocaleKeys.secLeft)}',style:const TextStyle().regularStyle(),)
         ],
       ),
     ],
   );
  }

  _buildForm(){
    return  Directionality(
      textDirection: TextDirection.ltr,
      child:
    PinCodeTextField(

      appContext: context,
      length: 4,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      obscureText: false,
      showCursor: false,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        inactiveColor: Colors.grey.shade200,
        disabledColor: Colors.grey.shade200,
        activeColor:Colors.grey.shade300,
        selectedColor: Colors.red.shade100,
        errorBorderColor: Theme.of(context).cardColor,
        inactiveFillColor: Theme.of(context).cardColor,
        selectedFillColor: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(kFormRadius),
        fieldHeight: 48.r,
        fieldWidth: 48.r,
        activeFillColor: Theme.of(context).cardColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      textStyle: const TextStyle().titleStyle(fontSize: 24).activeColor(),
      enableActiveFill: true,
      boxShadows: const [ BoxShadow(color: grayScaleLiteColor, spreadRadius: 1, blurRadius: 5)],
      controller: _codeController,
      beforeTextPaste: (text) {return true;}, onChanged: (String value) {},
    ),);
  }
}
