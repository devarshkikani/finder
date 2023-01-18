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
    required this.phoneNumber,
    required this.birthDate,
    required this.gender,
    required this.height,
    required this.photos,
    required this.isProfileCompleted,
    required this.ethnicity,
    required this.sexuality,
    required this.work,
    required this.jobTitle,
    required this.aboutYourSelf,
    required this.educationLevel,
    required this.religious,
    required this.homeTown,
    required this.languageSpoken,
    required this.datingIntentions, //
    required this.relationType,
    required this.drinking,
    required this.smoking,
    required this.drugs,
    // required this.deviceToken,
    required this.isActive,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullAddress:
            FullAddress.fromJson(json['fullAddress'] as Map<String, dynamic>),
        id: json['_id'].toString(),
        firstName: json['firstName'].toString(),
        lastName: json['lastName'].toString(),
        email: json['email'].toString(),
        phoneNumber: json['phoneNumber'].toString(),
        birthDate: json['birthDate'] != null
            ? DateTime.parse(json['birthDate'] as String)
            : null,
        gender: json['gender'].toString(),
        height: json['height'].toString(),
        photos: List<String?>.from((json['photos'] as List).map((x) => x)),
        isProfileCompleted: json['isProfileCompleted'] as bool,
        ethnicity: json['ethnicity'].toString(),
        sexuality: json['sexuality'].toString(),
        work: json['work'].toString(),
        jobTitle: json['jobTitle'].toString(),
        aboutYourSelf: json['aboutYourSelf'].toString(),
        educationLevel: json['educationLevel'].toString(),
        religious: json['religious'].toString(),
        homeTown: json['homeTown'].toString(),
        languageSpoken: json['languageSpoken'].toString(),
        datingIntentions: json['datingIntentions'].toString(),
        relationType: json['relationType'].toString(),
        drinking: json['drinking'].toString(),
        smoking: json['smoking'].toString(),
        drugs: json['drugs'].toString(),
        // deviceToken:
        //     List<dynamic>.from((json['deviceToken'] as List).map((x) => x)),
        isActive: json['isActive'] as bool,
      );

  FullAddress fullAddress;
  String id;
  String firstName;
  String lastName;
  String? email;
  String phoneNumber;
  DateTime? birthDate;
  String gender;
  String height;
  List<String?> photos;
  bool isProfileCompleted;
  String ethnicity;
  String sexuality;
  String work;
  String jobTitle;
  String aboutYourSelf;
  String educationLevel;
  String religious;
  String homeTown;
  String languageSpoken;
  String datingIntentions;
  String relationType;
  String drinking;
  String smoking;
  String drugs;
  // List<dynamic> deviceToken;
  bool isActive;

  Map<String, dynamic> toJson() => {
        'fullAddress': fullAddress.toJson(),
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'birthDate':
            birthDate != null ? birthDate!.toIso8601String() : birthDate,
        'gender': gender,
        'height': height,
        'photos': List<dynamic>.from(photos.map((x) => x)),
        'isProfileCompleted': isProfileCompleted,
        'ethnicity': ethnicity,
        'sexuality': sexuality,
        'work': work,
        'jobTitle': jobTitle,
        'aboutYourSelf': aboutYourSelf,
        'educationLevel': educationLevel,
        'religious': religious,
        'homeTown': homeTown,
        'languageSpoken': languageSpoken,
        'datingIntentions': datingIntentions,
        'relationType': relationType,
        'drinking': drinking,
        'smoking': smoking,
        'drugs': drugs,
        // 'deviceToken': List<dynamic>.from(deviceToken.map((x) => x)),
        'isActive': isActive,
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
