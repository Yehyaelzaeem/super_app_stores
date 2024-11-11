

import 'dart:io';

class AddProductBody {
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  String? price;
  String? discount;
  File?   image;
  String? categoryId;
  String? sizeNameEn;
  String? sizeNameAr;
  String? sizePrice;
  String? additionName;
  String? bestDishes;
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
        this.bestDishes,
        this.categoryId,
        this.sizeNameEn,
        this.sizeNameAr,
        this.sizePrice,
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
        "best_dishes": bestDishes,
        "size_name": sizeNameEn,
        "size_name_ar": sizeNameAr,
        "size_price": sizePrice,
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
        "size_name": sizeNameEn,
        "size_name_ar": sizeNameAr,
        "size_price": sizePrice,
        "price": price,
        "discount": discount,
        "category_id": categoryId,
        "addition_name": additionName,
        "addition_name_ar": additionNameAr,
        "addition_price": additionPrice,
        "best_dishes": bestDishes,

      };
    }


  }
}
