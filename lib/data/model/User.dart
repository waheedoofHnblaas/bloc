import 'Links.dart';
import 'ProfileImage.dart';
import 'Social.dart';

class User {
  User({
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.twitterUsername,
    required this.portfolioUrl,
    required this.bio,
    required this.location,
    required this.links,
    required this.profileImage,
    required this.instagramUsername,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
    required this.acceptedTos,
    required this.forHire,
    required this.social,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    links = (json['links'] != null ? Links.fromJson(json['links']) : null)!;
    profileImage = (json['profile_image'] != null
        ? ProfileImage.fromJson(json['profile_image'])
        : null)!;
    instagramUsername = json['instagram_username'];
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    acceptedTos = json['accepted_tos'];
    forHire = json['for_hire'];
    social = (json['social'] != null ? Social.fromJson(json['social']) : null)!;
  }

  late String? id;
  late String? updatedAt;
  late String? username;
  late String? name;
  late String? firstName;
  late String? lastName;
  late dynamic twitterUsername;
  late String? portfolioUrl;
  late String? bio;
  late String? location;
  late Links links;
  late ProfileImage profileImage;
  late String? instagramUsername;
  late int totalCollections;
  late int totalLikes;
  late int totalPhotos;
  late bool acceptedTos;
  late bool forHire;
  late Social social;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['id'] = id;
    map['updated_at'] = updatedAt;
    map['username'] = username;
    map['name'] = name;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['twitter_username'] = twitterUsername;
    map['portfolio_url'] = portfolioUrl;
    map['bio'] = bio;
    map['location'] = location;
    if (links != null) {
      map['links'] = links.toJson();
    }
    if (profileImage != null) {
      map['profile_image'] = profileImage.toJson();
    }
    map['instagram_username'] = instagramUsername;
    map['total_collections'] = totalCollections;
    map['total_likes'] = totalLikes;
    map['total_photos'] = totalPhotos;
    map['accepted_tos'] = acceptedTos;
    map['for_hire'] = forHire;
    if (social != null) {
      map['social'] = social.toJson();
    }
    return map;
  }
}
