import '../../domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.id,
    required super.author,
    required super.body,
    required super.score,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return CommentModel(
      id: data['id'] ?? '',
      author: data['author'] ?? '[deleted]',
      body: data['body'] ?? '[removed]',
      score: data['score'] ?? 0,
    );
  }
}
