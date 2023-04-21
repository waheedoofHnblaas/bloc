class ProfileImage {
  ProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });

  ProfileImage.fromJson(dynamic json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  late String small;
  late String medium;
  late String large;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['small'] = small;
    map['medium'] = medium;
    map['large'] = large;
    return map;
  }
}
