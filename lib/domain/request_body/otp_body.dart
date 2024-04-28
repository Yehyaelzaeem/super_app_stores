class OTPBody{
  String _phone;
  OTPBody({
    required String phone,
  })  : _phone = phone;


  String get phone => _phone;

  Map<String, dynamic> toJson() {
    return {
      "phone": _phone,
    };
  }
  setData({
    required String phone,
  }){
    _phone = phone;
  }


}
