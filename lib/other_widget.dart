import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:new_project/providers.dart';

class OtherWidget extends ConsumerWidget {
  const OtherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the URL provider
    final currentUrl = ref.watch(otherTabUrlProvider);

    // If a URL is set, show the WebView
    if (currentUrl != null) {
      return _OtherWebView(url: currentUrl);
    }

    // Otherwise, show the menu (Grid + List)
    return Column(
      children: [
        // Top Half: 2x2 Grid taking remaining space
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildGridButton(
                      context,
                      ref,
                      'マイページ',
                      Colors.orange[100]!,
                      'https://google.com/search?q=mypage',
                    ),
                    _buildGridButton(
                      context,
                      ref,
                      '新規会員登録',
                      Colors.orange[200]!,
                      'https://google.com/search?q=registration',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildGridButton(
                      context,
                      ref,
                      'SNS',
                      Colors.orange[300]!,
                      'https://twitter.com',
                    ),
                    _buildGridButton(
                      context,
                      ref,
                      '閲覧履歴',
                      Colors.orange[400]!,
                      'https://google.com/search?q=history',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Bottom Half: ListView sizing to content with padding
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildListItem(
                context,
                ref,
                '利用規約',
                'https://google.com/search?q=terms',
              ),
              _buildListItem(
                context,
                ref,
                'プライバシーポリシー',
                'https://google.com/search?q=privacy',
              ),
              _buildListItem(
                context,
                ref,
                'お問い合わせ',
                'https://google.com/search?q=contact',
              ),
              _buildListItem(
                context,
                ref,
                '特定商取引法に基づく表記',
                'https://google.com/search?q=law',
              ),
              _buildListItem(
                context,
                ref,
                'アプリバージョン',
                'https://google.com/search?q=version',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(
    BuildContext context,
    WidgetRef ref,
    String title,
    String url,
  ) {
    return ListTile(
      leading: const Icon(Icons.star),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        ref.read(otherTabUrlProvider.notifier).state = url;
      },
    );
  }

  Widget _buildGridButton(
    BuildContext context,
    WidgetRef ref,
    String label,
    Color color,
    String url,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              // Set the URL to trigger WebView display
              ref.read(otherTabUrlProvider.notifier).state = url;
            },
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OtherWebView extends ConsumerStatefulWidget {
  final String url;
  const _OtherWebView({required this.url});

  @override
  ConsumerState<_OtherWebView> createState() => _OtherWebViewState();
}

class _OtherWebViewState extends ConsumerState<_OtherWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
