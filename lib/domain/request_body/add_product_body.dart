

import 'dart:io';

class AddProductBody {
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  String? price;
  String? discount;
  File? image;
  String? categoryId;
  String? additionName;
  String? additionNameAr;
  String? additionPrice;

  AddProductBody(
      {
        this.name,
        this.nameAr,
          this.description,
          this.descriptionAr,
        this.price,
        this.discount,
        this.image,
        this.categoryId,
        this.additionName,
        this.additionPrice,
        this.additionNameAr});

  Map<String, dynamic> toJson() {
    if(image!=null){
      return {
        "name": name,
        "name_ar": nameAr,
        "description": description,
        "description_ar": descriptionAr,
        "price": price,
        "discount": discount,
        "image": image!.path,
        "category_id": categoryId,
        "addition_name": additionName,
        "addition_name_ar": additionNameAr,
        "addition_price": additionPrice,
      };
    }else{
      return {
        "name": name,
        "name_ar": nameAr,
        "description": description,
        "description_ar": descriptionAr,
          
        "price": price,
        "discount": discount,
        "category_id": categoryId,
        "addition_name": additionName,
        "addition_name_ar": additionNameAr,
        "addition_price": additionPrice,
      };
    }


  }
}
