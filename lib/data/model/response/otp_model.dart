class OtpModel {
  int? code;
  String? message;
  AuthModel? item;

  OtpModel({this.code, this.message, this.item});

  OtpModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    item = json['item'] != null ?  AuthModel.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}
class AuthModel {
  AuthModelData? data;

  AuthModel({this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  AuthModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AuthModelData {
  String? mobileNumber;
  String? otp;

  AuthModelData({this.mobileNumber, this.otp});

  AuthModelData.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['mobile_number'] = mobileNumber;
    data['otp'] = otp;
    return data;
  }
}
