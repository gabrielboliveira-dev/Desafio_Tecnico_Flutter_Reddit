import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/post_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  final VoidCallback onTap;

  const PostCard({Key? key, required this.post, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scoreFormatter = NumberFormat.compact();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'r/${post.subreddit} • u/${post.author}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (post.thumbnail != null) ...[
                    const SizedBox(width: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: post.thumbnail!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.arrow_upward,
                    size: 16,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 4),
                  Text(scoreFormatter.format(post.score)),
                  const SizedBox(width: 16),
                  const Icon(Icons.comment, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text('${post.numComments}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
