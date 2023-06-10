import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:howlook/upload/Provider/loading_provider.dart';
import 'package:howlook/upload/Provider/select_photo_provider.dart';
import 'package:howlook/upload/model/upload_formdata_model.dart';
import 'package:path_provider/path_provider.dart';

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
  // Upload Model
  UploadModel uploadModel = UploadModel();
  String content = "";

  Future<void> getPhoto() async {
    await getFaceDetectionImage();
  }

  Future<void> getFaceDetectionImage() async {
    final selectedState = ref.watch(selectedImageProvider);
    final selectedStateRead = ref.read(selectedImageProvider.notifier);
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
                  selectedStateRead.setFaceDetection(
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getPhoto();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

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
                ref
                    .read(newPostInfoProvider.notifier)
                    .toggleLoadingIndicator(true);

                final List<dio.MultipartFile> files = ref
                    .watch(selectedImageProvider)
                    .map((e) =>
                        dio.MultipartFile.fromFileSync(e.afterDetectionInPath!))
                    .toList();

                // API 전송
                final resp = await ref
                    .read(selectedImageProvider.notifier)
                    .reviewUploadImage(
                        ref.watch(newPostInfoProvider).uploadModel, files);

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
          child: SingleChildScrollView(
            child: AspectRatio(
              aspectRatio: 1,
              child: PageView.builder(
                controller: controller,
                itemBuilder: (BuildContext context, int index) {
                  if (ref.watch(selectedImageProvider)[0].afterDetectionOutPath ==
                      "") {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                  return ExtendedImage.network(
                    ref
                        .watch(selectedImageProvider)[index]
                        .afterDetectionOutPath!,
                    fit: BoxFit.cover,
                    cache: true,
                  );
                },
                itemCount: ref.watch(selectedImageProvider).length,
              ),
            ),
          ),
        ),
        Offstage(
          offstage: !(ref.watch(newPostInfoProvider).loadingIndicator!),
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
}
