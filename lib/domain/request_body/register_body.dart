
class RegisterBody {
  String? _firstName;
  String? _lastName;
  String? _mobile;
  String? _email;
  String? _password;
  String? _confirmPassword;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    (_firstName ?? '').isNotEmpty ? data['first_name'] = _firstName : null;
    (_lastName ?? '').isNotEmpty ? data['last_name'] = _lastName : null;
    (_mobile ?? '').isNotEmpty ? data['mobile'] = _mobile : null;
    (_password ?? '').isNotEmpty ? data['password'] = _password : null;
    (_email ?? '').isNotEmpty ? data['email'] = _email : null;
    (_confirmPassword ?? '').isNotEmpty ? data['password_confirmation'] = _confirmPassword : null;

    return data;
  }


  RegisterBody({
    required String firstName ,
    required String confirmPassword,
    required String password,
    required String email,
    required String lastName,
    required String mobile,})
      : _firstName = firstName,
        _lastName = lastName,
        _mobile = mobile,
  _password = password,
  _confirmPassword = confirmPassword,
  _email = email;


  void setData(
      {
        required String firstName,
        required String lastName,
        required String email,
        required String password,
        required String confirmPassword,
        required String phone}) {
     _firstName = firstName;
     _lastName = lastName;
     _email = email;
     _confirmPassword = confirmPassword;
     _password = password;
     _mobile = phone;
  }


}
