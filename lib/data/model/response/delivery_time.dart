class DeliveryTimeParams {
  final String? orderTime;
  final String? deliveryTime;
  final String? deliveryPrice;

  DeliveryTimeParams({
    this.orderTime,
    this.deliveryTime,
    this.deliveryPrice,
  });


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_time'] = this.orderTime;
    data['delivery_time'] = this.deliveryTime;
    data['delivery_fees'] = this.deliveryPrice;
    return data;
  }
}