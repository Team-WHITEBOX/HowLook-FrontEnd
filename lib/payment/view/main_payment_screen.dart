import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/view/payment/payment_screen.dart';
import '../provider/payment_provider.dart';

class MainPaymentScreen extends ConsumerStatefulWidget {
  const MainPaymentScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MainPaymentScreen> createState() =>
      _MainFeedMoreVertScreenState();
}

class _MainFeedMoreVertScreenState extends ConsumerState<MainPaymentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final amount = ref.watch(paymentProvider);

    return Column(
      children: [
        const SizedBox(height: 6),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 24, left: 32, right: 32, bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "보유 루비",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () async {},
                        child: Text(
                          amount.currRuby.toString(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "충전할 루비",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen()),
                          );
                        },
                        child: Text(
                          amount.ruby.toString(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(color: Colors.black12, height: 1),
            GestureDetector(
              onTap: () async {
                ref.read(paymentProvider.notifier).addToken(10);
              },
              child: Container(
                height: 64,
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 8, bottom: 8),
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      children: <Widget>[
                        Image.asset('asset/img/ruby/ruby.png'),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SizedBox(
                                height: 28,
                                child: Text(
                                  "+ 10 루비",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 28,
                                child: Text(
                                  "KRW 1,000",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(color: Colors.black12, height: 1),
            GestureDetector(
              onTap: () async {
                ref.read(paymentProvider.notifier).addToken(100);
              },
              child: Container(
                height: 64,
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 8, bottom: 8),
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      children: <Widget>[
                        ExtendedImage.asset("asset/img/ruby/ruby.png"),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SizedBox(
                                height: 28,
                                child: Text(
                                  "+ 100 루비",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 28,
                                child: Text(
                                  "KRW 10,000",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(color: Colors.black12, height: 1),
            GestureDetector(
              onTap: () async {
                ref.read(paymentProvider.notifier).addToken(1000);
              },
              child: Container(
                height: 64,
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 8, bottom: 8),
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      children: <Widget>[
                        ExtendedImage.asset("asset/img/ruby/ruby.png"),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SizedBox(
                                height: 28,
                                child: Text(
                                  "+ 1000 루비",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 28,
                                child: Text(
                                  "KRW 100,000",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(color: Colors.black12, height: 1),
            GestureDetector(
              onTap: () async {
                ref.read(paymentProvider.notifier).clear();
              },
              child: Container(
                height: 64,
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 8, bottom: 8),
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      children: const <Widget>[
                        SizedBox(width: 4),
                        Icon(Icons.delete_forever, color: Colors.red, size: 40),
                        SizedBox(width: 24),
                        SizedBox(
                          height: 28,
                          child: Text(
                            "초기화",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(color: Colors.black12, height: 1),
          ],
        ),
      ],
    );
  }
}
