
class HomeModel {
  Categories? categories;
  Products? productsModel;

  HomeModel({this.categories, this.productsModel});

  HomeModel.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ?  Categories.fromJson(json['categories'])
        : null;
    productsModel = json['products'] != null
        ? Products.fromJson(json['products'])
        : null;
  }


}
class Categories {
  List<CategoriesData>? data;

  Categories({this.data});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoriesData>[];
      json['data'].forEach((v) {
        data!.add( CategoriesData.fromJson(v));
      });
    }
  }


}

class CategoriesData {
  int? id;
  String? name;

  CategoriesData({this.id, this.name});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}
class ProductsModel {
  Products? products;

  ProductsModel({this.products});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ?  Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.toJson();
    }
    return data;
  }
}

class Products {
  List<ProductData>? data;

  Products({this.data});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add( ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  int? id;
  String? name;
  String? nameEn;
  String? nameAr;
  String? descriptionAr;
  String? descriptionEn;
  String? description;
  int? bestDishes;
  CategoriesData? category;
  dynamic price;
  String? discount;
  dynamic priceAfterDiscount;
  int? rate;
  String? image;
  bool? published;
  ProductExtra? extra;
  ProductSize? productSize;
  ProductData(
      {this.id,
        this.name,
        this.description,
        this.nameAr,
        this.nameEn,
        this.descriptionEn,
        this.productSize,
        this.descriptionAr,
        this.category,
        this.price,
        this.discount,
        this.priceAfterDiscount,
        this.rate,
        this.image,
        this.published,
        this.extra});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    descriptionAr = json['description_ar'];
    description = json['description'];
    descriptionEn = json['description_en'];
    bestDishes = json['best_dishes'];
    category =json['category'] != null
        ?  CategoriesData.fromJson(json['category'])
        : null;
    price = json['price'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount'];
    rate = json['rate'];
    image = json['image'];
    productSize = json['size'] != null
        ?  ProductSize.fromJson(json['size'])
        : null;
    published = json['published'];
    extra = json['extra'] != null
        ?  ProductExtra.fromJson(json['extra'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['description'] = description;
    data['description_ar'] = descriptionAr;
    data['description_en'] = descriptionEn;
    data['category'] = category;
    data['best_dishes'] = bestDishes;
    data['price'] = price;
    data['discount'] = discount;
    data['price_after_discount'] = priceAfterDiscount;
    data['rate'] = rate;
    data['image'] = image;
    data['published'] = published;
    if (extra != null) {
      data['extra'] = extra!.toJson();
    }
    if (productSize != null) {
      data['size'] = productSize!.toMap();
    }
    return data;
  }
}

class ProductSize{
  List<ProductSizeData>? data;

  ProductSize({this.data});

  ProductSize.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductSizeData>[];
      json['data'].forEach((v) {
        data!.add( ProductSizeData.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'data': this.data,
    };
  }



}
class ProductSizeData{
  int? id;
  String? name;
  String? nameAr;
  String? nameEn;
  dynamic price;
  dynamic priceAfterDiscount;

  ProductSizeData(
      {this.id,
        this.name,
        this.nameAr,
        this.nameEn,
        this.price,
        this.priceAfterDiscount});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'name_ar': this.nameAr,
      'name_en': this.nameEn,
      'price': this.price,
      'price_after_discount': this.priceAfterDiscount,
    };
  }

  factory ProductSizeData.fromMap(Map<String, dynamic> map) {
    return ProductSizeData(
      id: map['id'] as int,
      name: map['name'] as String,
      nameAr: map['name_ar'] as String,
      nameEn: map['name_en'] as String,
      price: map['price'] as dynamic,
      priceAfterDiscount: map['price_after_discount'] as dynamic,
    );
  }
}
class ProductExtra {
  List<ProductExtraData>? data;

  ProductExtra({this.data});

  ProductExtra.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductExtraData>[];
      json['data'].forEach((v) {
        data!.add( ProductExtraData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductExtraData {
  int? id;
  String? name;
  String? nameAr;
  String? nameEn;
  dynamic price;

  ProductExtraData({this.id, this.name, this.price});

  ProductExtraData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    nameEn = json['name_ar'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['price'] = price;
    return data;
  }
}

