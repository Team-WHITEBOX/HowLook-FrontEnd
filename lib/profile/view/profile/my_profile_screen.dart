import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/layout/default_layout.dart';
import '../../component/my_profile_card.dart';
import '../../provider/profile_provider.dart';

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

    return DefaultLayout(
      title: 'My Look',
      child: SingleChildScrollView(
        child: MainProfileCard.fromModel(model: item),
      ),
    );
  }
}
