class GetProfileModel {
  GetProfileModelData? data;

  GetProfileModel({this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  GetProfileModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
  Store? store;
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
    phone = json['phone'];
    status = json['status'];
    address = json['address'];
    image = json['image'];
    store = json['store'] != null ?  Store.fromJson(json['store']) : null;
    bankAccount = json['bank_account'] != null
        ? BankAccount.fromJson(json['bank_account'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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

class Store {
  int? id;
  String? name;
  String? nameAr;
  int? storeType;
  bool? approvedByAdmin;
  bool? status;
  Files? files;

  Store(
      {this.id,
        this.nameAr,
        this.name,
        this.storeType,
        this.approvedByAdmin,
        this.status,
        this.files});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    storeType = json['store_type'];
    approvedByAdmin = json['approved_by_admin'];
    status = json['status'];
    files = json['files'] != null ?  Files.fromJson(json['files']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['store_type'] = storeType;
    data['approved_by_admin'] = approvedByAdmin;
    data['status'] = status;
    if (files != null) {
      data['files'] = files!.toJson();
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
    final Map<String, dynamic> data =  <String, dynamic>{};
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
      {this.holderName,
        this.bankName,
        this.accountNumber,
        this.bankBranch,
        this.iban});

  BankAccount.fromJson(Map<String, dynamic> json) {
    holderName = json['holder_name'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    bankBranch = json['bank_branch'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['holder_name'] = holderName;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['bank_branch'] = bankBranch;
    data['iban'] = iban;
    return data;
  }
}
