

import 'dart:io';

class AddProductBody {
  String? name;
  String? description;
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
        this.description,
        this.price,
        this.discount,
        this.image,
        this.categoryId,
        this.additionName,
        this.additionPrice,
        this.additionNameAr});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "discount": discount,
      "image": image!.path,
      "category_id": categoryId,
      "addition_name": additionName,
      "addition_name_ar": additionNameAr,
      "addition_price": additionPrice,
    };
  }
}
