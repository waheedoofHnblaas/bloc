class Social {
  Social({
      required this.instagramUsername,
      required this.portfolioUrl,
      this.twitterUsername, 
      this.paypalEmail,});

  Social.fromJson(dynamic json) {
    instagramUsername = json['instagram_username'];
    portfolioUrl = json['portfolio_url'];
    twitterUsername = json['twitter_username'];
    paypalEmail = json['paypal_email'];
  }
  late String? instagramUsername;
  late String? portfolioUrl;
  late dynamic twitterUsername;
  late dynamic paypalEmail;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['instagram_username'] = instagramUsername;
    map['portfolio_url'] = portfolioUrl;
    map['twitter_username'] = twitterUsername;
    map['paypal_email'] = paypalEmail;
    return map;
  }

}