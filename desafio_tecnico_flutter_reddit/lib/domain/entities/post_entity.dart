class PostEntity {
  final String id;
  final String title;
  final String author;
  final String subreddit;
  final int score;
  final int numComments;
  final String? thumbnail;
  final String? selfText;
  final String permalink;
  final String url;

  PostEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.subreddit,
    required this.score,
    required this.numComments,
    this.thumbnail,
    this.selfText,
    required this.permalink,
    required this.url,
  });

  bool get isImage =>
      url.endsWith('.jpg') || url.endsWith('.png') || url.endsWith('.gif');
}
