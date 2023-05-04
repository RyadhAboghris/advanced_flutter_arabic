class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

// {
//   "user_name":"abc",
//   "country_mobile_code":"+966",
//   "mobile_number":"123456789",
//   "email":"abc@gamil.com",
//   "password":"123456",
//   "profile_picture":""
// }
class RegisterRequest {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterRequest(
    this.userName,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password,
    this.profilePicture,
  );
}
