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
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/view/root_tab.dart';
import 'package:howlook/upload/Provider/loading_provider.dart';
import 'package:howlook/upload/Provider/select_photo_provider.dart';
import 'package:howlook/upload/model/upload_formdata_model.dart';
import 'package:path_provider/path_provider.dart';

class TempScreen extends ConsumerStatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends ConsumerState<TempScreen> {
  // FireBase - Storage
  final storage = FirebaseStorage.instance;
  late Reference storageRef;

  // FireBase - Database
  final database = FirebaseFirestore.instance;
  late CollectionReference databaseRef;

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

  static void downloadCallback(
      String id, int status, int progress) {
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
    final selectedState = ref.watch(selectedImageProvider);
    final selectedStateRead = ref.read(selectedImageProvider.notifier);
    final newPostState = ref.watch(newPostInfoProvider);
    final isLoadingStateRead = ref.read(loadingIndicatorProvider.notifier);
    PageController controller = PageController();
    late UploadModel uploadModel = UploadModel();
    final formKey = GlobalKey<FormState>();

    return Stack(
      children: [
        DefaultLayout(
          title: "새로운 게시글",
          appBarBackgroundColor: Colors.white,
          appBarForegroundColor: Colors.black,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              newPostState.loadingIndicator = false;
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
                newPostState.loadingIndicator = true;

                var gps = await getCurrentLocation();
                formKey.currentState?.save();

                // newPostState.uploadModel.hashtagAmekaji = st
                uploadModel.hashtagAmekaji = styles[0].isSelected;
                uploadModel.hashtagMinimal = styles[1].isSelected;
                uploadModel.hashtagCasual = styles[2].isSelected;
                uploadModel.hashtagStreet = styles[3].isSelected;
                uploadModel.hashtagSporty = styles[4].isSelected;
                uploadModel.hashtagGuitar = styles[5].isSelected;

                uploadModel.latitude = gps.latitude;
                uploadModel.longitude = gps.longitude;

                final List<dio.MultipartFile> files = selectedState
                    .map((e) =>
                    dio.MultipartFile.fromFileSync(e.afterDetectionInPath!))
                    .toList();

                // API 전송
                final resp =
                await selectedStateRead.uploadImage(uploadModel, files);

                if (resp.response.statusCode == 200) {
                  // 상태 초기화
                  selectedStateRead.clearImage();
                  // isLoadingState 초기화
                  isLoadingStateRead.update((state) => true);
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        title("한줄 소개"),
                        const SizedBox(height: 12),
                        line(),
                        SizedBox(
                          height: 180,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CustomTextFormField(
                              maxLines: 5,
                              isBorder: false,
                              hintText: "당신에 대해서 소개해주세요 :)",
                              onSaved: (value) {
                                uploadModel.content = value;
                              },
                              validator: (value) {
                                return null;
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

                                  },
                                  child: Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: !styles[index].isSelected!
                                          ? Colors.black45
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        styles[index].styleName,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'NotoSans'),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) =>
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
        Offstage(
          offstage: !isLoadingStateRead.state,
          child: Stack(children: <Widget>[
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
          ],),
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
            fontFamily: 'NotoSans',
            fontWeight: FontWeight.w500),
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

class Style {
  final String styleName;
  bool? isSelected;

  Style({this.isSelected = false, required this.styleName});
}

final List<Style> styles = <Style>[
  Style(styleName: '# 아메카지'),
  Style(styleName: '# 미니멀'),
  Style(styleName: '# 캐주얼'),
  Style(styleName: '# 스트릿'),
  Style(styleName: '# 스포티'),
  Style(styleName: '# 기타'),
];
