import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/upload/Provider/select_photo_provider.dart';
import 'package:howlook/upload/component/album_header_widget.dart';
import 'package:howlook/upload/component/scroll_notification_widget.dart';
import 'package:howlook/upload/view/upload_image_edited_screen.dart';

class TUploadScreen extends ConsumerStatefulWidget {
  const TUploadScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TUploadScreen> createState() => _TUploadScreenState();
}

class _TUploadScreenState extends ConsumerState<TUploadScreen> {
  @override
  void initState() {
    super.initState();
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
                child: Icon(Icons.arrow_forward_rounded)),
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
