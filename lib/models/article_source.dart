class ArticleSource {
  ArticleSource({
    this.docId,
    this.title,
    this.publishedDate,
    this.updatedDate,
    this.projectId,
    this.description,
    this.thumbnailUrl,
    this.provider,
    this.url,
    this.source,
  });
  final String docId;
  final DateTime updatedDate;
  final DateTime publishedDate;
  final String title;
  final String description;
  final String url;
  final String thumbnailUrl;
  final String projectId;
  final String source;
  final String provider;
}
