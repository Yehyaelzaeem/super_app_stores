class OTPBody{
  String _phone;
  String _otp;
  OTPBody({
    required String phone,
    required String code,
  })  :
        _otp = code,
        _phone = phone;


  String get phone => _phone;
  String get otp => _otp;

  Map<String, dynamic> toJson() {
    return {
      "mobile_number": _phone,
      "otp": _otp,
      "country_id": 1,
    };
  }
  setData({
    required String phone,
    required String code,
  }){
    _phone = phone;
    _otp = code;
  }


}
