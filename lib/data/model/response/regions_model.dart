class RegionsModel {
  List<RegionsModelData>? data;

  RegionsModel({this.data});

  RegionsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RegionsModelData>[];
      json['data'].forEach((v) {
        data!.add( RegionsModelData.fromJson(v));
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

class RegionsModelData {
  int? id;
  String? name;

  RegionsModelData({this.id, this.name});

  RegionsModelData.fromJson(Map<String, dynamic> json) {
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
