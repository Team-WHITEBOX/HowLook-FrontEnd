import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/params/my_profile_params.dart';
import '../model/user_info_model.dart';
import '../repository/profile_repository.dart';

final profileProvider =
    StateNotifierProvider.family<ProfileStateNotifier, UserInfoModel, String>(
  (ref, memberId) {
    final repository = ref.watch((profileRepositoryProvider));
    final notifier =
        ProfileStateNotifier(repository: repository, memberId: memberId);
    return notifier;
  },
);

class ProfileStateNotifier extends StateNotifier<UserInfoModel> {
  final String memberId;
  final ProfileRepository repository;

  ProfileStateNotifier({
    required this.memberId,
    required this.repository,
  }) : super(
          UserInfoModel(
            memberId: "",
            memberNickName: "",
            memberHeight: 0,
            memberWeight: 0,
            profilePhoto: "",
          ),
        );

  getUserInfoData() async {
    MyProfileParams myProfileParams = MyProfileParams(memberId: memberId);

    final data = await repository.getMyProfile(
      memberId,
      myProfileParams: myProfileParams,
    );

    state = data.data;
  }
}
