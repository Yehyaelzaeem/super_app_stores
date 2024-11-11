class SendPrescriptionParams{
  String? id;
  String? price;
  String? notes;

  SendPrescriptionParams({this.id, this.price, this.notes});

  SendPrescriptionParams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    notes = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['note'] = this.notes;
    return data;
  }
}