import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/post_entity.dart';
import '../providers/subreddit_provider.dart';
import '../providers/post_details_provider.dart';
import '../widgets/post_card.dart';

class SubredditPage extends StatefulWidget {
  const SubredditPage({Key? key}) : super(key: key);

  @override
  State<SubredditPage> createState() => _SubredditPageState();
}

class _SubredditPageState extends State<SubredditPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubredditProvider>().fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reddit: r/flutterdev'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Consumer<SubredditProvider>(
        builder: (context, provider, child) {
          if (provider.state == ViewState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.state == ViewState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Erro ao carregar posts'),
                  ElevatedButton(
                    onPressed: () => provider.fetchPosts(),
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          if (provider.state == ViewState.success) {
            return RefreshIndicator(
              onRefresh: () => provider.fetchPosts(),
              child: ListView.builder(
                itemCount: provider.posts.length,
                itemBuilder: (context, index) {
                  final post = provider.posts[index];
                  return PostCard(
                    post: post,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsPage(post: post),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class PostDetailsPage extends StatefulWidget {
  final PostEntity post;

  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostDetailsProvider>().fetchComments(widget.post.permalink);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.post.subreddit)),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (widget.post.thumbnail != null)
                  Center(
                    child: SizedBox(
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: widget.post.thumbnail!,
                        fit: BoxFit.contain,
                        errorWidget: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  widget.post.selfText ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Comentários',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Consumer<PostDetailsProvider>(
              builder: (context, provider, child) {
                if (provider.state == DetailsViewState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.state == DetailsViewState.error) {
                  return Center(child: Text(provider.errorMessage));
                }
                if (provider.comments.isEmpty) {
                  return const Center(child: Text('Nenhum comentário.'));
                }

                return ListView.builder(
                  itemCount: provider.comments.length,
                  itemBuilder: (context, index) {
                    final comment = provider.comments[index];
                    return ListTile(
                      title: Text(
                        'u/${comment.author} • ${comment.score} pts',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                      subtitle: Text(comment.body),
                      isThreeLine: true,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
