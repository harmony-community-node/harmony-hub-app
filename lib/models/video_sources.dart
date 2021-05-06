class VideoSource {
  VideoSource({
    this.docId,
    this.title,
    this.description,
    this.videoDatetime,
    this.projectId,
    this.thumbnailURL,
    this.videoProvider,
    this.videoSource,
    this.videoUrl,
  });
  final String docId;
  final String title;
  final String description;
  final DateTime videoDatetime;
  final String thumbnailURL;
  final String videoProvider;
  final String projectId;
  final String videoSource;
  final String videoUrl;
}
