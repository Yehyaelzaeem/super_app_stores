class PrescriptionModel {
  List<PrescriptionModelData>? data;

  PrescriptionModel({this.data});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PrescriptionModelData>[];
      json['data'].forEach((v) {
        data!.add(new PrescriptionModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrescriptionModelData {
  int? id;
  String? image;
  String? status;
  String? note;
  Client? client;

  PrescriptionModelData({this.id, this.image, this.client, this.note});

  PrescriptionModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    note = json['note'];
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }
}

class Client {
  String? name;
  String? phone;
  String? address;
  dynamic addressId;
  String? addressNot;
  Location? location;
  String? image;

  Client(
      {this.name,
        this.phone,
        this.address,
        this.addressId,
        this.addressNot,
        this.location,
        this.image});

  Client.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    addressId = json['address_id'];
    addressNot = json['address_not'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['address_id'] = this.addressId;
    data['address_not'] = this.addressNot;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Location {
  dynamic lat;
  dynamic lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
