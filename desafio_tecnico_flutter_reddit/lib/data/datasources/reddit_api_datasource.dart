import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../models/comment_model.dart';

class RedditApiDataSource {
  final http.Client client;

  RedditApiDataSource({required this.client});

  Future<List<PostModel>> getSubredditPosts(String subreddit) async {
    final uri = Uri.parse('https://www.reddit.com/r/$subreddit/hot.json');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List children = data['data']['children'];

      return children.map((item) => PostModel.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao carregar subreddit: ${response.statusCode}');
    }
  }

  Future<List<CommentModel>> getPostComments(String permalink) async {
    final uri = Uri.parse('https://www.reddit.com$permalink.json');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List rawList = json.decode(response.body);

      final commentsListing = rawList[1]['data']['children'] as List;

      List<CommentModel> comments = [];

      for (var item in commentsListing) {
        if (item['kind'] == 't1') {
          comments.add(CommentModel.fromJson(item));
        }
      }
      return comments;
    } else {
      throw Exception('Erro ao carregar comentários');
    }
  }
}
