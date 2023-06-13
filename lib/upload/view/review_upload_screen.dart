import 'dart:isolate';
import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/component/cust_textform_filed.dart';
import '../../common/layout/default_layout.dart';
import '../../common/view/root_tab.dart';
import '../../payment/provider/payment_provider.dart';
import '../Provider/loading_provider.dart';
import '../Provider/select_photo_provider.dart';
import '../model/upload_formdata_model.dart';

class ReviewUploadScreen extends ConsumerStatefulWidget {
  const ReviewUploadScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ReviewUploadScreen> createState() => _ReviewUploadScreenState();
}

class _ReviewUploadScreenState extends ConsumerState<ReviewUploadScreen> {
  // FireBase - Storage
  final storage = FirebaseStorage.instance;
  late Reference storageRef;
  // FireBase - Database
  final database = FirebaseFirestore.instance;
  late CollectionReference databaseRef;

  Future<void> getPhoto() async {
    await getFaceDetectionImage();
  }

  Future<void> getFaceDetectionImage() async {
    final selectedState = ref.watch(selectedImageProvider);
    String dir = (await getApplicationDocumentsDirectory())
        .path; //path provider로 저장할 경로 가져오기

    database.collection('images').snapshots().listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.modified:
            change.doc.data()!['paths'].forEach((value) async {
              // 링크로 파일 로컬에 저장하기
              await FlutterDownloader.enqueue(
                url: value['path'], // file url
                savedDir: '$dir/', // 저장할 dir
                fileName: value['name'], // 파일명
                saveInPublicStorage: true, // 동일한 파일 있을 경우 덮어쓰기 없으면 오류발생함!
              );

              // 비식별 처리 후 링크 저장하기
              selectedState.map((e) {
                if (e.imageName == value['name']) {
                  ref.read(selectedImageProvider.notifier).setFaceDetection(
                      e, value['name'], value['path'], '$dir/${value['name']}');
                } else {
                  return e;
                }
              }).toList();
            });
            break;
        }
      }
    });
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    getPhoto();

    PageController controller = PageController();
    final newPostState = ref.watch(newPostInfoProvider);
    final selectedImage = ref.watch(selectedImageProvider);
    final currRuby = ref.watch(paymentProvider);

    return Stack(
      children: [
        DefaultLayout(
          title: "새로운 평가 게시글",
          appBarBackgroundColor: Colors.white,
          appBarForegroundColor: Colors.black,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              ref
                  .read(newPostInfoProvider.notifier)
                  .toggleLoadingIndicator(false);
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                // 토글 돌리기
                ref
                    .read(newPostInfoProvider.notifier)
                    .toggleLoadingIndicator(true);

                // 일단 일반 평가인지 크리에이터 평가인지 구분하기
                // 일반 평가면 한줄 소개가 없음
                if (newPostState.uploadModel.content.isEmpty) {
                  // 사진 불러오기
                  final List<dio.MultipartFile> files = selectedImage
                      .map((e) => dio.MultipartFile.fromFileSync(
                          e.afterDetectionInPath!))
                      .toList();

                  // API 전송
                  final resp = await ref
                      .read(selectedImageProvider.notifier)
                      .reviewUploadImage(newPostState.uploadModel, files);

                  if (resp.response.statusCode == 200) {
                    // 상태 초기화
                    ref.read(selectedImageProvider.notifier).clearImage();
                    // LoadingIndicator false로 초기화
                    ref
                        .read(newPostInfoProvider.notifier)
                        .toggleLoadingIndicator(false);

                    ref.read(newPostInfoProvider.notifier).clearState();

                    if (!mounted) return;
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => RootTab(),
                      ),
                      (route) => false,
                    );
                  }
                }
                // 크리에이터 평가면 한줄 소개가 있음
                else {
                  // 크리에이터 평가면 루비가 있는지 검사해야함
                  // 이건 try - catch로 감싸서 오류생기면 제출 불가하게 만들기
                  try {
                    // 사진 불러오기
                    final List<dio.MultipartFile> files = selectedImage
                        .map((e) => dio.MultipartFile.fromFileSync(
                            e.afterDetectionInPath!))
                        .toList();

                    // API 전송
                    final resp = await ref
                        .read(selectedImageProvider.notifier)
                        .creatorReviewUploadImage(
                            newPostState.uploadModel, files);

                    if (resp.response.statusCode == 200) {
                      // 상태 초기화
                      ref.read(selectedImageProvider.notifier).clearImage();
                      // LoadingIndicator false로 초기화
                      ref
                          .read(newPostInfoProvider.notifier)
                          .toggleLoadingIndicator(false);

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => RootTab(),
                        ),
                        (route) => false,
                      );
                    }
                  } catch (err) {
                    ref
                        .read(newPostInfoProvider.notifier)
                        .toggleLoadingIndicator(false);

                    showOkAlertDialog(
                        context: context,
                        title: "루비 부족",
                        message: "크리에이터 평가 업로드에 필요한 루비가 부족합니다!");
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.portrait_sharp,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    if (selectedImage[0].afterDetectionOutPath == "") {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                    return ExtendedImage.network(
                      selectedImage[index].afterDetectionOutPath!,
                      fit: BoxFit.cover,
                      cache: true,
                    );
                  },
                  itemCount: ref.watch(selectedImageProvider).length,
                ),
              ),
              const SizedBox(height: 13),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "* 평가를 받고 싶은 게시글을 업로드 해보세요!",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 12),
                      newPostState.uploadModel.content.isNotEmpty
                          ? rubyInfo(currRuby.currRuby)
                          : Container(),
                      Row(
                        children: [
                          title("한줄 소개"),
                          const Text(
                            "(한줄 소개 작성 시 크리에이터 평가로 전환됩니다.)",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      line(),
                      SizedBox(
                        height: 180,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CustomTextFormField(
                            maxLines: 2,
                            isBorder: false,
                            hintText: "크리에이터가 판단할 수 있도록 설명을 짧게 남겨주세요 :)",
                            onChanged: (String value) {
                              ref
                                  .read(newPostInfoProvider.notifier)
                                  .addContent(value);
                            },
                            onSaved: (value) {},
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                print("Hl");
                                return "내용을 입력해주세요";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Offstage(
          offstage: !(newPostState.loadingIndicator!),
          child: Stack(
            children: <Widget>[
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
              Center(
                child: SpinKitCubeGrid(
                  itemBuilder: (context, index) {
                    return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget rubyInfo(int ruby) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              title("루비 "),
              const Text(
                "(크리에이터 평가는 업로드시 20루비가 소모됩니다.)",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                "현재 보유 루비: $ruby",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  // 상태 초기화
                  ref.read(selectedImageProvider.notifier).clearImage();
                  // LoadingIndicator false로 초기화
                  ref
                      .read(newPostInfoProvider.notifier)
                      .toggleLoadingIndicator(false);

                  ref.read(newPostInfoProvider.notifier).clearState();

                  if (!mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => RootTab(isCharge: true),
                    ),
                    (route) => false,
                  );
                },
                child: const Text(
                  "충전하러가기",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget title(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget line() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 0,
        height: 1,
        color: Colors.black26,
      ),
    );
  }
}
