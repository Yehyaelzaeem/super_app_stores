
class ProfileBody {
  String? _firstName;
  String? _lastName;
  String? _mobile;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    (_mobile ?? '').isNotEmpty ? data['mobile'] = _mobile : null;
    (_firstName ?? '').isNotEmpty ? data['first_name'] = _firstName : null;
    (_lastName ?? '').isNotEmpty ? data['last_name'] = _lastName : null;
    return data;
  }


  ProfileBody({

    required String firstName,
    required String lastName,
    required String mobile,

  })  :
        _firstName = firstName,
        _lastName = lastName,
        _mobile = mobile;


  void setData(
      {
        required String firstName,
        required String lastName,
        required String mobile,
        }) {
    _firstName = firstName;
    _lastName = lastName;
    _mobile = mobile;
  }


}