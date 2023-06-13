import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../common/const/data.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/secure_storage/secure_storage.dart';
import '../../../manager/provider/manager_feed_provider.dart';
import '../../../manager/view/manager_root_screen.dart';
import '../../../user/model/token/token_model.dart';
import '../../../user/view/signin/intro_screen.dart';
import '../../repository/profile_repository.dart';
import '../payment/payment_screen.dart';
import 'profile_change_screen.dart';

class SettingScreen extends ConsumerStatefulWidget {
  final String memberId;

  const SettingScreen({
    required this.memberId,
    super.key,
  });

  @override
  ConsumerState<SettingScreen> createState() => _SettingList();
}

class _SettingList extends ConsumerState<SettingScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.memberId);
  }

  @override
  Widget build(BuildContext context) {
    final profileRepo = ref.watch(profileRepositoryProvider);

    return DefaultLayout(
      title: 'Howlook Setting',
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ListTile(
            leading: const Icon(
              MdiIcons.accountDetails,
              color: Colors.black,
            ),
            title: const Text('프로필 수정'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileChangeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.payment,
              color: Colors.black,
            ),
            title: const Text('루비 결제'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              MdiIcons.headphones,
              color: Colors.black,
            ),
            title: const Text('고객센터'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              MdiIcons.bellRing,
              color: Colors.black,
            ),
            title: const Text('알림설정'),
            onTap: () {},
          ),
          widget.memberId == "admin"
              ? ListTile(
                  leading: const Icon(Icons.info, color: Colors.black),
                  title: const Text('신고 기능'),
                  onTap: () {
                    ref
                        .read(managerFeedProvider.notifier)
                        .paginate(forceRefetch: true);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ManagerRootScreen(),
                      ),
                    );
                  },
                )
              : Container(),
          ListTile(
            leading: const Icon(
              MdiIcons.logout,
              color: Colors.black,
            ),
            title: const Text('로그아웃'),
            onTap: () async {
              final storage = ref.watch(secureStorageProvider);
              final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
              final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

              TokenModel tokenModel = TokenModel(
                accessToken: accessToken!,
                refreshToken: refreshToken!,
              );

              final resp = await profileRepo.logout(tokenModel: tokenModel);

              if (resp.response.statusCode == 200) {
                await storage.deleteAll();
                if (!mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => IntroScreen(),
                  ),
                  (route) => false,
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(
              MdiIcons.delete,
              color: Colors.black,
            ),
            title: const Text('회원탈퇴'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
