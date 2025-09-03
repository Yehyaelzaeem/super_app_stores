
import 'dart:io';

class CompleteProfileBody {
  String? nameAr;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? type;
  String? category;
  String? lat;
  String? long;
  File? image;


  Map<String, dynamic> toJson() {
    if(image !=null){
      return {
        if ((nameAr ??'').isNotEmpty) "name": nameAr,
        if (image != null) "image": image!.path,
        if ((email ??'').isNotEmpty)"email": email,
        if ((address ??'').isNotEmpty) "address": address,
        if ((mobile ??'').isNotEmpty) "phone": mobile,
        if  ((type ??'').isNotEmpty)"type": type,
        if ((category ??'').isNotEmpty) "category": category,
        if ((name ??'').isNotEmpty)"name_en": name,


        if ((lat ??'').isNotEmpty) "lat": lat,
        if ((long ??'').isNotEmpty)"long": long,

      };
    }else{
      return {
        if ((nameAr ??'').isNotEmpty) "name": nameAr,
        if ((email ??'').isNotEmpty)"email": email,
        if ((address ??'').isNotEmpty) "address": address,
        if ((mobile ??'').isNotEmpty) "phone": mobile,
        if  ((type ??'').isNotEmpty)"type": type,
        if ((category ??'').isNotEmpty) "category": category,
        if ((name ??'').isNotEmpty)"name_en": name,


        if ((lat ??'').isNotEmpty) "lat": lat,
        if ((long ??'').isNotEmpty)"long": long,

      };
    }

  }

  CompleteProfileBody({ this.nameAr, this.name, this.address,
     this.lat, this.long,this.category,
    this.mobile,
    this.email,
     this.type, this.image});




}
