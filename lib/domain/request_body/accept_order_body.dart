class AcceptOrderBody{
  final int? orderId;
  final double? lat;
  final double? long;

  AcceptOrderBody({this.orderId, this.lat, this.long});

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "lat_from": lat,
      "lng_from": long,
    };
  }
}