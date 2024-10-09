class OrdersModel {
  List<OrdersModelData>? data;
  MetaPagination? meta;
  OrdersModel({this.data, this.meta});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OrdersModelData>[];
      json['data'].forEach((v) {
        data!.add( OrdersModelData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? MetaPagination.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdersModelData {
  int? id;
  String? status;
  Client? client;
  String? orderPrice;
  String? discout;
  String? orderTotal;
  String? deliveryFees;
  String? promoCode;
  String? date;
  String? note;
  String? paymentMethod;
  OrdersDetails? details;

  OrdersModelData(
      {this.id,
        this.status,
        this.client,
        this.orderPrice,
        this.discout,
        this.orderTotal,
        this.deliveryFees,
        this.promoCode,
        this.date,
        this.note,
        this.paymentMethod,
        this.details});

  OrdersModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    client =
    json['client'] != null ?  Client.fromJson(json['client']) : null;
    orderPrice = json['order_price'];
    discout = json['discout'];
    orderTotal = json['order_total'];
    deliveryFees = json['delivery_fees'];
    promoCode = json['promo_code'];
    date = json['date'];
    note = json['note'];
    paymentMethod = json['payment_method'];
    details = json['details'] != null
        ? OrdersDetails.fromJson(json['details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    data['order_price'] = orderPrice;
    data['discout'] = discout;
    data['order_total'] = orderTotal;
    data['delivery_fees'] = deliveryFees;
    data['promo_code'] = promoCode;
    data['date'] = date;
    data['payment_method'] = paymentMethod;

    return data;
  }
}

class Client {
  String? name;
  String? phone;
  String? address;
  int? addressId;
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
        ?  Location.fromJson(json['location'])
        : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['address_id'] = addressId;
    data['address_not'] = addressNot;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['image'] = image;
    return data;
  }
}

class Location {
  String? lat;
  String? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
class OrdersDetails{
  List<OrdersDetailsData>? data;

  OrdersDetails({this.data});

  OrdersDetails.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OrdersDetailsData>[];
      json['data'].forEach((v) {
        data!.add( OrdersDetailsData.fromJson(v));
      });
    }
  }
}
class OrdersDetailsData {
  int? id;
  String? productName;
  String? productPrice;
  String? image;
  String? qtyPrice;
  int? qty;
  String? color;
  String? size;
  AdditionData? addition;

OrdersDetailsData(
      {this.id,
        this.productName,
        this.productPrice,
        this.image,
        this.qtyPrice,
        this.qty,
        this.color,
        this.size,
        this.addition});

OrdersDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    image = json['image'];
    qtyPrice = json['qty_price'];
    qty = json['qty'];
    color = json['color'];
    size = json['size'];
    addition = json['addition'] != null
        ? AdditionData.fromJson(json['addition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['image'] = image;
    data['qty_price'] = qtyPrice;
    data['qty'] = qty;
    data['color'] = color;
    data['size'] = size;
    if (addition != null) {
      data['addition'] = addition!.toJson();
    }
    return data;
  }
}

class AdditionData {
  int? id;
  String? name;
  String? price;

  AdditionData({this.id, this.name, this.price});

  AdditionData.fromJson(Map<String, dynamic> json) {
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

class MetaPagination {
  Pagination? pagination;

  MetaPagination({this.pagination});

  MetaPagination.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}
class Pagination {
  int? totalPages;
  int? currentPage;
  int? perPage;
  int? total;

  Pagination({this.currentPage, this.totalPages, this.perPage, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    perPage = json['per_page'];
    total = json['total'];
  }


}