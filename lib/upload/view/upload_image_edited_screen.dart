import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/upload/Provider/select_photo_provider.dart';
import 'package:howlook/upload/component/horizon_photo_widget.dart';
import 'package:howlook/upload/view/temp_screen.dart';
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
    final selectedState = ref.watch(SelectedImageProvider);
    final selectedStateRead = ref.read(SelectedImageProvider.notifier);
    var width = MediaQuery.of(context).size.width;
    var globalKey = new GlobalKey();

    return DefaultLayout(
      title: "",
      appBarBackgroundColor: Colors.black,
      appBarForegroundColor: Colors.white,
      backgroundColor: Colors.black,
      actions: [
        GestureDetector(
          onTap: () async {
            var renderObject = globalKey.currentContext?.findRenderObject();
            // 파일 저장될 경로
            final directory = (await getApplicationDocumentsDirectory()).path;
            // 파일 저장될 이름 - 중복 X
            String fileName = "${DateTime.now().millisecondsSinceEpoch}.png";

            if (renderObject is RenderRepaintBoundary) {
              var boundary = renderObject;
              ui.Image image = await boundary.toImage();
              ByteData? byteData =
                  await image.toByteData(format: ui.ImageByteFormat.png);
              Uint8List pngBytes = byteData!.buffer.asUint8List();
              File imgFile = File('$directory/$fileName');
              imgFile.writeAsBytes(pngBytes);
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TempScreen(path: '$directory/$fileName'),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.arrow_forward_ios_rounded),
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
                    selectedStateRead.hasValue()
                        ? selectedState
                            .firstWhere((element) => element.isSelected)
                            .image
                        : selectedState[0].image,
                  ),
                  initialScale: PhotoViewComputedScale.contained * 1.4,
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
