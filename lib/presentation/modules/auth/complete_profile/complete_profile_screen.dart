import 'package:cogina_restaurants/presentation/component/google_map/custom_google_map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/decoration.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/translations/locale_keys.dart';
import '../../../../domain/provider/local_auth_provider_cubit.dart';
import '../../../component/custom_elevated_button.dart';
import '../../../component/custom_text_field.dart';
import '../../../component/google_map/address_location_model.dart';
import '../../../component/google_map/const_location_map.dart';
import '../../../component/google_map/pick_up_google_map.dart';
import '../auth_cubit.dart';
import '../widget/complete_data.dart';
import '../widget/restuaran_type_widget.dart';

class CompleteProfileFirstScreen extends StatelessWidget {
   CompleteProfileFirstScreen({super.key});
  AddressLocationModel? addressModel;
  TextEditingController pickUpController = TextEditingController(text: 'المنطقة/المدينة/البلدة/الشارع');
  @override
  Widget build(BuildContext context) {
    return
      CompeteDataWidget(height: MediaQuery.of(context).size.height*0.885,);
  }
}
