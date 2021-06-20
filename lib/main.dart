import 'package:flutter/material.dart';
import 'package:infinite_scroll/ajaxprovider/ajaxprovider.dart';
import 'package:infinite_scroll/ajaxprovider/provider_infinite_scroll_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(providers:
  [
    ChangeNotifierProvider(create: (_) => AjaxProvider())
  ],
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider',
      home: ProviderInfiniteScrollScreen(),
    );
  }
}
