
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
  String? description;
  CategoriesData? category;
  dynamic price;
  String? discount;
  dynamic priceAfterDiscount;
  int? rate;
  String? image;
  bool? published;
  ProductExtra? extra;

  ProductData(
      {this.id,
        this.name,
        this.description,
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
    description = json['description'];
    category =CategoriesData.fromJson(json['category']);
    price = json['price'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount'];
    rate = json['rate'];
    image = json['image'];
    published = json['published'];
    extra = json['extra'] != null
        ?  ProductExtra.fromJson(json['extra'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
     data['category'] = category;
    data['price'] = price;
    data['discount'] = discount;
    data['price_after_discount'] = priceAfterDiscount;
    data['rate'] = rate;
    data['image'] = image;
    data['published'] = published;
    if (extra != null) {
      data['extra'] = extra!.toJson();
    }
    return data;
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
  dynamic price;

  ProductExtraData({this.id, this.name, this.price});

  ProductExtraData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

