import 'package:bloc_app/data/model/urlModel.dart';

import 'Links.dart';
import 'User.dart';
class ItemModel {
  ItemModel({
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.promotedAt,
      required this.width,
      required this.height,
      required this.color,
      required this.blurHash,
      required this.description,
      required this.altDescription,
      required this.urls,
      required this.links,
      required this.likes,
      required this.likedByUser,
      required this.currentUserCollections,
      required this.sponsorship,
      required this.topicSubmissions,
      required this.user,});

  ItemModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promotedAt = json['promoted_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    blurHash = json['blur_hash'];
    description = json['description'];
    altDescription = json['alt_description'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
    links = (json['links'] != null ? Links.fromJson(json['links']) : null)!;
    likes = json['likes'];
    likedByUser = json['liked_by_user'];
    // if (json['current_user_collections'] != null) {
    //
    //   json['current_user_collections'].forEach((v) {
    //     currentUserCollections.add(DynamicLibrary.process().fromJson(v));
    //   });
    // }
    currentUserCollections = [];
    sponsorship = json['sponsorship'];
    topicSubmissions = json['topic_submissions'];
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
  }
  late String? id;
  late String? createdAt;
  late String? updatedAt;
  late  String? promotedAt;
  late  int width;
  late  int height;
  late  String? color;
  late  String? blurHash;
  late  dynamic description;
  late  dynamic altDescription;
  late  Urls? urls;
  late Links links;
  late  int likes;
  late bool likedByUser;
  late List<dynamic> currentUserCollections;
  late  dynamic sponsorship;
  late  dynamic topicSubmissions;
  late User user;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['promoted_at'] = promotedAt;
    map['width'] = width;
    map['height'] = height;
    map['color'] = color;
    map['blur_hash'] = blurHash;
    map['description'] = description;
    map['alt_description'] = altDescription;
    if (urls != null) {
      map['urls'] = urls.toString();
    }
    if (links != null) {
      map['links'] = links.toJson();
    }
    map['likes'] = likes;
    map['liked_by_user'] = likedByUser;
    map['current_user_collections'] = currentUserCollections.map((v) => v.toJson()).toList();
    map['sponsorship'] = sponsorship;
    map['topic_submissions'] = topicSubmissions;
    map['user'] = user.toJson();
    return map;
  }

}