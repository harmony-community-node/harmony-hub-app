class TwitterFeed {
  TwitterFeed({
    this.tweetText,
    this.userName,
    this.tweetId,
    this.userId,
    this.profilePicURL,
    this.dateTime,
    this.projectCode,
  });
  final String tweetText;
  final String userName;
  final int tweetId;
  final String userId;
  final String profilePicURL;
  final DateTime dateTime;
  final String projectCode;
}
