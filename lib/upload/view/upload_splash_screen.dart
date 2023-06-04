import 'dart:io';

import 'package:flutter/material.dart';
import 'package:howlook/upload/Provider/review_upload_provider.dart';
import 'package:howlook/upload/Provider/select_photo_provider.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/upload/model/image_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:howlook/upload/view/feed_upload_screen.dart';
import 'package:howlook/upload/view/review_upload_screen.dart';

class UploadSplashScreen extends ConsumerStatefulWidget {
  const UploadSplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UploadSplashScreen> createState() => _UploadSplashScreenState();
}

class _UploadSplashScreenState extends ConsumerState<UploadSplashScreen> {
  // Upload Image URL
  final List<ImageInfoModel> uploadImageInfos = [];

  // FireBase - Storage
  final storage = FirebaseStorage.instance;
  late Reference storageRef;

  // FireBase - Database
  final database = FirebaseFirestore.instance;
  late CollectionReference databaseRef;

  Future<void> initUpload() async {
    // 1. 리스트로 파일 경로 다 불러오기
    List<String> imagePaths = await filesPath();

    // 2. 해당 파일 경로를 기반으로 파일 불러와서 파이어베이스에 업로드하기
    for (String imagePath in imagePaths) {
      uploadImageInfos
          .add(await uploadImage(imagePath, imagePath.split('/').last));
    }

    // 3. 파일 경로를 Realtime Database에 저장하기
    await setDatabase();

    // 4
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ref.watch(isReviewUpload)
            ? const ReviewUploadScreen()
            : const FeedUploadScreen(),
      ),
    );
  }

  // 1
  Future<ImageInfoModel> uploadImage(String imagePath, String imageName) async {
    File file = File(imagePath);
    try {
      storageRef = storage.ref("before_FaceDetection/$imageName");
      await storageRef.putFile(file);
      String downloadURL = await storageRef.getDownloadURL();

      ImageInfoModel imageInfo =
          ImageInfoModel(name: imageName, path: downloadURL);
      return imageInfo;
    } on FirebaseException catch (e) {
      ImageInfoModel imageInfo = ImageInfoModel(name: '', path: '');
      return imageInfo;
    }
  }

  // 2
  Future<List<String>> filesPath() async {
    return ref
        .read(selectedImageProvider.notifier)
        .state
        .map((e) => e.path)
        .toList();
  }

  // 3
  Future<void> setDatabase() async {
    databaseRef = database.collection('images');

    final imageData = <String, dynamic>{
      "isDetected": false,
      "paths": uploadImageInfos.map((e) => e.toMap()).toList()
    };

    databaseRef.add(imageData);
  }

  @override
  void initState() {
    super.initState();
    initUpload();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBarBackgroundColor: Colors.black,
      appBarForegroundColor: Colors.white,
      backgroundColor: Colors.black,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "이미지 처리 중",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontFamily: 'NotoSans',
              ),
            ),
            SizedBox(height: 16.0),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
