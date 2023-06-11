import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/repository/profile_repository.dart';
import '../model/sign_up/sign_up_model.dart';
import '../repository/sign_up_repository.dart';

final idCheckProvider = StateProvider<bool>((ref) => false);

final idNicknameProvider = StateProvider<bool>((ref) => false);

final signUpProvider = StateNotifierProvider<SignUpStateNotifier, SignUpModel>(
  (ref) {
    final signUpRepository = ref.watch(signUpRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    final notifier = SignUpStateNotifier(
      signUpRepository: signUpRepository,
        profileRepository: profileRepository,
    );
    return notifier;
  },
);

class SignUpStateNotifier extends StateNotifier<SignUpModel> {
  final SignUpRepository signUpRepository;
  final ProfileRepository profileRepository;

  SignUpStateNotifier({
    required this.signUpRepository,
    required this.profileRepository,
  }) : super(SignUpModel(
          memberId: "",
          memberPassword: "",
          memberPasswordCheck: "",
          name: "",
          nickName: "",
          phone: "",
          height: 0,
          weight: 0,
          birthDay: "",
          gender: "",
        ));

  addMemberId({
    required String memberId,
  }) {
    state = state.copyWith(memberId: memberId);
  }

  addMemberPassword({
    required String memberPassword,
  }) {
    state = state.copyWith(memberPassword: memberPassword);
  }

  addMemberPasswordCheck({
    required String memberPasswordCheck,
  }) {
    state = state.copyWith(memberPasswordCheck: memberPasswordCheck);
  }

  addMemberName({
    required String memberName,
  }) {
    state = state.copyWith(name: memberName);
  }

  addMemberNickName({
    required String memberNickName,
  }) {
    state = state.copyWith(nickName: memberNickName);
  }

  addMemberPhone({
    required String memberPhone,
  }) {
    state = state.copyWith(phone: memberPhone);
  }

  addMemberHeight({
    required int memberHeight,
  }) {
    state = state.copyWith(height: memberHeight);
  }

  addMemberWeight({
    required int memberWeight,
  }) {
    state = state.copyWith(weight: memberWeight);
  }

  addMemberBirthday({
    required String memberBirthday,
  }) {
    state = state.copyWith(birthDay: memberBirthday);
  }

  addMemberGender({
    required String memberGender,
  }) {
    state = state.copyWith(gender: memberGender);
  }

  void clear() {
    state = SignUpModel();
  }

  Future<bool> postJoin() async {
    final code = await signUpRepository.postJoin(signupModel: state);

    if (code.response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> socialEdit() async {
    final code = await profileRepository.socialEdit(
        signupModel: SignUpModel(
      name: state.name,
      nickName: state.nickName,
      phone: state.phone,
      height: state.height,
      weight: state.weight,
      birthDay: state.birthDay,
    ));

    if (code.response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
