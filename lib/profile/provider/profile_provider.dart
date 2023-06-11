import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/params/my_profile_params.dart';
import '../model/profile/profile_model.dart';
import '../repository/profile_repository.dart';

final profileProvider =
    StateNotifierProvider.family<ProfileStateNotifier, ProfileModel, String>(
  (ref, memberId) {
    final repository = ref.watch((profileRepositoryProvider));
    final notifier =
        ProfileStateNotifier(repository: repository, memberId: memberId);
    return notifier;
  },
);

class ProfileStateNotifier extends StateNotifier<ProfileModel> {
  final String memberId;
  final ProfileRepository repository;

  ProfileStateNotifier({
    required this.memberId,
    required this.repository,
  }) : super(
          ProfileModel(
            memberId: "",
            memberNickName: "",
            memberHeight: 0,
            memberWeight: 0,
            profilePhoto: "",
            memberPostCount: 0,
            memberPosts: [],
          ),
        );

  getUserInfoData() async {
    MyProfileParams myProfileParams = MyProfileParams(memberId: memberId);

    final resp = await repository.getMyProfile(
      memberId,
      myProfileParams: myProfileParams,
    );

    state = resp.data;
  }
}
