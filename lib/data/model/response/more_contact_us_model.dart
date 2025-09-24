class MoreContactUsModel {
  dynamic data; // ممكن تبقى String أو List أو Map

  MoreContactUsModel({this.data});

  MoreContactUsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}
