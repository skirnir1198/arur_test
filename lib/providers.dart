import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the bottom navigation index
final navigationIndexProvider = StateProvider<int>((ref) => 0);

// Provider for the header selection index.
// Using .family to create a unique state for each tab (identified by pageTitle).
final headerIndexProvider = StateProvider.family<int, String>(
  (ref, pageTitle) => 0,
);

// Provider to manage the WebView URL for the 'Other' tab.
// If null, the menu (grid/list) is shown. If not null, the WebView is shown.
final otherTabUrlProvider = StateProvider<String?>((ref) => null);
