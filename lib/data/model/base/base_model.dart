class BaseModel<E> {
  bool? statusCode;
  bool? status;
  String? code;
  dynamic message;
  E? item;
  E? response;
  E? categories;
  E? extra;


  BaseModel({ this.statusCode, this.status, this.code,  this.message, this.item, this.response,this.categories,this.extra});

 factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
      statusCode: ((json['code']??'200').toString() == '200')||((json['code']??'201').toString() == '201'),
      code: (json['code']??'200').toString(),
      message: json['message']??"Error",
      status: json['status'],
      item: json['item'],
      response: json['all_items'],
      categories: json['categories'],
      extra: json['extra']
 );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = statusCode;
    data['message'] = message;
    data['code'] = code;
    data['status'] = status;
    data['item'] = item??{};
    data['all_items'] = response??{};
    data['categories'] = categories??{};
    data['extra'] = extra??{};
    return data;
  }
}
