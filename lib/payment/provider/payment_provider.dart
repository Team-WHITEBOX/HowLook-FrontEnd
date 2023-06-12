import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../payment_model.dart';
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
            amount: 0,
            ruby: 0,
            impUid: '',
          ),
        );

  addToken(int ruby) {
    int total = state.ruby + ruby;

    state = state.copyWith(
      ruby: total,
      amount: total * 10,
    );
  }

  addUid(String impUid) {
    state = state.copyWith(
      impUid: impUid,
    );
  }

  // clear() {
  //   stt
  // }

  chargeToken() async {
    final resp = await paymentRepository.postCharge(state);
  }
}
