import 'package:flutter_riverpod/flutter_riverpod.dart';

// ボトムナビゲーションのインデックスを管理するプロバイダー
final navigationIndexProvider = StateProvider<int>((ref) => 0);

// ヘッダー選択のインデックスを管理するプロバイダー。
// .familyを使用して、各タブ（pageTitleで識別）ごとに固有の状態を作成します。
final headerIndexProvider = StateProvider.family<int, String>(
  (ref, pageTitle) => 0,
);

// 「その他」タブのWebView URLを管理するプロバイダー。
// nullの場合、メニュー（グリッド/リスト）が表示されます。nullでない場合、WebViewが表示されます。
final otherTabUrlProvider = StateProvider<String?>((ref) => null);
