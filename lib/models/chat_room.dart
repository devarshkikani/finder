import 'dart:convert';

ChatRoom? chatRoomFromJson(String str) =>
    ChatRoom.fromJson(json.decode(str) as Map<String, dynamic>);

String chatRoomToJson(ChatRoom? data) => json.encode(data!.toJson());

class ChatRoom {
  ChatRoom({
    required this.id,
    required this.user,
  });
  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        id: json['_id'].toString(),
        user: User.fromJson(json['user'] as Map<String, dynamic>),
      );

  String? id;
  late User user;

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'user': user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photos,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'].toString(),
        firstName: json['firstName'].toString(),
        lastName: json['lastName'].toString(),
        photos: json['photos'] == null
            ? <String>[]
            : List<String>.from(
                (json['photos'] as List<dynamic>).map((dynamic x) => x)),
      );

  String? id;
  String? firstName;
  String? lastName;
  List<String?>? photos;

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'photos': photos == null
            ? <String>[]
            : List<dynamic>.from(photos!.map((String? x) => x)),
      };
}
