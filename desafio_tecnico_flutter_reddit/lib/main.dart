import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/reddit_api_datasource.dart';
import 'data/repositories/reddit_repository_impl.dart';
import 'domain/repositories/reddit_repository.dart';
import 'presentation/providers/subreddit_provider.dart';
import 'presentation/providers/post_details_provider.dart';
import 'presentation/pages/subreddit_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(create: (_) => http.Client()),
        Provider<RedditApiDataSource>(
          create: (ctx) => RedditApiDataSource(client: ctx.read<http.Client>()),
        ),
        Provider<RedditRepository>(
          create: (ctx) =>
              RedditRepositoryImpl(dataSource: ctx.read<RedditApiDataSource>()),
        ),

        ChangeNotifierProvider(
          create: (ctx) =>
              SubredditProvider(repository: ctx.read<RedditRepository>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) =>
              PostDetailsProvider(repository: ctx.read<RedditRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Reddit Client',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepOrange,
        ),
        home: const SubredditPage(),
      ),
    );
  }
}
