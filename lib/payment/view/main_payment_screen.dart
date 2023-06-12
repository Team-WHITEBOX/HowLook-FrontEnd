import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                        onTap: () async {
                          // if (!widget.isScrapped) {
                          //   final code = await repo.postScrap(widget.postId);
                          //   if (code.response.statusCode == 200) {
                          //     ref
                          //         .read(mainFeedProvider.notifier)
                          //         .getDetail(postId: widget.postId);
                          //     Navigator.pop(context);
                          //   } else {
                          //     return;
                          //   }
                          // } else {
                          //   final code = await repo.delScrap(widget.postId);
                          //   if (code.response.statusCode == 200) {
                          //     ref
                          //         .read(mainFeedProvider.notifier)
                          //         .getDetail(postId: widget.postId);
                          //     Navigator.pop(context);
                          //   } else {
                          //     return;
                          //   }
                          // }
                        },
                        child: const Text(
                          "500",
                          style: TextStyle(
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
                          // if (!widget.isScrapped) {
                          //   final code = await repo.postScrap(widget.postId);
                          //   if (code.response.statusCode == 200) {
                          //     ref
                          //         .read(mainFeedProvider.notifier)
                          //         .getDetail(postId: widget.postId);
                          //     Navigator.pop(context);
                          //   } else {
                          //     return;
                          //   }
                          // } else {
                          //   final code = await repo.delScrap(widget.postId);
                          //   if (code.response.statusCode == 200) {
                          //     ref
                          //         .read(mainFeedProvider.notifier)
                          //         .getDetail(postId: widget.postId);
                          //     Navigator.pop(context);
                          //   } else {
                          //     return;
                          //   }
                          // }
                        },
                        child: Text(
                          amount.ruby.toString(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
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
                          width: MediaQuery.of(context).size.width * 0.73,
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
                                  "KRW 100",
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
                          width: MediaQuery.of(context).size.width * 0.73,
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
                                  "KRW 1000",
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
                          width: MediaQuery.of(context).size.width * 0.73,
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
                                  "KRW 10000",
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
          ],
        ),
      ],
    );
  }
}
