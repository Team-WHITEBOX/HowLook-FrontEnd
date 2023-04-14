import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/user/model/signup_model.dart';

final SignupProvider =
    StateNotifierProvider<SignupStateNotifier, List<SignupModel>>(
        (ref) => SignupStateNotifier());

class SignupStateNotifier extends StateNotifier<List<SignupModel>> {
  SignupStateNotifier() : super([SignupModel()]);

  void addMemberAccount({
    required String memberId,
    required String memberPassword,
  }) {
    state[0] = state[0].copyWith(
      memberId: memberId,
      memberPassword: memberPassword,
    );
  }

  void clear() {}

  void outputSignupModel() {
    final SignupModel model = state[0];
    print('Member ID: ${model.memberId}');
    print('Member Password: ${model.memberPassword}');
    print('Name: ${model.name}');
    print('NickName: ${model.nickName}');
    print('Phone: ${model.phone}');
    print('Height: ${model.height}');
    print('Weight: ${model.weight}');
    print('Birthday: ${model.birthDay}');
    print('Gender: ${model.gender}');
  }
}
