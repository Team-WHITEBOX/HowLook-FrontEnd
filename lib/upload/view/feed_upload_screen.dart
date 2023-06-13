import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:extended_image/extended_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/component/cust_textform_filed.dart';
import '../../common/layout/default_layout.dart';
import '../../common/view/root_tab.dart';
import '../Provider/loading_provider.dart';
import '../Provider/select_photo_provider.dart';

class FeedUploadScreen extends ConsumerStatefulWidget {
  const FeedUploadScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedUploadScreen> createState() => _FeedUploadScreenState();
}

class _FeedUploadScreenState extends ConsumerState<FeedUploadScreen> {
  final formKey = GlobalKey<FormState>();

  // FireBase - Storage
  final storage = FirebaseStorage.instance;
  late Reference storageRef;
  // FireBase - Database
  final database = FirebaseFirestore.instance;
  late CollectionReference databaseRef;
  // Upload Model

  // 위치 정보 불러오기
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<void> getPhoto() async {
    await getFaceDetectionImage();
  }

  Future<void> getFaceDetectionImage() async {
    final selectedState = ref.watch(selectedImageProvider);
    String dir = (await getApplicationDocumentsDirectory()).path;

    database.collection('images').snapshots().listen(
      (event) {
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
                    print(value['name']);
                    print('$dir/${value['name']}');
                    ref.read(selectedImageProvider.notifier).setFaceDetection(
                          e,
                          value['name'],
                          value['path'],
                          '$dir/${value['name']}',
                        );
                  } else {
                    return e;
                  }
                }).toList();
              });
              break;
          }
        }
      },
    );
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
    getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    final selectedState = ref.watch(selectedImageProvider);
    final newPostState = ref.watch(newPostInfoProvider);
    final styleState = ref.watch(styleInfoProvider);
    PageController controller = PageController();

    return Stack(
      children: [
        DefaultLayout(
          title: "새로운 게시글",
          appBarBackgroundColor: Colors.white,
          appBarForegroundColor: Colors.black,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              ref
                  .read(newPostInfoProvider.notifier)
                  .toggleLoadingIndicator(false);
              ref.read(styleInfoProvider.notifier).clear();
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
                if (formKey.currentState!.validate()) {
                  final styleState = ref.watch(styleInfoProvider);
                  final newPostState = ref.watch(newPostInfoProvider);

                  var gps = await getCurrentLocation();
                  formKey.currentState?.save();

                  ref
                      .read(newPostInfoProvider.notifier)
                      .toggleLoadingIndicator(true);

                  newPostState.uploadModel.latitude = gps.latitude;
                  newPostState.uploadModel.longitude = gps.longitude;
                  newPostState.uploadModel.hashtagAmekaji =
                      styleState[0].isSelected;
                  newPostState.uploadModel.hashtagMinimal =
                      styleState[1].isSelected;
                  newPostState.uploadModel.hashtagCasual =
                      styleState[2].isSelected;
                  newPostState.uploadModel.hashtagStreet =
                      styleState[3].isSelected;
                  newPostState.uploadModel.hashtagSporty =
                      styleState[4].isSelected;
                  newPostState.uploadModel.hashtagGuitar =
                      styleState[5].isSelected;

                  final List<dio.MultipartFile> files = selectedState.map((e) {
                    return dio.MultipartFile.fromFileSync(
                        e.afterDetectionInPath!);
                  }).toList();

                  // API 전송
                  final resp = await ref
                      .read(selectedImageProvider.notifier)
                      .feedUploadImage(newPostState.uploadModel, files);

                  if (resp.response.statusCode == 200) {
                    // 상태 초기화
                    ref.read(selectedImageProvider.notifier).clearImage();
                    // LoadingIndicator false로 초기화
                    ref.read(newPostInfoProvider.notifier).clearState();

                    if (!mounted) return;
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const RootTab(),
                      ),
                      (route) => false,
                    );
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.portrait_sharp, color: Colors.blueAccent),
              ),
            ),
          ],
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: PageView.builder(
                      controller: controller,
                      itemBuilder: (BuildContext context, int index) {
                        if (selectedState[0].afterDetectionOutPath == "") {
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
                          selectedState[index].afterDetectionOutPath!,
                          fit: BoxFit.cover,
                          cache: true,
                        );
                      },
                      itemCount: selectedState.length,
                    ),
                  ),
                  const SizedBox(height: 13),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          title("한줄 소개"),
                          const SizedBox(height: 12),
                          line(),
                          SizedBox(
                            height: 180,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: CustomTextFormField(
                                maxLines: 5,
                                isBorder: false,
                                hintText: "당신에 대해서 소개해주세요 :)",
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
                          line(),
                          const SizedBox(height: 12),
                          title("스타일"),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              height: 30,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      print(index);
                                      print(styles[index].styleName);
                                      ref
                                          .read(styleInfoProvider.notifier)
                                          .selectedStyle(
                                              styles[index].styleName);
                                    },
                                    child: Container(
                                      width: 90,
                                      decoration: BoxDecoration(
                                        color: styleState[index].color,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          styleState[index].styleName,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(width: 5),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
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
