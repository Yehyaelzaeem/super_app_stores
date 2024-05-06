class ProductsCategoriesModel {
  List<ProductsCategoriesModelData>? data;

  ProductsCategoriesModel({this.data});

  ProductsCategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductsCategoriesModelData>[];
      json['data'].forEach((v) {
        data!.add( ProductsCategoriesModelData.fromJson(v));
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

class ProductsCategoriesModelData {
  int? id;
  String? name;

  ProductsCategoriesModelData({this.id, this.name});

  ProductsCategoriesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
