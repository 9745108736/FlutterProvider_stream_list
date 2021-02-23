import 'dart:convert';

ListPostModel listPostModelFromJson(String str) =>
    ListPostModel.fromJson(json.decode(str));

String listPostModelToJson(ListPostModel data) => json.encode(data.toJson());

class ListPostModel {
  ListPostModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<PostListData> data;
  String message;

  factory ListPostModel.fromJson(Map<String, dynamic> json) => ListPostModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<PostListData>.from(
                json["data"].map((x) => PostListData.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
      };
}

class PostListData {
  PostListData({
    this.id,
    this.profileId,
    this.topicId,
    this.postType,
    this.title,
    this.shareLink,
    this.content,
    this.location,
    this.details,
    this.postDate,
    this.postDateUtc,
    this.comments,
    this.image,
    this.video,
    this.myReact,
    this.reactDetails,
    this.reacts,
    this.settings,
  });

  int id;
  int profileId;
  String topicId;
  String postType;
  String title;
  String shareLink;
  String content;
  Location location;
  Details details;
  DateTime postDate;
  DateTime postDateUtc;
  int comments;
  String image;
  String video;
  String myReact;
  List<String> reactDetails;
  List<React> reacts;
  Settings settings;

  factory PostListData.fromJson(Map<String, dynamic> json) => PostListData(
        id: json["ID"] == null ? null : json["ID"],
        profileId: json["profile_id"] == null ? null : json["profile_id"],
        topicId: json["topic_id"] == null ? null : json["topic_id"],
        postType: json["post_type"] == null ? null : json["post_type"],
        title: json["title"] == null ? null : json["title"],
        shareLink: json["share_link"] == null ? null : json["share_link"],
        content: json["content"] == null ? null : json["content"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        postDate: json["post_date"] == null
            ? null
            : DateTime.parse(json["post_date"]),
        postDateUtc: json["post_date_utc"] == null
            ? null
            : DateTime.parse(json["post_date_utc"]),
        comments: json["comments"] == null ? null : json["comments"],
        image: json["image"] == null ? null : json["image"],
        video: json["video"] == null ? null : json["video"],
        myReact: json["my_react"] == null ? null : json["my_react"],
        reactDetails: json["react_details"] == null
            ? null
            : List<String>.from(json["react_details"].map((x) => x)),
        reacts: json["reacts"] == null
            ? null
            : List<React>.from(json["reacts"].map((x) => React.fromJson(x))),
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "profile_id": profileId == null ? null : profileId,
        "topic_id": topicId == null ? null : topicId,
        "post_type": postType == null ? null : postType,
        "title": title == null ? null : title,
        "share_link": shareLink == null ? null : shareLink,
        "content": content == null ? null : content,
        "location": location == null ? null : location.toJson(),
        "details": details == null ? null : details.toJson(),
        "post_date": postDate == null ? null : postDate.toIso8601String(),
        "post_date_utc":
            postDateUtc == null ? null : postDateUtc.toIso8601String(),
        "comments": comments == null ? null : comments,
        "image": image == null ? null : image,
        "video": video == null ? null : video,
        "my_react": myReact == null ? null : myReact,
        "react_details": reactDetails == null
            ? null
            : List<dynamic>.from(reactDetails.map((x) => x)),
        "reacts": reacts == null
            ? null
            : List<dynamic>.from(reacts.map((x) => x.toJson())),
        "settings": settings == null ? null : settings.toJson(),
      };
}

class Details {
  Details({
    this.id,
    this.name,
    this.image,
    this.isVolunteer,
  });

  int id;
  String name;
  String image;
  String isVolunteer;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        isVolunteer: json["is_volunteer"] == null ? null : json["is_volunteer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "is_volunteer": isVolunteer == null ? null : isVolunteer,
      };
}

class Location {
  Location({
    this.lat,
    this.lon,
    this.address,
  });

  String lat;
  String lon;
  String address;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"] == null ? null : json["lat"],
        lon: json["lon"] == null ? null : json["lon"],
        address: json["address"] == null ? null : json["address"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "address": address == null ? null : address,
      };
}

class React {
  React({
    this.rc,
    this.cn,
  });

  String rc;
  int cn;

  factory React.fromJson(Map<String, dynamic> json) => React(
        rc: json["rc"] == null ? null : json["rc"],
        cn: json["cn"] == null ? null : json["cn"],
      );

  Map<String, dynamic> toJson() => {
        "rc": rc == null ? null : rc,
        "cn": cn == null ? null : cn,
      };
}

class Settings {
  Settings({
    this.shareStoryStatus,
    this.shareGroupStatus,
    this.commentAllowed,
  });

  String shareStoryStatus;
  String shareGroupStatus;
  String commentAllowed;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        shareStoryStatus: json["share_story_status"] == null
            ? null
            : json["share_story_status"],
        shareGroupStatus: json["share_group_status"] == null
            ? null
            : json["share_group_status"],
        commentAllowed:
            json["comment_allowed"] == null ? null : json["comment_allowed"],
      );

  Map<String, dynamic> toJson() => {
        "share_story_status":
            shareStoryStatus == null ? null : shareStoryStatus,
        "share_group_status":
            shareGroupStatus == null ? null : shareGroupStatus,
        "comment_allowed": commentAllowed == null ? null : commentAllowed,
      };
}

class TypeOfPost {
  static String photo = "photo";
  static String video = "video";
  static String text = "text";
}
