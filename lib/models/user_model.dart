// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str) as Map<String, dynamic>);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.roleId,
    required this.firstname,
    required this.lastname,
    required this.branchId,
    required this.profileImage,
    required this.isCustomer,
    required this.priceGroupId,
    required this.isAdmin,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['user_id'].toString(),
        username: json['username'].toString(),
        email: json['email'].toString(),
        roleId: json['role_id'].toString(),
        firstname: json['firstname'].toString(),
        lastname: json['lastname'].toString(),
        branchId: json['branch_id'].toString(),
        profileImage: json['profile_image'].toString(),
        isCustomer: json['is_customer'].toString(),
        priceGroupId: json['price_group_id'].toString(),
        isAdmin: int.parse(json['is_admin'].toString()),
      );

  String userId;
  String username;
  String email;
  String roleId;
  String firstname;
  String lastname;
  String branchId;
  String profileImage;
  String isCustomer;
  String priceGroupId;
  int isAdmin;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_id': userId,
        'username': username,
        'email': email,
        'role_id': roleId,
        'firstname': firstname,
        'lastname': lastname,
        'branch_id': branchId,
        'profile_image': profileImage,
        'is_customer': isCustomer,
        'price_group_id': priceGroupId,
        'is_admin': isAdmin,
      };
}
