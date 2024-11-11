class BranchesModel {
  List<BranchesModelData>? data;

  BranchesModel({this.data});

  BranchesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BranchesModelData>[];
      json['data'].forEach((v) {
        data!.add(BranchesModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchesModelData {
  int? id;
  String? name;
  String? nameAr;
  String? address;
  String? phone;
  String? email;
  String? lat;
  String? lng;
  String? region;

  BranchesModelData(
      {this.id,
        this.name,
        this.address,
        this.phone,
        this.nameAr,
        this.email,
        this.lat,
        this.lng,
        this.region});

  BranchesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    lat = json['lat'];
    lng = json['lng'];
    region = json['region'];
    // region =
    // json['region'] != null ? new Region.fromJson(json['region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    // if (this.region != null) {
    //   data['region'] = this.region!.toJson();
    // }
    return data;
  }
}

class Region {
  int? id;
  String? name;

  Region({this.id, this.name});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
