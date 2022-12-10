// ignore_for_file: always_specify_types

import 'dart:convert';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str) as Map<String, dynamic>);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.fullAddress,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryCode,
    required this.phoneNumber,
    required this.password,
    required this.birthDate,
    required this.gender,
    required this.height,
    required this.photos,
    required this.isProfileCompleted,
    required this.ethnicity,
    required this.work,
    required this.jobTitle,
    required this.school,
    required this.educationLevel,
    required this.religious,
    required this.homeTown,
    required this.politics,
    required this.languageSpoken,
    required this.datingIntentions,
    required this.relationType,
    required this.drinking,
    required this.smoking,
    required this.marijuana,
    required this.drugs,
    required this.phoneOtp,
    required this.authToken,
    required this.deviceToken,
    required this.loginType,
    required this.isPhoneVerified,
    required this.otpExpireTime,
    required this.lastLogin,
    required this.isActive,
    required this.isBlock,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullAddress:
            FullAddress.fromJson(json['fullAddress'] as Map<String, dynamic>),
        id: json['_id'].toString(),
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        countryCode: json['countryCode'] as int,
        phoneNumber: json['phoneNumber'].toString(),
        password: json['password'],
        birthDate: json['birthDate'] != null
            ? DateTime.parse(json['birthDate'] as String)
            : null,
        gender: json['gender'].toString(),
        height: json['height'],
        photos: List<dynamic>.from((json['photos'] as List).map((x) => x)),
        isProfileCompleted: json['isProfileCompleted'] as bool,
        ethnicity: json['ethnicity'],
        work: json['work'],
        jobTitle: json['jobTitle'],
        school: json['school'],
        educationLevel: json['educationLevel'],
        religious: json['religious'],
        homeTown: json['homeTown'],
        politics: json['politics'],
        languageSpoken: json['languageSpoken'],
        datingIntentions: json['datingIntentions'],
        relationType: json['relationType'],
        drinking: json['drinking'],
        smoking: json['smoking'],
        marijuana: json['marijuana'],
        drugs: json['drugs'],
        phoneOtp: json['phoneOTP'],
        authToken: json['authToken'] as int,
        deviceToken:
            List<dynamic>.from((json['deviceToken'] as List).map((x) => x)),
        loginType: json['loginType'] as int,
        isPhoneVerified: json['isPhoneVerified'] as bool,
        otpExpireTime: DateTime.parse(json['otpExpireTime'].toString()),
        lastLogin: DateTime.parse(json['lastLogin'].toString()),
        isActive: json['isActive'] as bool,
        isBlock: json['isBlock'] as bool,
        createdAt: DateTime.parse(json['createdAt'].toString()),
        updatedAt: DateTime.parse(json['updatedAt'].toString()),
        v: json['__v'] as int,
      );

  FullAddress fullAddress;
  String id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  int countryCode;
  String phoneNumber;
  dynamic password;
  DateTime? birthDate;
  String gender;
  dynamic height;
  List<dynamic> photos;
  bool isProfileCompleted;
  dynamic ethnicity;
  dynamic work;
  dynamic jobTitle;
  dynamic school;
  dynamic educationLevel;
  dynamic religious;
  dynamic homeTown;
  dynamic politics;
  dynamic languageSpoken;
  dynamic datingIntentions;
  dynamic relationType;
  dynamic drinking;
  dynamic smoking;
  dynamic marijuana;
  dynamic drugs;
  dynamic phoneOtp;
  int authToken;
  List<dynamic> deviceToken;
  int loginType;
  bool isPhoneVerified;
  DateTime otpExpireTime;
  DateTime lastLogin;
  bool isActive;
  bool isBlock;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Map<String, dynamic> toJson() => {
        'fullAddress': fullAddress.toJson(),
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'countryCode': countryCode,
        'phoneNumber': phoneNumber,
        'password': password,
        'birthDate': birthDate,
        'gender': gender,
        'height': height,
        'photos': List<dynamic>.from(photos.map((x) => x)),
        'isProfileCompleted': isProfileCompleted,
        'ethnicity': ethnicity,
        'work': work,
        'jobTitle': jobTitle,
        'school': school,
        'educationLevel': educationLevel,
        'religious': religious,
        'homeTown': homeTown,
        'politics': politics,
        'languageSpoken': languageSpoken,
        'datingIntentions': datingIntentions,
        'relationType': relationType,
        'drinking': drinking,
        'smoking': smoking,
        'marijuana': marijuana,
        'drugs': drugs,
        'phoneOTP': phoneOtp,
        'authToken': authToken,
        'deviceToken': List<dynamic>.from(deviceToken.map((x) => x)),
        'loginType': loginType,
        'isPhoneVerified': isPhoneVerified,
        'otpExpireTime': otpExpireTime.toIso8601String(),
        'lastLogin': lastLogin.toIso8601String(),
        'isActive': isActive,
        'isBlock': isBlock,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        '__v': v,
      };
}

class FullAddress {
  FullAddress({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
  factory FullAddress.fromJson(Map<String, dynamic> json) => FullAddress(
        address: json['address'].toString(),
        latitude: json['latitude'].toString(),
        longitude: json['longitude'].toString(),
      );

  String address;
  String latitude;
  String longitude;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      };
}
