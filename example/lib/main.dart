import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reels_viewer/reels_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reels Viewer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Reel> reelsList = [];

  @override
  Widget build(BuildContext context) {
    return ReelsViewer(
      reelsList: reelsList,
      appbarTitle: 'Instagram Reels',
      onShare: (url) {
        log('Shared reel url ==> $url');
      },
      onLike: (url) {
        log('Liked reel url ==> $url');
      },
      onFollow: () {
        log('======> Clicked on follow <======');
      },
      onComment: (comment) {
        log('Comment on reel ==> $comment');
      },
      onClickMoreBtn: () {
        log('======> Clicked on more option <======');
      },
      onClickBackArrow: () {
        log('======> Clicked on back arrow <======');
      },
      onIndexChanged: (index) {
        log('======> Current Index ======> $index <========');
      },
      showProgressIndicator: true,
      showVerifiedTick: true,
      showAppbar: true,
    );
  }
}
