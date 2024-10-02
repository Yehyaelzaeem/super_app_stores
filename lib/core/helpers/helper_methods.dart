import 'dart:convert';
import 'dart:io';

import 'package:app/src/auth/data/models/register_params.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../src/main_index.dart';
import '../../src/profile/data/models/profile_dto.dart';
import 'navigator.dart';

class HelperMethods {
  static Future<CroppedFile?> getImagePicker() async {
    XFile? imageFile;
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      aspectRatio: const CropAspectRatio(ratioX: 2, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
      ],
    );
  }

  static Future<File> getImageFromCamera() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    return File(pickedFile!.path);
  }

  static Future<File> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(pickedFile!.path);
  }

  static Future<List<File>> getImagesFromGallery() async {
    final pickedFile = await ImagePicker().pickMultiImage();
    return pickedFile.map((e) => File(e.path)).toList();
  }

  static showErrorToast(String msg,
      {Color? color, ToastGravity? gravity}) async {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showSuccessToast(String msg,
      {Color? color, ToastGravity? gravity}) async {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<void> launchCallPhone(String phoneNumber) async {
    Uri telephoneUrl = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(telephoneUrl)) {
      await launchUrl(telephoneUrl);
    } else {
      showErrorToast('حدث خطأ أثناء الاتصال بالرقم');
    }
  }

  static Future<void> launchWhatsApp(String phoneNumber) async {
    Uri whatsUpUrl = Uri.parse("whatsapp://send?phone=$phoneNumber");
    if (await canLaunchUrl(whatsUpUrl)) {
      await launchUrl(whatsUpUrl);
    } else {
      showErrorToast('حدث خطأ اثناء الاتصال بالواتساب');
    }
  }

  // telegram
  static Future<void> launchTelegram(String phoneNumber) async {
    Uri telegramUrl = Uri.parse("https://t.me/$phoneNumber");
    if (await canLaunchUrl(telegramUrl)) {
      await launchUrl(telegramUrl);
    } else {
      showErrorToast('حدث خطأ اثناء الاتصال بالتليجرام');
    }
  }

  static Future<void> launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showErrorToast('حدث خطأ أثناء الاتصال بالرابط');
    }
  }

  // show date picker
  static Future<String> datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      return picked.toString();
    }
    return '';
  }
  static Future<String> timePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      return selectedTime.toString();
    }
    return '';
  }

  static String formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    final String formatter = DateFormat('yyyy-MM-dd').format(dateTime);
    return formatter;
  }

  static setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
  }

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'en';
  }

  static Future<void> saveProfile(ProfileDto dto) async {

    try {
      GetStorage().write('profile',  jsonEncode(dto.toJson()));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (dto.token != null && dto.token!.isNotEmpty) {
        prefs.setString('profile', jsonEncode(dto.toJson()));
      } else {
        dto.token = await getToken();
        prefs.setString('profile', jsonEncode(dto.toJson()));
      }
    } on Exception catch (e) {
      print('e $e');
      rethrow;
    }
  }

  static Future<void> saveToken(String token) async {
    try {
      GetStorage().write('token',  token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
    } on Exception catch (e) {
      print('e $e');
      rethrow;
    }
  }
  static getProfile2(){
    var res = GetStorage().read('profile');
   return  ProfileDto.fromJson(jsonDecode(res));
  }
  static String getTokenStorage(){
    var res = GetStorage().read('token');
   return  res??'';
  }

  static Future<ProfileDto> getProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String profile = prefs.getString('profile') ?? '';
      print('profile $profile');
      final decoded = jsonDecode(profile);
      print('decoded $decoded');
      return ProfileDto.fromJson(decoded);
    } on Exception catch (e) {
      print('getProfile error $e');
      return ProfileDto();
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) async {
    ThemeData theme = Theme.of(context);
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime(3555),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: injector<ServicesLocator>().appContext.primaryColor,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  static Future<String> getToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token') ?? '';
    } on Exception catch (e) {
      return '';
    }
  }

  // is login
  static Future<bool> isLogin() async {
    try {
      String token = await getToken();
      return token.isNotEmpty && token != null;
    } on Exception catch (e) {
      return false;
    }
  }

  // remove token
  static Future<void> clearCashData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear().then((value) {
      pushNamedAndRemoveUntil(Routes.loginPage);
    });

  }

  static Future<bool> isFirstTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
      return isFirstTime;
    } catch (e) {
      return false;
    }
  }

  static Future<void> setFirstTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isFirstTime', false);
    } catch (e) {
      print('e $e');
    }
  }
}
