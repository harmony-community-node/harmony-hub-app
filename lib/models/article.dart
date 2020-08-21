class Article {
  Article({this.order, this.title, this.publishedDate, this.updatedDate, this.articleUrl, this.description, this.imageUrl});
  final int order;
  final DateTime updatedDate;
  final DateTime publishedDate;
  final String title;
  final String description;
  final String articleUrl;
  final String imageUrl;
}
