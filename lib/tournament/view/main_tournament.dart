import 'package:flutter/material.dart';

import '../../common/layout/default_layout.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({super.key});

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "오늘의 토너먼트",
      appBarBackgroundColor: const Color(0xffEDF0F3),
      backgroundColor: const Color(0xffEDF0F3),
      child: Container(
        child: Text("HI"),
      ),
    );
  }
}
