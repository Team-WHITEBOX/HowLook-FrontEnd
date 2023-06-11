import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:howlook/profile/provider/profile_provider.dart';

import '../../common/const/data.dart';
import '../../common/layout/default_layout.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../component/my_profile_card.dart';
import '../model/user_info_model.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  final String memberId;

  const MyProfileScreen({
    required this.memberId,
    super.key,
  });

  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final item = ref.watch(profileProvider(widget.memberId));
    // print(item.memberPostCount);
    // print(item.memberPosts);

    return DefaultLayout(
      title: 'My Look',
      child: SingleChildScrollView(
        child: MainProfileCard.fromModel(model: item),
      ),
    );
  }
}
