import 'dart:convert';

class UserData {
    int? statusCode;
    User? data;
    String? message;
    bool? success;

    UserData({
        this.statusCode,
        this.data,
        this.message,
        this.success,
    });

    factory UserData.fromRawJson(String str) => UserData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        statusCode: json["statusCode"],
        data: json["data"] == null ? null : User.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data?.toJson(),
        "message": message,
        "success": success,
    };
}

class User {
    String? id;
    String? email;
    String? firstName;
    String? lastName;
    String? avatarUrl;
    List<dynamic>? reels;
    String? provider;
    List<dynamic>? rewards;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? token;

    User({
        this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.avatarUrl,
        this.reels,
        this.provider,
        this.rewards,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.token,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatarUrl: json["avatarUrl"],
        reels: json["reels"] == null ? [] : List<dynamic>.from(json["reels"]!.map((x) => x)),
        provider: json["provider"],
        rewards: json["rewards"] == null ? [] : List<dynamic>.from(json["rewards"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "avatarUrl": avatarUrl,
        "reels": reels == null ? [] : List<dynamic>.from(reels!.map((x) => x)),
        "provider": provider,
        "rewards": rewards == null ? [] : List<dynamic>.from(rewards!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "token": token,
    };

  void then(Null Function(dynamic _) param0) {}
}
