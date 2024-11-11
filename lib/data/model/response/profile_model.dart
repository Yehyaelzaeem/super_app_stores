class GetProfileModel {
  GetProfileModelData? data;

  GetProfileModel({this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? GetProfileModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetProfileModelData {
  int? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? status;
  String? phone;
  String? address;
  String? image;
  StoreProfile? store;
  BankAccount? bankAccount;

  GetProfileModelData(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.email,
        this.status,
        this.phone,
        this.address,
        this.image,
        this.store,
        this.bankAccount});

  GetProfileModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    status = json['status'];
    phone = json['phone'];
    address = json['address'];
    image = json['image'];
    store = json['store'] != null ? StoreProfile.fromJson(json['store']) : null;
    bankAccount = json['bank_account'] != null
        ? BankAccount.fromJson(json['bank_account'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile_number'] = mobileNumber;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['image'] = image;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (bankAccount != null) {
      data['bank_account'] = bankAccount!.toJson();
    }
    return data;
  }
}

class Times {
  int? id;
  String? date;
  String? type;
  String? startTime;
  String? endTime;
  String? day;

  Times({this.id, this.date, this.type, this.startTime, this.endTime});

  Times.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    date = json['date'];
    type = json['type'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['day'] = day;
    data['type'] = type;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
class StoreType {
  int? id;
  String? name;

  StoreType({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory StoreType.fromMap(Map<String, dynamic> map) {
    return StoreType(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}
class StoreProfile {
  int? id;
  String? name;
  String? nameAr;
  StoreType? storeType;
  bool? approvedByAdmin;
  bool? status;
  String? deliveryTime;
  dynamic deliveryPrice;
  String? orderTime;
  String? appCommission;
  Files? files;
  List<Times>? times; // Add times list

  StoreProfile(
      {this.id,
        this.name,
        this.nameAr,
        this.storeType,
        this.approvedByAdmin,
        this.status,
        this.appCommission,
        this.deliveryTime,
        this.deliveryPrice,
         this.orderTime,
        this.files,
        this.times}); // Include times in constructor

  StoreProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    storeType = StoreType.fromMap(json['store_type']);
    deliveryTime = json['delivery_time'];
    deliveryPrice = json['delivery_fees'];
    orderTime = json['order_time'];
    appCommission = json['app_commission'];
    approvedByAdmin = json['approved_by_admin'];
    status = json['status'];
    files = json['files'] != null ? Files.fromJson(json['files']) : null;
    // Parse times if available
    if (json['time'] != null) {
      times = List<Times>.from(json['time'].map((x) => Times.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['store_type'] = storeType;
    data['approved_by_admin'] = approvedByAdmin;
    data['status'] = status;
    if (files != null) {
      data['files'] = files!.toJson();
    }
    // Include times in toJson
    if (times != null) {
      data['time'] = times!.map((x) => x.toJson()).toList();
    }
    return data;
  }
}

class Files {
  String? commercialId;
  String? tax;
  String? banner;

  Files({this.commercialId, this.tax, this.banner});

  Files.fromJson(Map<String, dynamic> json) {
    commercialId = json['commercial_id'];
    tax = json['tax'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commercial_id'] = commercialId;
    data['tax'] = tax;
    data['banner'] = banner;
    return data;
  }
}

class BankAccount {
  String? holderName;
  String? bankName;
  String? accountNumber;
  String? bankBranch;
  String? iban;

  BankAccount(
      {this.holderName, this.bankName, this.accountNumber, this.bankBranch, this.iban});

  BankAccount.fromJson(Map<String, dynamic> json) {
    holderName = json['holder_name'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    bankBranch = json['bank_branch'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['holder_name'] = holderName;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['bank_branch'] = bankBranch;
    data['iban'] = iban;
    return data;
  }
}
