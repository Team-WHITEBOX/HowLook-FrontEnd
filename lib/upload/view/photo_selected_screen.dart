import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Provider/get_image_provider.dart';
import '../Provider/review_upload_provider.dart';
import '../Provider/select_photo_provider.dart';
import '../component/album_header_widget.dart';
import '../component/scroll_notification_widget.dart';
import 'upload_image_edited_screen.dart';

class PhotoSelectScreen extends ConsumerStatefulWidget {
  const PhotoSelectScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PhotoSelectScreen> createState() => _PhotoSelectScreenState();
}

class _PhotoSelectScreenState extends ConsumerState<PhotoSelectScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(getImageProvider.notifier).checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    final selectedStateRead = ref.read(selectedImageProvider.notifier);
    final selectedState = ref.watch(selectedImageProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const AlbumHeader(),
        leading: GestureDetector(
          onTap: () {
            // 상태 초기화
            ref.read(isReviewUpload.notifier).update((state) => false);
            selectedStateRead.clearImage();
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.close),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              if (selectedState.isNotEmpty) {
                selectedState[0].isSelected = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UploadImageEditedScreen(),
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
      ),
      backgroundColor: Colors.black,
      body: const SafeArea(
        child: ScrollPhoto(),
      ),
    );
  }
}
