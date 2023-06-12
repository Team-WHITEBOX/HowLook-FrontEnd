import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/payment_model.dart';
import '../repository/payment_repository.dart';

final paymentProvider =
    StateNotifierProvider<PaymentStateNotifier, PaymentModel>(
  (ref) {
    final paymentRepository = ref.watch(paymentRepositoryProvider);
    final notifier = PaymentStateNotifier(paymentRepository: paymentRepository);
    return notifier;
  },
);

class PaymentStateNotifier extends StateNotifier<PaymentModel> {
  final PaymentRepository paymentRepository;

  PaymentStateNotifier({
    required this.paymentRepository,
  }) : super(
          PaymentModel(
            currRuby: 0,
            amount: 0,
            ruby: 0,
            impUid: '',
          ),
        ) {
    getCurrRuby();
  }

  getCurrRuby() async {
    final resp = await paymentRepository.getCurrentRuby();
    state = state.copyWith(currRuby: resp.data.ruby);
  }

  addToken(int ruby) {
    int total = state.ruby + ruby;

    state = state.copyWith(
      ruby: total,
      amount: total * 100,
    );
  }

  addUid(String impUid) {
    state = state.copyWith(
      impUid: impUid,
    );
  }

  clear() {
    state = PaymentModel(
      currRuby: state.currRuby,
      amount: 0,
      ruby: 0,
      impUid: "",
    );
  }

  chargeToken() async {
    final resp = await paymentRepository.postCharge(state);
  }
}
