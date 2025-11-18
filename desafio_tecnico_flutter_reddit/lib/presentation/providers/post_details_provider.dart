import 'package:flutter/material.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/repositories/reddit_repository.dart';

enum DetailsViewState { initial, loading, success, error }

class PostDetailsProvider extends ChangeNotifier {
  final RedditRepository repository;

  PostDetailsProvider({required this.repository});

  DetailsViewState _state = DetailsViewState.initial;
  List<CommentEntity> _comments = [];
  String _errorMessage = '';

  DetailsViewState get state => _state;
  List<CommentEntity> get comments => _comments;
  String get errorMessage => _errorMessage;

  Future<void> fetchComments(String permalink) async {
    _state = DetailsViewState.loading;
    _comments = [];
    notifyListeners();

    try {
      _comments = await repository.getPostComments(permalink);
      _state = DetailsViewState.success;
    } catch (e) {
      _state = DetailsViewState.error;
      _errorMessage = 'Erro ao carregar comentários: $e';
    }

    notifyListeners();
  }
}
