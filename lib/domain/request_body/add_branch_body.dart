

class AddBranchBody {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? lat;
  String? lng;
  String? regionId;
  String? deliveryTime;


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "lat": lat,
      "lng": lng,
      "region_id": regionId,
      "delivery_time": deliveryTime,
    };
  }

  AddBranchBody({required this.name,required this.email,required this.phone,required this.address,required this.lat,
    required this.lng,required this.regionId,required this.deliveryTime});
}
