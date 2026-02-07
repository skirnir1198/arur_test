import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_project/providers.dart';

class HomeWidget extends ConsumerStatefulWidget {
  const HomeWidget({
    super.key,
    required this.headerItems,
    required this.pageTitle,
    required this.url,
  });

  final List<String> headerItems;
  final String pageTitle;
  final String url;

  @override
  ConsumerState<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends ConsumerState<HomeWidget> {
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
    // Watch the provider specific to this pageTitle
    final selectedHeaderIndex = ref.watch(
      headerIndexProvider(widget.pageTitle),
    );

    return Column(
      children: [
        // Horizontal Scrollable Header (conditionally rendered)
        if (widget.headerItems.isNotEmpty)
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.headerItems.length,
              itemBuilder: (context, index) {
                final bool isSelected = index == selectedHeaderIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      // Update Riverpod state
                      ref
                              .read(
                                headerIndexProvider(widget.pageTitle).notifier,
                              )
                              .state =
                          index;

                      final String headerText = widget.headerItems[index];
                      // Demo logic: Use the provided base URL for the first item (usually 'Home' or similar),
                      // and use Google Search for others to show distinct content.
                      // Or just search for everything to be consistent?
                      // Let's try: if index == 0, go back to widget.url. Else search.

                      if (index == 0) {
                        _controller.loadRequest(Uri.parse(widget.url));
                      } else {
                        // Simple demo URL generation
                        final String query = Uri.encodeComponent(headerText);
                        final String demoUrl =
                            'https://www.google.com/search?q=$query';
                        _controller.loadRequest(Uri.parse(demoUrl));
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.headerItems[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Colors.black : Colors.grey,
                          ),
                        ),
                        if (isSelected)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 2,
                            width: 20,
                            color: Colors.black,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        // WebView Content
        Expanded(child: WebViewWidget(controller: _controller)),
      ],
    );
  }
}
