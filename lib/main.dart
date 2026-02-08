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

  // このウィジェットはアプリケーションのルート（根本）です。
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // デバッグバナーを非表示にする
      title: 'Flutter Demo',
      theme: ThemeData(
        // アプリケーションのテーマ設定
        // colorSchemeはColors.deepPurpleをシード（種）として生成されます
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
        type:
            BottomNavigationBarType.fixed, // 項目が増えてもラベルが隠れたりずれたりしないように固定タイプを指定

        onTap: (index) {
          ref.read(navigationIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
