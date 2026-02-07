import 'package:flutter/material.dart';
import 'package:new_project/home_widget.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_project/providers.dart';
import 'package:new_project/other_widget.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeWidget(
      pageTitle: 'Home',
      headerItems: ['ホーム', '新着情報', 'お知らせ'],
      url: 'https://flutter.dev',
    ),
    HomeWidget(
      pageTitle: 'Shopping',
      headerItems: [
        'クラフト感あふれるアイテム',
        '新着アイテム',
        '送料無料・おためし',
        'お店のこだわりアイテム',
        'Instagramで紹介',
        '先月の売れ筋ランキング',
        'メディアで紹介',
      ],
      url: 'https://google.com',
    ),
    HomeWidget(
      pageTitle: 'Content',
      headerItems: [
        '今日は何の日',
        '知って好きになるアルルのお店',
        '全国の隠れた名物',
        'スタッフセレクト',
        '季節のギフト',
        'あるる探検隊の記事',
        '推しアイテムレポート',
        'お役立ち情報',
        '最新ニュースから探すあるるアイテム',
      ],
      url: 'https://pub.dev',
    ),
    HomeWidget(
      pageTitle: 'Favorites',
      headerItems: [],
      url: 'https://news.google.com',
    ),
    const OtherWidget(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);
    final otherTabUrl = ref.watch(otherTabUrlProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        leading: (selectedIndex == 4 && otherTabUrl != null)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.read(otherTabUrlProvider.notifier).state = null;
                },
              )
            : null,
      ),
      body: IndexedStack(index: selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '買い物',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'コンテンツ'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'お気に入り'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'その他'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.deepPurple,
        type: BottomNavigationBarType
            .fixed, // Ensure unrelated items don't shift or hide labels
        onTap: (index) {
          ref.read(navigationIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
