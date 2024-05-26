
import 'dart:io';

class CompleteProfileBody {
  String? nameAr;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? type;
  File? image;


  Map<String, dynamic> toJson() {
    return {
      "name": nameAr,
      "email": email,
      "phone": mobile,
      "address": address,
      "type": type,
      "image": image!.path,
      "name_en": name,
    };
  }

  CompleteProfileBody({required this.nameAr,required this.name,required this.email,required this.mobile,required this.address,
    required this.type,required this.image});




}
