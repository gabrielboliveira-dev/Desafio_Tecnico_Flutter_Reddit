import '../entities/post_entity.dart';
import '../entities/comment_entity.dart';

abstract class RedditRepository {
  Future<List<PostEntity>> getSubredditPosts(String subreddit);
  Future<List<CommentEntity>> getPostComments(String permalink);
}
