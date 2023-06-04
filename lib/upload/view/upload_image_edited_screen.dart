import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/upload/Provider/select_photo_provider.dart';
import 'package:howlook/upload/component/horizon_photo_widget.dart';
import 'package:howlook/upload/view/upload_splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/services.dart';

class UploadImageEditedScreen extends ConsumerStatefulWidget {
  const UploadImageEditedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UploadImageEditedScreen> createState() =>
      _UploadImageEditedScreenState();
}

class _UploadImageEditedScreenState
    extends ConsumerState<UploadImageEditedScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedState = ref.watch(selectedImageProvider);
    final selectedStateRead = ref.read(selectedImageProvider.notifier);
    var width = MediaQuery.of(context).size.width;
    var globalKey = new GlobalKey();

    Future<String> captureImage() async {
      // 파일 저장될 경로
      final directory = (await getApplicationDocumentsDirectory()).path;
      // 파일 저장될 이름 - 중복 X
      String fileName = "${DateTime.now().millisecondsSinceEpoch}.png";

      var renderObject = globalKey.currentContext?.findRenderObject();
      if (renderObject is RenderRepaintBoundary) {
        var boundary = renderObject;
        ui.Image image = await boundary.toImage(pixelRatio: 3.5);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List? pngBytes = byteData!.buffer.asUint8List();
        File imgFile = File('$directory/$fileName');
        imgFile.writeAsBytes(pngBytes);
      }

      return '$directory/$fileName';
    }

    return DefaultLayout(
      title: "",
      appBarBackgroundColor: Colors.black,
      appBarForegroundColor: Colors.white,
      backgroundColor: Colors.black,
      leading: GestureDetector(
        onTap: () {
          selectedStateRead.setEditedClear();
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            // 현재 사진 캡처 후 편집된 사진으로 정보 변경
            final String filePath = await captureImage();

            // 현재 Photo View에 떠있는 Photo Index
            final int currentImageIndex =
                selectedState.indexWhere((element) => element.isSelected);

            selectedStateRead.setEdited(
              selectedState[currentImageIndex],
              filePath,
            );

            // 2-1. 만약 리스트에 편집되지 않은 사진이 존재하거나, 현재 사진이 마지막 사진이 아닐 경우
            //   ㄴ 다음 사진을 Photo View에 띄우기
            if (selectedStateRead.hasEditedValue() ||
                (selectedState.length != currentImageIndex + 1)) {
              setState(() {
                selectedState[currentImageIndex].isSelected = false;
                selectedState[currentImageIndex + 1].isSelected = true;
              });
            }
            // 2-2. 리스트에 편집되지 않은 사진이 없고, 현재 사진이 마지막 사진일 경우
            //   ㄴ 업로드 스플래쉬 스크린으로 이동
            // 사진 리스트에서 편집되지 않은 사진이 존재하거나 현재 사진이 마지막 사진이 아닐 경우
            else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadSplashScreen(),
                ),
              );
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.arrow_forward_rounded),
          ),
        ),
      ],
      child: Column(
        children: [
          Container(
            width: width,
            height: width,
            color: Colors.black,
            child: RepaintBoundary(
              key: globalKey,
              child: ClipRect(
                child: PhotoView(
                  imageProvider: AssetEntityImageProvider(
                    selectedStateRead.hasSelectedValue()
                        ? selectedState
                            .firstWhere((element) => element.isSelected)
                            .image
                        : selectedState[0].image,
                  ),
                  initialScale: PhotoViewComputedScale.contained * 1.0,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  filterQuality: FilterQuality.high,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.black),
                ),
              ),
            ),
          ),
          HorizonPhoto(),
        ],
      ),
    );
  }
}
