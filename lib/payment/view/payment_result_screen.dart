import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/payment/model/payment_model.dart';

import '../provider/payment_provider.dart';
import '../repository/payment_repository.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  Future<void> postPaymentResult(Map<String, dynamic> result) async {
    final repo = ref.watch(paymentRepositoryProvider);
    final amount = ref.watch(paymentProvider);

    if (result['imp_uid'] != null && result['merchant_uid'] != null) {
      await repo.postCharge(amount);
    } else {
      // return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final result =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return DefaultLayout(
      title: "HowLook Payment Result",
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 200),
              Column(
                children: const [
                  Text(
                    "결제를 마무리 하려면",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "완료를 눌러 주세요",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(180, 70),
                    alignment: Alignment.center,
                    textStyle: const TextStyle(fontSize: 30)),
                onPressed: () async {
                  await ref
                      .read(paymentProvider.notifier)
                      .addUid(result['imp_uid']);
                  await postPaymentResult(result);
                  await ref.read(paymentProvider.notifier).getCurrRuby();
                  await ref.read(paymentProvider.notifier).clear();
                  Navigator.pop(context);
                },
                child: const Text("완료"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
