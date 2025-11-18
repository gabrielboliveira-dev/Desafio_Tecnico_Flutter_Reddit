import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/reddit_repository.dart';
import '../datasources/reddit_api_datasource.dart';

class RedditRepositoryImpl implements RedditRepository {
  final RedditApiDataSource dataSource;

  RedditRepositoryImpl({required this.dataSource});

  @override
  Future<List<PostEntity>> getSubredditPosts(String subreddit) async {
    try {
      return await dataSource.getSubredditPosts(subreddit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CommentEntity>> getPostComments(String permalink) async {
    try {
      return await dataSource.getPostComments(permalink);
    } catch (e) {
      rethrow;
    }
  }
}
