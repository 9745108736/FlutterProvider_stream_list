import 'dart:convert';

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.uname,
    this.panchayath,
    this.district,
    this.ward,
    this.isVolunteer,
    this.profileId,
    this.userToken,
    this.loginStatus,
    this.result,
  });

  bool status;
  String uname;
  String panchayath;
  String district;
  String ward;
  bool isVolunteer;
  String profileId;
  String userToken;
  int loginStatus;
  Result result;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"] == null ? null : json["status"],
        uname: json["uname"] == null ? null : json["uname"],
        panchayath: json["panchayath"] == null ? null : json["panchayath"],
        district: json["district"] == null ? null : json["district"],
        ward: json["ward"] == null ? null : json["ward"],
        isVolunteer: json["is_volunteer"] == null ? null : json["is_volunteer"],
        profileId: json["profile_id"] == null ? null : json["profile_id"],
        userToken: json["user_token"] == null ? null : json["user_token"],
        loginStatus: json["login_status"] == null ? null : json["login_status"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "uname": uname == null ? null : uname,
        "panchayath": panchayath == null ? null : panchayath,
        "district": district == null ? null : district,
        "ward": ward == null ? null : ward,
        "is_volunteer": isVolunteer == null ? null : isVolunteer,
        "profile_id": profileId == null ? null : profileId,
        "user_token": userToken == null ? null : userToken,
        "login_status": loginStatus == null ? null : loginStatus,
        "result": result == null ? null : result.toJson(),
      };
}

class Result {
  Result({
    this.data,
    this.id,
    this.caps,
    this.capKey,
    this.roles,
    this.allcaps,
    this.filter,
  });

  Data data;
  int id;
  Caps caps;
  String capKey;
  List<String> roles;
  Map<String, bool> allcaps;
  dynamic filter;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        id: json["ID"] == null ? null : json["ID"],
        caps: json["caps"] == null ? null : Caps.fromJson(json["caps"]),
        capKey: json["cap_key"] == null ? null : json["cap_key"],
        roles: json["roles"] == null
            ? null
            : List<String>.from(json["roles"].map((x) => x)),
        allcaps: json["allcaps"] == null
            ? null
            : Map.from(json["allcaps"])
                .map((k, v) => MapEntry<String, bool>(k, v)),
        filter: json["filter"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "ID": id == null ? null : id,
        "caps": caps == null ? null : caps.toJson(),
        "cap_key": capKey == null ? null : capKey,
        "roles": roles == null ? null : List<dynamic>.from(roles.map((x) => x)),
        "allcaps": allcaps == null
            ? null
            : Map.from(allcaps).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "filter": filter,
      };
}

class Caps {
  Caps({
    this.pendingUser,
    this.bbpParticipant,
  });

  bool pendingUser;
  bool bbpParticipant;

  factory Caps.fromJson(Map<String, dynamic> json) => Caps(
        pendingUser: json["pending_user"] == null ? null : json["pending_user"],
        bbpParticipant:
            json["bbp_participant"] == null ? null : json["bbp_participant"],
      );

  Map<String, dynamic> toJson() => {
        "pending_user": pendingUser == null ? null : pendingUser,
        "bbp_participant": bbpParticipant == null ? null : bbpParticipant,
      };
}

class Data {
  Data({
    this.id,
    this.userLogin,
    this.userPass,
    this.userNicename,
    this.userEmail,
    this.userUrl,
    this.userRegistered,
    this.userActivationKey,
    this.userStatus,
    this.displayName,
    this.image,
  });

  String id;
  String userLogin;
  String userPass;
  String userNicename;
  String userEmail;
  String userUrl;
  DateTime userRegistered;
  String userActivationKey;
  String userStatus;
  String displayName;
  String image;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["ID"] == null ? null : json["ID"],
        userLogin: json["user_login"] == null ? null : json["user_login"],
        userPass: json["user_pass"] == null ? null : json["user_pass"],
        userNicename:
            json["user_nicename"] == null ? null : json["user_nicename"],
        userEmail: json["user_email"] == null ? null : json["user_email"],
        userUrl: json["user_url"] == null ? null : json["user_url"],
        userRegistered: json["user_registered"] == null
            ? null
            : DateTime.parse(json["user_registered"]),
        userActivationKey: json["user_activation_key"] == null
            ? null
            : json["user_activation_key"],
        userStatus: json["user_status"] == null ? null : json["user_status"],
        displayName: json["display_name"] == null ? null : json["display_name"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "user_login": userLogin == null ? null : userLogin,
        "user_pass": userPass == null ? null : userPass,
        "user_nicename": userNicename == null ? null : userNicename,
        "user_email": userEmail == null ? null : userEmail,
        "user_url": userUrl == null ? null : userUrl,
        "user_registered":
            userRegistered == null ? null : userRegistered.toIso8601String(),
        "user_activation_key":
            userActivationKey == null ? null : userActivationKey,
        "user_status": userStatus == null ? null : userStatus,
        "display_name": displayName == null ? null : displayName,
        "image": image == null ? null : image,
      };
}
