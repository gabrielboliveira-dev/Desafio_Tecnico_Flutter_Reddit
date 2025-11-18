import '../../domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.id,
    required super.title,
    required super.author,
    required super.subreddit,
    required super.score,
    required super.numComments,
    super.thumbnail,
    super.selfText,
    required super.permalink,
    required super.url,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    String? thumb = data['thumbnail'];
    if (thumb != null &&
        (thumb == 'self' || thumb == 'default' || thumb.isEmpty)) {
      thumb = null;
    }

    return PostModel(
      id: data['id'],
      title: data['title'] ?? 'Sem título',
      author: data['author'] ?? 'anônimo',
      subreddit: data['subreddit'],
      score: data['score'] ?? 0,
      numComments: data['num_comments'] ?? 0,
      thumbnail: thumb,
      selfText: data['selftext'],
      permalink: data['permalink'],
      url: data['url'] ?? '',
    );
  }
}
