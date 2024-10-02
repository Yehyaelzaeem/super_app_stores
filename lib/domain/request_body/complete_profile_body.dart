
import 'dart:io';

class CompleteProfileBody {
  String? nameAr;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? type;
  String? lat;
  String? long;
  File? image;


  Map<String, dynamic> toJson() {
    if(image !=null){
      return {
        "name": nameAr,
        "email": 'sss@gmail.com',
        "phone": '021',
        "address": address,
        "type": type,
        "image": image!.path,
        "name_en": name,
        "lat": lat,
        "long": long,
      };
    }else{
      return {
        "name": nameAr,
        "email": 'sss@gmail.com',
        "phone": '021',
        "address": address,
        "type": type,
        "name_en": name,
        "lat": lat,
        "long": long,
      };
    }

  }

  CompleteProfileBody({ this.nameAr, this.name, this.address,
     this.lat, this.long,
     this.type, this.image});




}
