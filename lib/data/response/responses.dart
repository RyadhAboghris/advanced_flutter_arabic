import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numOfNotification')
  int? numOfNotification;
  CustomerResponse(this.id, this.name, this.numOfNotification);

  // from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: 'phone')
  int? phone;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'link')
  String? link;
  ContactsResponse(this.phone, this.email, this.link);

  // from json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contacts')
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  CustomerResponse? support;
  // String? support;

  ForgotPasswordResponse(this.support);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

  // from json
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  ServiceResponse(this.id, this.title, this.image);

  // to json
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);

  // from json
  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);
}

@JsonSerializable()
class BannersResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'link')
  String? link;
  BannersResponse(this.id, this.title, this.image, this.link);

  // to json
  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);

  // from json
  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  StoreResponse(this.id, this.title, this.image);

  // to json
  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);

  // from json
  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: 'services')
  List<ServiceResponse>? services;
  @JsonKey(name: 'banners')
  List<ServiceResponse>? banners;
  @JsonKey(name: 'stores')
  List<ServiceResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);

  // to json
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

  // from json
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

@JsonSerializable()
class HomeRespons extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeRespons(this.data);

  // to json
  Map<String, dynamic> toJson() => _$HomeResponsToJson(this);

  // from json
  factory HomeRespons.fromJson(Map<String, dynamic> json) =>
      _$HomeResponsFromJson(json);
}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'titel')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'services')
  String? services;
  @JsonKey(name: 'about')
  String? about;

  StoreDetailsResponse(
    this.id,
    this.title,
    this.image,
    this.details,
    this.services,
    this.about,
  );

  // to json
  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);

  // from json
  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);
}
