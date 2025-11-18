import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/reddit_repository.dart';

enum ViewState { initial, loading, success, error }

class SubredditProvider extends ChangeNotifier {
  final RedditRepository repository;

  SubredditProvider({required this.repository});

  ViewState _state = ViewState.initial;
  List<PostEntity> _posts = [];
  String _currentSubreddit = 'flutterdev'; // Padrão

  ViewState get state => _state;
  List<PostEntity> get posts => _posts;

  Future<void> fetchPosts({String? subreddit}) async {
    if (subreddit != null) _currentSubreddit = subreddit;

    _state = ViewState.loading;
    notifyListeners();

    try {
      _posts = await repository.getSubredditPosts(_currentSubreddit);
      _state = ViewState.success;
    } catch (e) {
      _state = ViewState.error;
    }
    notifyListeners();
  }
}
