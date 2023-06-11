import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/profile/model/profile/profile_edit_model.dart';

import '../repository/profile_repository.dart';

final editNicknameProvider = StateProvider<bool>((ref) => false);

final profileEditProvider =
    StateNotifierProvider<ProfileStateNotifier, ProfileEditModel>(
  (ref) {
    final repository = ref.watch((profileRepositoryProvider));
    final notifier = ProfileStateNotifier(repository: repository);
    return notifier;
  },
);

class ProfileStateNotifier extends StateNotifier<ProfileEditModel> {
  final ProfileRepository repository;

  ProfileStateNotifier({
    required this.repository,
  }) : super(
          ProfileEditModel(
            memberId: '',
            memberNickName: '',
            memberPhone: '',
            memberHeight: 0,
            memberWeight: 0,
          ),
        ) {
    getExistingProfileData();
  }

  addMemberNickName({
    required String memberNickName,
  }) {
    state = state.copyWith(memberNickName: memberNickName);
  }

  addMemberPhone({
    required String memberPhone,
  }) {
    state = state.copyWith(memberPhone: memberPhone);
  }

  addMemberHeight({
    required int memberHeight,
  }) {
    state = state.copyWith(memberHeight: memberHeight);
  }

  addMemberWeight({
    required int memberWeight,
  }) {
    state = state.copyWith(memberWeight: memberWeight);
  }

  getExistingProfileData() async {
    final resp = await repository.getProfileData();
    state = resp.data;
  }

  Future<bool> updateProfileData() async {
    final resp = await repository.updateProfileData(
        profileEditModel: ProfileEditModel(
      memberNickName: state.memberNickName,
      memberPhone: state.memberPhone,
      memberHeight: state.memberHeight,
      memberWeight: state.memberWeight,
    ));

    return resp.response.statusCode == 200 ? true : false;
  }
}
